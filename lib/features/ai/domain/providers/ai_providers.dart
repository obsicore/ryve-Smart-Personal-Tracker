import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/main.dart' show databaseProvider;
import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/core/services/ai_service.dart';
import 'package:hybrid_tracker/features/ai/data/models/ai_plan_item_model.dart';
import 'package:hybrid_tracker/features/ai/data/models/ai_plan_model.dart';
import 'package:hybrid_tracker/features/ai/data/models/coaching_insight_model.dart';
import 'dart:convert';

import 'package:hybrid_tracker/features/ai/data/repositories/ai_repository.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/tasks/domain/providers/task_providers.dart';

part 'ai_providers.g.dart';

const _uuid = Uuid();

final aiRepositoryProvider = Provider<AIRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return AIRepositoryImpl(db);
});

final aiServiceProvider = Provider<AIService>((ref) {
  final db = ref.watch(databaseProvider);
  return AIService(db);
});

String _uid(Ref ref) => ref.watch(authStateProvider).valueOrNull?.uid ?? '';

@riverpod
Future<AIPlanModel?> todayAIPlan(Ref ref) {
  return ref.watch(aiRepositoryProvider).getPlanForDate(_uid(ref), DateTime.now());
}

@riverpod
Stream<List<CoachingInsightModel>> coachingInsights(Ref ref) {
  return ref.watch(aiRepositoryProvider).watchActiveInsights(_uid(ref));
}

@riverpod
class AIPlannerNotifier extends _$AIPlannerNotifier {
  @override
  Future<AIPlanModel?> build() async {
    final userId = ref.watch(authStateProvider).valueOrNull?.uid ?? '';
    if (userId.isEmpty) return null;

    // Load cached plan for today
    final existing = await ref.read(aiRepositoryProvider).getPlanForDate(userId, DateTime.now());

    // Auto-generate if: no plan yet, OR plan is from a previous day, OR plan is >3h old
    final isStale = existing == null ||
        !_isSameDay(existing.planDate, DateTime.now()) ||
        DateTime.now().difference(existing.generatedAt).inHours >= 3;

    if (isStale) {
      final result = await ref.read(aiServiceProvider).generateDayPlan(userId, DateTime.now());
      lastGenerationUsedAI = result.usedAI;
      await ref.read(aiRepositoryProvider).savePlan(result.plan);
      ref.invalidate(todayAIPlanProvider);
      return result.plan;
    }

    // Check if any task was updated after plan was generated
    final tasks = await (_db(ref).select(_db(ref).tasks)
          ..where((t) => t.userId.equals(userId) & t.isCompleted.equals(false)))
        .get();
    tasksUpdatedAfterPlan = tasks.any(
      (t) => t.updatedAt.isAfter(existing.generatedAt),
    );

    return existing;
  }

  bool lastGenerationUsedAI = true;
  bool tasksUpdatedAfterPlan = false;

  AppDatabase _db(Ref ref) => ref.read(databaseProvider);

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  Future<void> generate() async {
    final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
    if (userId.isEmpty) return;
    state = const AsyncLoading();
    tasksUpdatedAfterPlan = false;
    final result = await ref.read(aiServiceProvider).generateDayPlan(userId, DateTime.now());
    lastGenerationUsedAI = result.usedAI;
    await ref.read(aiRepositoryProvider).savePlan(result.plan);
    state = AsyncData(result.plan);
    ref.invalidate(todayAIPlanProvider);
  }

  Future<void> regenerate() => generate();

  Future<void> acceptItem(String itemId) async {
    final plan = state.valueOrNull;
    if (plan == null) return;
    final item = plan.items.firstWhere((i) => i.id == itemId);
    await _createTimeBlockForItem(item);
    await ref.read(aiRepositoryProvider).setItemStatus(itemId, 'accepted');
    _refreshLocalState(itemId, 'accepted');
  }

  Future<void> rejectItem(String itemId) async {
    await ref.read(aiRepositoryProvider).setItemStatus(itemId, 'rejected');
    _refreshLocalState(itemId, 'rejected');
  }

  Future<void> acceptAll() async {
    final plan = state.valueOrNull;
    if (plan == null) return;
    for (final item in plan.items.where((i) => i.itemStatus == 'pending')) {
      await _createTimeBlockForItem(item);
      await ref.read(aiRepositoryProvider).setItemStatus(item.id, 'accepted');
    }
    final updated = plan.copyWith(
      items: plan.items
          .map((i) => i.itemStatus == 'pending' ? i.copyWith(itemStatus: 'accepted') : i)
          .toList(),
      acceptedAt: DateTime.now(),
    );
    state = AsyncData(updated);
  }

  void _refreshLocalState(String itemId, String status) {
    final plan = state.valueOrNull;
    if (plan == null) return;
    state = AsyncData(plan.copyWith(
      items: plan.items
          .map((i) => i.id == itemId ? i.copyWith(itemStatus: status) : i)
          .toList(),
    ));
  }

  Future<void> _createTimeBlockForItem(AIPlanItemModel item) async {
    final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
    final db = ref.read(databaseProvider);
    final now = DateTime.now();
    final start = _parseSlot(now, item.slotStart);
    final end = _parseSlot(now, item.slotEnd);
    await db.into(db.timeBlocks).insert(
          TimeBlocksCompanion.insert(
            id: _uuid.v4(),
            userId: userId,
            title: item.title,
            startTime: start,
            endTime: end.isAfter(start) ? end : start.add(const Duration(minutes: 30)),
            taskId: Value(item.linkedTaskId),
            isFocusBlock: Value(item.itemType == AIPlanItemType.focus),
          ),
        );
  }

  DateTime _parseSlot(DateTime day, String hhmm) {
    final parts = hhmm.split(':');
    final h = parts.isNotEmpty ? int.tryParse(parts[0]) ?? 9 : 9;
    final m = parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0;
    return DateTime(day.year, day.month, day.day, h, m);
  }
}

@riverpod
class CoachingInsightsNotifier extends _$CoachingInsightsNotifier {
  @override
  Future<void> build() async {
    final userId = ref.watch(authStateProvider).valueOrNull?.uid ?? '';
    if (userId.isEmpty) return;
    final existing = await ref.read(aiRepositoryProvider).watchActiveInsights(userId).first;
    if (existing.isEmpty) {
      final generated = await ref.read(aiServiceProvider).generateInsights(userId);
      for (final insight in generated) {
        await ref.read(aiRepositoryProvider).saveInsight(insight);
      }
    }
  }

  Future<void> dismiss(String id) =>
      ref.read(aiRepositoryProvider).dismissInsight(id);

  Future<void> markRead(String id) =>
      ref.read(aiRepositoryProvider).markInsightRead(id);

  Future<void> rescheduleTaskToTomorrow(String insightId, String contextJson) async {
    final taskId = (jsonDecode(contextJson) as Map<String, dynamic>)['taskId'] as String?;
    if (taskId == null) return;
    final task = await ref.read(taskRepositoryProvider).getTask(taskId);
    if (task == null) return;
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1, 9);
    await ref.read(taskRepositoryProvider).updateTask(task.copyWith(dueDate: tomorrow));
    await dismiss(insightId);
  }
}
