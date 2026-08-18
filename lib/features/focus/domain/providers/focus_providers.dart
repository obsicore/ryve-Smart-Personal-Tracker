import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/main.dart' show databaseProvider;
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/focus/data/models/focus_session_model.dart';
import 'package:hybrid_tracker/features/focus/data/repositories/focus_repository.dart';

part 'focus_providers.g.dart';

// ---------------------------------------------------------------------------
// Timer state
// ---------------------------------------------------------------------------

class FocusTimerState {
  final FocusSessionType sessionType;
  final int totalSeconds;
  final int remainingSeconds;
  final bool isRunning;
  final bool isPaused;
  final int completedSessions;

  const FocusTimerState({
    required this.sessionType,
    required this.totalSeconds,
    required this.remainingSeconds,
    required this.isRunning,
    required this.isPaused,
    required this.completedSessions,
  });

  FocusTimerState copyWith({
    FocusSessionType? sessionType,
    int? totalSeconds,
    int? remainingSeconds,
    bool? isRunning,
    bool? isPaused,
    int? completedSessions,
  }) =>
      FocusTimerState(
        sessionType: sessionType ?? this.sessionType,
        totalSeconds: totalSeconds ?? this.totalSeconds,
        remainingSeconds: remainingSeconds ?? this.remainingSeconds,
        isRunning: isRunning ?? this.isRunning,
        isPaused: isPaused ?? this.isPaused,
        completedSessions: completedSessions ?? this.completedSessions,
      );

  double get progress =>
      totalSeconds > 0 ? remainingSeconds / totalSeconds : 1.0;

  String get formattedTime {
    final m = remainingSeconds ~/ 60;
    final s = remainingSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}

// ---------------------------------------------------------------------------
// Repository provider
// ---------------------------------------------------------------------------

final focusRepositoryProvider = Provider<FocusRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return FocusRepositoryImpl(db);
});

// ---------------------------------------------------------------------------
// Today's sessions stream
// ---------------------------------------------------------------------------

@riverpod
Stream<List<FocusSessionModel>> todaySessions(Ref ref) {
  final userId = ref.watch(authStateProvider).valueOrNull?.uid ?? '';
  return ref.watch(focusRepositoryProvider).watchTodaySessions(userId);
}

// ---------------------------------------------------------------------------
// Settings stream
// ---------------------------------------------------------------------------

@riverpod
Stream<FocusSettingsModel?> focusSettings(Ref ref) {
  final userId = ref.watch(authStateProvider).valueOrNull?.uid ?? '';
  return ref.watch(focusRepositoryProvider).watchSettings(userId);
}

// ---------------------------------------------------------------------------
// Focus streak (consecutive days)
// ---------------------------------------------------------------------------

@riverpod
Future<int> focusStreak(Ref ref) {
  final userId = ref.watch(authStateProvider).valueOrNull?.uid ?? '';
  if (userId.isEmpty) return Future.value(0);
  return ref.watch(focusRepositoryProvider).getStreakDays(userId);
}

// ---------------------------------------------------------------------------
// Timer notifier
// ---------------------------------------------------------------------------

@riverpod
class FocusTimerNotifier extends _$FocusTimerNotifier {
  Timer? _timer;
  DateTime? _sessionStart;

  @override
  FocusTimerState build() {
    ref.onDispose(() => _timer?.cancel());
    return const FocusTimerState(
      sessionType: FocusSessionType.work,
      totalSeconds: 25 * 60,
      remainingSeconds: 25 * 60,
      isRunning: false,
      isPaused: false,
      completedSessions: 0,
    );
  }

  void start() {
    if (state.isRunning) return;
    final settings = ref.read(focusSettingsProvider).valueOrNull;
    final seconds = _secondsForType(state.sessionType, settings);
    _sessionStart = DateTime.now();
    state = FocusTimerState(
      sessionType: state.sessionType,
      totalSeconds: seconds,
      remainingSeconds: seconds,
      isRunning: true,
      isPaused: false,
      completedSessions: state.completedSessions,
    );
    _startTick();
  }

