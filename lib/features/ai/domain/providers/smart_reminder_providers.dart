import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hybrid_tracker/main.dart' show databaseProvider;
import 'package:hybrid_tracker/core/services/smart_reminder_service.dart';
import 'package:hybrid_tracker/features/ai/data/models/smart_reminder_model.dart';
import 'package:hybrid_tracker/features/ai/data/repositories/smart_reminder_repository.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';

part 'smart_reminder_providers.g.dart';

final smartReminderRepositoryProvider = Provider<SmartReminderRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return SmartReminderRepositoryImpl(db);
});

final smartReminderServiceProvider = Provider<SmartReminderService>((ref) {
  final db = ref.watch(databaseProvider);
  return SmartReminderService(ref.watch(smartReminderRepositoryProvider), db);
});

String _uid(Ref ref) => ref.watch(authStateProvider).valueOrNull?.uid ?? '';

@riverpod
Stream<List<SmartReminderModel>> smartReminders(Ref ref) {
  return ref.watch(smartReminderRepositoryProvider).watchReminders(_uid(ref));
}

@riverpod
Stream<List<LocationTriggerModel>> locationTriggers(Ref ref) {
  return ref.watch(smartReminderRepositoryProvider).watchLocationTriggers(_uid(ref));
}

@riverpod
class SmartReminderNotifier extends _$SmartReminderNotifier {
  @override
  void build() {}

  Future<void> save(SmartReminderModel reminder) async {
    await ref.read(smartReminderRepositoryProvider).saveReminder(reminder);
    await ref.read(smartReminderServiceProvider).applySchedule(reminder);
  }

  Future<void> delete(SmartReminderModel reminder) async {
    await ref.read(smartReminderServiceProvider).cancelSchedule(reminder.id);
    await ref.read(smartReminderRepositoryProvider).deleteReminder(reminder.id);
  }

  Future<void> toggleActive(SmartReminderModel reminder) async {
    final updated = reminder.copyWith(isActive: !reminder.isActive);
    await ref.read(smartReminderRepositoryProvider).setActive(updated.id, updated.isActive);
    await ref.read(smartReminderServiceProvider).applySchedule(updated);
  }

  Future<void> snooze(String id, Duration duration) =>
      ref.read(smartReminderRepositoryProvider).snooze(id, duration);

  Future<void> saveLocationTrigger(LocationTriggerModel trigger) =>
      ref.read(smartReminderRepositoryProvider).saveLocationTrigger(trigger);

  Future<void> deleteLocationTrigger(String id) =>
      ref.read(smartReminderRepositoryProvider).deleteLocationTrigger(id);

  Future<void> evaluateNow() async {
    final userId = ref.read(authStateProvider).valueOrNull?.uid;
    if (userId == null || userId.isEmpty) return;
    await ref.read(smartReminderServiceProvider).evaluate(userId);
  }
}
