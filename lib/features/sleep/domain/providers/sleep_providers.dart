import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/main.dart' show databaseProvider;
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/sleep/data/models/alarm_model.dart';
import 'package:hybrid_tracker/features/sleep/data/models/sleep_log_model.dart';
import 'package:hybrid_tracker/features/sleep/data/repositories/sleep_repository.dart';

part 'sleep_providers.g.dart';

final sleepRepositoryProvider = Provider<SleepRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return SleepRepositoryImpl(db);
});

@riverpod
Stream<List<SleepLogModel>> recentSleepLogs(Ref ref) {
  final userId = ref.watch(authStateProvider).valueOrNull?.uid ?? '';
  return ref.watch(sleepRepositoryProvider).watchRecentSleepLogs(userId);
}

@riverpod
Stream<List<AlarmModel>> alarms(Ref ref) {
  final userId = ref.watch(authStateProvider).valueOrNull?.uid ?? '';
  return ref.watch(sleepRepositoryProvider).watchAlarms(userId);
}

@riverpod
Future<SleepLogModel?> lastSleepLog(Ref ref) {
  final userId = ref.watch(authStateProvider).valueOrNull?.uid ?? '';
  return ref.watch(sleepRepositoryProvider).getLastSleepLog(userId);
}

@riverpod
class SleepNotifier extends _$SleepNotifier {
  @override
  Future<void> build() async {}

  Future<void> logSleep(SleepLogModel log) =>
      ref.read(sleepRepositoryProvider).logSleep(log);

  Future<void> updateLog(SleepLogModel log) =>
      ref.read(sleepRepositoryProvider).updateSleepLog(log);

  Future<void> deleteLog(String id) =>
      ref.read(sleepRepositoryProvider).deleteSleepLog(id);
}

@riverpod
class AlarmNotifier extends _$AlarmNotifier {
  @override
  Future<void> build() async {}

  Future<void> create(AlarmModel alarm) =>
      ref.read(sleepRepositoryProvider).createAlarm(alarm);

  Future<void> updateAlarm(AlarmModel alarm) =>
      ref.read(sleepRepositoryProvider).updateAlarm(alarm);

  Future<void> delete(String id) =>
      ref.read(sleepRepositoryProvider).deleteAlarm(id);

  Future<void> toggle(String id, bool enabled) =>
      ref.read(sleepRepositoryProvider).toggleAlarm(id, enabled);
}

const _uuid = Uuid();
String get newSleepId => _uuid.v4();
String get newAlarmId => _uuid.v4();
