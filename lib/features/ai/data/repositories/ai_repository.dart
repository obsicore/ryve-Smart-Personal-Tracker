import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/features/ai/data/models/ai_plan_item_model.dart';
import 'package:hybrid_tracker/features/ai/data/models/ai_plan_model.dart';
import 'package:hybrid_tracker/features/ai/data/models/coaching_insight_model.dart';

const _uuid = Uuid();

abstract class AIRepository {
  Future<AIPlanModel?> getPlanForDate(String userId, DateTime date);
  Future<void> savePlan(AIPlanModel plan);
  Future<void> setItemStatus(String itemId, String status);
  Future<void> deletePlan(String planId);

  Stream<List<CoachingInsightModel>> watchActiveInsights(String userId);
  Future<void> saveInsight(CoachingInsightModel insight);
  Future<void> dismissInsight(String id);
  Future<void> markInsightRead(String id);
}

class AIRepositoryImpl implements AIRepository {
  AIRepositoryImpl(this._db);

  final AppDatabase _db;

  Future<List<AIPlanItemModel>> _itemsFor(String planId) async {
    final rows = await (_db.select(_db.aiPlanItems)
          ..where((i) => i.planId.equals(planId))
          ..orderBy([(i) => OrderingTerm.asc(i.sortOrder)]))
        .get();
    return rows
        .map((r) => AIPlanItemModel(
              id: r.id,
              planId: r.planId,
              slotStart: r.slotStart,
              slotEnd: r.slotEnd,
              title: r.title,
              description: r.description,
              itemType: AIPlanItemTypeX.fromStorage(r.itemType),
              linkedTaskId: r.linkedTaskId,
              linkedHabitId: r.linkedHabitId,
              sortOrder: r.sortOrder,
              itemStatus: r.itemStatus,
            ))
        .toList();
  }

  @override
  Future<AIPlanModel?> getPlanForDate(String userId, DateTime date) async {
    final day = DateTime(date.year, date.month, date.day);
    final row = await (_db.select(_db.aiPlans)
          ..where((p) => p.userId.equals(userId) & p.planDate.equals(day)))
        .getSingleOrNull();
    if (row == null) return null;
    final items = await _itemsFor(row.id);
    return AIPlanModel(
      id: row.id,
      userId: row.userId,
      planDate: row.planDate,
      status: row.status,
      promptContext: row.promptContext,
      modelUsed: row.modelUsed,
      generatedAt: row.generatedAt,
      acceptedAt: row.acceptedAt,
      createdAt: row.createdAt,
      items: items,
    );
  }

  @override
  Future<void> savePlan(AIPlanModel plan) async {
    final day = DateTime(plan.planDate.year, plan.planDate.month, plan.planDate.day);
    await _db.into(_db.aiPlans).insertOnConflictUpdate(
          AiPlansCompanion(
            id: Value(plan.id),
            userId: Value(plan.userId),
            planDate: Value(day),
            status: Value(plan.status),
            promptContext: Value(plan.promptContext),
            modelUsed: Value(plan.modelUsed),
            generatedAt: Value(plan.generatedAt),
            acceptedAt: Value(plan.acceptedAt),
            createdAt: Value(plan.createdAt),
          ),
        );
    await (_db.delete(_db.aiPlanItems)..where((i) => i.planId.equals(plan.id))).go();
    for (final item in plan.items) {
      await _db.into(_db.aiPlanItems).insertOnConflictUpdate(
            AiPlanItemsCompanion(
              id: Value(item.id),
              planId: Value(plan.id),
              slotStart: Value(item.slotStart),
              slotEnd: Value(item.slotEnd),
              title: Value(item.title),
              description: Value(item.description),
              itemType: Value(item.itemType.storageValue),
              linkedTaskId: Value(item.linkedTaskId),
              linkedHabitId: Value(item.linkedHabitId),
              sortOrder: Value(item.sortOrder),
              itemStatus: Value(item.itemStatus),
            ),
          );
    }
  }

  @override
  Future<void> setItemStatus(String itemId, String status) async {
    await (_db.update(_db.aiPlanItems)..where((i) => i.id.equals(itemId))).write(
      AiPlanItemsCompanion(itemStatus: Value(status)),
    );
  }

  @override
  Future<void> deletePlan(String planId) async {
    await (_db.delete(_db.aiPlanItems)..where((i) => i.planId.equals(planId))).go();
    await (_db.delete(_db.aiPlans)..where((p) => p.id.equals(planId))).go();
  }

  @override
  Stream<List<CoachingInsightModel>> watchActiveInsights(String userId) {
    final query = _db.select(_db.coachingInsights)
      ..where((i) => i.userId.equals(userId) & i.isDismissed.equals(false))
      ..orderBy([(i) => OrderingTerm.desc(i.generatedAt)]);
    return query.watch().map(
          (rows) => rows
              .map((r) => CoachingInsightModel(
                    id: r.id,
                    userId: r.userId,
                    category: r.category,
                    content: r.content,
                    contextJson: r.contextJson,
                    isRead: r.isRead,
                    isDismissed: r.isDismissed,
                    generatedAt: r.generatedAt,
                    readAt: r.readAt,
                  ))
              .toList(),
        );
  }

  @override
  Future<void> saveInsight(CoachingInsightModel insight) async {
    await _db.into(_db.coachingInsights).insertOnConflictUpdate(
          CoachingInsightsCompanion(
            id: Value(insight.id),
            userId: Value(insight.userId),
            category: Value(insight.category),
            content: Value(insight.content),
            contextJson: Value(insight.contextJson),
            isRead: Value(insight.isRead),
            isDismissed: Value(insight.isDismissed),
            generatedAt: Value(insight.generatedAt),
            readAt: Value(insight.readAt),
          ),
        );
  }

  @override
  Future<void> dismissInsight(String id) async {
    await (_db.update(_db.coachingInsights)..where((i) => i.id.equals(id))).write(
      const CoachingInsightsCompanion(isDismissed: Value(true)),
    );
  }

  @override
  Future<void> markInsightRead(String id) async {
    await (_db.update(_db.coachingInsights)..where((i) => i.id.equals(id))).write(
      CoachingInsightsCompanion(isRead: const Value(true), readAt: Value(DateTime.now())),
    );
  }
}

String newAIId() => _uuid.v4();
