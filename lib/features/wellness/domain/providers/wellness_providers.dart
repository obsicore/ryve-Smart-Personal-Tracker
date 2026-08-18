import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/main.dart' show databaseProvider;
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/wellness/data/models/breathing_session_model.dart';
import 'package:hybrid_tracker/features/wellness/data/models/energy_log_model.dart';
import 'package:hybrid_tracker/features/wellness/data/models/mood_log_model.dart';
import 'package:hybrid_tracker/features/wellness/data/models/step_log_model.dart';
import 'package:hybrid_tracker/features/wellness/data/models/water_log_model.dart';
import 'package:hybrid_tracker/features/wellness/data/models/workout_model.dart';
import 'package:hybrid_tracker/features/wellness/data/repositories/wellness_repository.dart';

part 'wellness_providers.g.dart';

const _uuid = Uuid();
String get newWellnessId => _uuid.v4();

final wellnessRepositoryProvider = Provider<WellnessRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return WellnessRepositoryImpl(db);
});

String _uid(Ref ref) => ref.watch(authStateProvider).valueOrNull?.uid ?? '';

@riverpod
Stream<List<MoodLogModel>> recentMoodLogs(Ref ref) {
  return ref.watch(wellnessRepositoryProvider).watchRecentMoodLogs(_uid(ref));
}

@riverpod
Future<MoodLogModel?> todayMood(Ref ref) {
  return ref.watch(wellnessRepositoryProvider).getTodayMood(_uid(ref));
}

@riverpod
Stream<List<WaterLogModel>> todayWaterLogs(Ref ref) {
  return ref.watch(wellnessRepositoryProvider).watchTodayWater(_uid(ref));
}

@riverpod
Future<StepLogModel?> todaySteps(Ref ref) {
  return ref.watch(wellnessRepositoryProvider).getTodaySteps(_uid(ref));
}

@riverpod
Future<StepLogModel?> yesterdaySteps(Ref ref) {
  return ref.watch(wellnessRepositoryProvider).getYesterdaySteps(_uid(ref));
}

@riverpod
Stream<List<WorkoutLogModel>> recentWorkouts(Ref ref) {
  return ref.watch(wellnessRepositoryProvider).watchRecentWorkouts(_uid(ref));
}

@riverpod
Stream<List<BreathingSessionModel>> recentBreathingSessions(Ref ref) {
  return ref.watch(wellnessRepositoryProvider).watchRecentBreathingSessions(_uid(ref));
}

@riverpod
class WellnessNotifier extends _$WellnessNotifier {
  @override
  Future<void> build() async {}

  Future<void> logMood({
    required int moodScore,
    int? energyScore,
    List<String> factors = const [],
    String? note,
  }) async {
    final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
    final now = DateTime.now();
    final log = MoodLogModel(
      id: newWellnessId,
      userId: userId,
      logDate: now,
      logTime: now,
      moodScore: moodScore,
      energyScore: energyScore,
      factors: factors,
      note: note,
      createdAt: now,
      updatedAt: now,
    );
    await ref.read(wellnessRepositoryProvider).logMood(log);
  }

  Future<void> logEnergy(int level) async {
    final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
    final now = DateTime.now();
    await ref.read(wellnessRepositoryProvider).logEnergy(
          EnergyLogModel(
            id: newWellnessId,
            userId: userId,
            logDate: now,
            logTime: now,
            energyLevel: level,
            createdAt: now,
          ),
        );
  }

  Future<void> logWater(int amountMl) async {
    final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
    final now = DateTime.now();
    await ref.read(wellnessRepositoryProvider).logWater(
          WaterLogModel(
            id: newWellnessId,
            userId: userId,
            logDate: now,
            logTime: now,
            amountMl: amountMl,
            createdAt: now,
          ),
        );
  }

  Future<void> logSteps(int steps) async {
    final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
    final now = DateTime.now();
    await ref.read(wellnessRepositoryProvider).logSteps(
          StepLogModel(
            id: newWellnessId,
            userId: userId,
            logDate: now,
            stepCount: steps,
            updatedAt: now,
          ),
        );
  }

  Future<void> logWorkout(WorkoutLogModel workout) =>
      ref.read(wellnessRepositoryProvider).logWorkout(workout);

  Future<void> logBreathingSession(BreathingSessionModel session) async {
    await ref.read(wellnessRepositoryProvider).logBreathingSession(session);
    if (session.moodAfter != null) {
      await logMood(moodScore: session.moodAfter!, note: 'After ${session.technique} breathing');
    }
  }
}