  void pause() {
    if (!state.isRunning) return;
    _timer?.cancel();
    _timer = null;
    state = state.copyWith(isRunning: false, isPaused: true);
  }

  void resume() {
    if (!state.isPaused || state.isRunning) return;
    state = state.copyWith(isRunning: true, isPaused: false);
    _startTick();
  }

  void reset() {
    _timer?.cancel();
    _timer = null;
    _sessionStart = null;
    final settings = ref.read(focusSettingsProvider).valueOrNull;
    final seconds = _secondsForType(state.sessionType, settings);
    state = FocusTimerState(
      sessionType: state.sessionType,
      totalSeconds: seconds,
      remainingSeconds: seconds,
      isRunning: false,
      isPaused: false,
      completedSessions: state.completedSessions,
    );
  }

  void skip() {
    _timer?.cancel();
    _timer = null;
    _advanceSession(wasCompleted: false);
  }

  void switchType(FocusSessionType type) {
    if (state.isRunning) return;
    final settings = ref.read(focusSettingsProvider).valueOrNull;
    final seconds = _secondsForType(type, settings);
    state = FocusTimerState(
      sessionType: type,
      totalSeconds: seconds,
      remainingSeconds: seconds,
      isRunning: false,
      isPaused: false,
      completedSessions: state.completedSessions,
    );
  }

  void _startTick() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.remainingSeconds <= 1) {
        _timer?.cancel();
        _timer = null;
        _onComplete();
      } else {
        state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
      }
    });
  }

  void _onComplete() {
    if (state.sessionType == FocusSessionType.work) {
      _recordSession(wasCompleted: true);
    }
    _advanceSession(wasCompleted: true);
  }

  void _advanceSession({required bool wasCompleted}) {
    final settings = ref.read(focusSettingsProvider).valueOrNull;
    final sessionsBeforeLong = settings?.sessionsBeforeLongBreak ?? 4;

    var newCompleted = state.completedSessions;
    final FocusSessionType nextType;

    if (state.sessionType == FocusSessionType.work) {
      if (wasCompleted) newCompleted++;
      nextType = (newCompleted % sessionsBeforeLong == 0)
          ? FocusSessionType.longBreak
          : FocusSessionType.shortBreak;
    } else {
      nextType = FocusSessionType.work;
    }

    final seconds = _secondsForType(nextType, settings);
    final autoStart = settings?.autoStartBreaks ?? false;

    state = FocusTimerState(
      sessionType: nextType,
      totalSeconds: seconds,
      remainingSeconds: seconds,
      isRunning: false,
      isPaused: false,
      completedSessions: newCompleted,
    );

    if (autoStart) start();
  }

  void _recordSession({required bool wasCompleted}) {
    final userId = ref.read(authStateProvider).valueOrNull?.uid ?? '';
    if (userId.isEmpty) return;
    final start = _sessionStart ?? DateTime.now();
    final end = DateTime.now();
    final durationMinutes = end.difference(start).inMinutes.clamp(1, 999);
    final session = FocusSessionModel(
      id: const Uuid().v4(),
      userId: userId,
      durationMinutes: durationMinutes,
      sessionType: state.sessionType,
      wasCompleted: wasCompleted,
      startedAt: start,
      endedAt: end,
    );
    ref.read(focusRepositoryProvider).saveSession(session);
    _sessionStart = null;
  }

  int _secondsForType(FocusSessionType type, FocusSettingsModel? settings) {
    switch (type) {
      case FocusSessionType.work:
        return (settings?.workMinutes ?? 25) * 60;
      case FocusSessionType.shortBreak:
        return (settings?.shortBreakMinutes ?? 5) * 60;
      case FocusSessionType.longBreak:
        return (settings?.longBreakMinutes ?? 15) * 60;
    }
  }
}

// ---------------------------------------------------------------------------
// Settings notifier
// ---------------------------------------------------------------------------

@riverpod
class FocusSettingsNotifier extends _$FocusSettingsNotifier {
  @override
  Future<void> build() async {}

  Future<void> save(FocusSettingsModel settings) =>
      ref.read(focusRepositoryProvider).saveSettings(settings);
}
