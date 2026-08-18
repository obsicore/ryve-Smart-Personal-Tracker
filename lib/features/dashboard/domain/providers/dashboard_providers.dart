import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hybrid_tracker/features/dashboard/data/models/dashboard_models.dart';

part 'dashboard_providers.g.dart';

@riverpod
Future<DashboardStats> dashboardStats(Ref ref) async {
  await Future.delayed(const Duration(milliseconds: 300));
  return const DashboardStats(
    totalTasksToday: 5,
    completedTasksToday: 2,
    totalHabitsToday: 4,
    completedHabitsToday: 1,
    currentStreak: 7,
    waterMl: 750,
    moodRating: 7,
  );
}

@riverpod
Future<List<HabitPreview>> habitPreviews(Ref ref) async {
  await Future.delayed(const Duration(milliseconds: 200));
  return const [
    HabitPreview(id: '1', name: 'Meditate', emoji: '🧘', completed: true),
    HabitPreview(id: '2', name: 'Read', emoji: '📚', completed: false),
    HabitPreview(id: '3', name: 'Exercise', emoji: '🏃', completed: false),
    HabitPreview(id: '4', name: 'Journal', emoji: '✍️', completed: false),
  ];
}

@riverpod
Future<List<TaskPreview>> taskPreviews(Ref ref) async {
  await Future.delayed(const Duration(milliseconds: 200));
  // priority: 0=low, 1=medium, 2=high, 3=urgent
  return const [
    TaskPreview(id: '1', title: 'Review project proposal', priority: 3, completed: true),
    TaskPreview(id: '2', title: 'Team standup meeting', priority: 2, completed: true),
    TaskPreview(id: '3', title: 'Draft weekly report', priority: 1, completed: false),
  ];
}

final unreadNotificationsProvider = StateProvider<int>((ref) => 3);
