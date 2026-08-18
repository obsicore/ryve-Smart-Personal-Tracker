import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hybrid_tracker/main.dart' show databaseProvider;
import 'package:hybrid_tracker/features/calendar/data/models/calendar_event_model.dart';
import 'package:hybrid_tracker/features/calendar/data/repositories/calendar_repository.dart';

part 'calendar_providers.g.dart';

// ---------------------------------------------------------------------------
// Repository
// ---------------------------------------------------------------------------
final calendarRepositoryProvider = Provider<CalendarRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return CalendarRepositoryImpl(db);
});

// ---------------------------------------------------------------------------
// UI state
// ---------------------------------------------------------------------------
final selectedDayProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

final focusedMonthProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, 1);
});

// ---------------------------------------------------------------------------
// Stream providers
// ---------------------------------------------------------------------------
@riverpod
Stream<List<CalendarEventModel>> monthEvents(
  MonthEventsRef ref,
  String userId,
  DateTime month,
) {
  return ref
      .watch(calendarRepositoryProvider)
      .watchEventsForMonth(userId, month);
}

@riverpod
Stream<List<CalendarEventModel>> dayEvents(
  DayEventsRef ref,
  String userId,
  DateTime day,
) {
  return ref.watch(calendarRepositoryProvider).watchEventsForDay(userId, day);
}

// ---------------------------------------------------------------------------
// CRUD notifier
// ---------------------------------------------------------------------------
@riverpod
class CalendarNotifier extends _$CalendarNotifier {
  @override
  Future<void> build() async {}

  Future<void> createEvent(CalendarEventModel event) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(calendarRepositoryProvider).createEvent(event),
    );
  }

  Future<void> updateEvent(CalendarEventModel event) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(calendarRepositoryProvider).updateEvent(event),
    );
  }

  Future<void> deleteEvent(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(calendarRepositoryProvider).deleteEvent(id),
    );
  }
}
