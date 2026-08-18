class DashboardStats {
  final int totalTasksToday;
  final int completedTasksToday;
  final int totalHabitsToday;
  final int completedHabitsToday;
  final int currentStreak;
  final int waterMl;
  final int moodRating;

  const DashboardStats({
    required this.totalTasksToday,
    required this.completedTasksToday,
    required this.totalHabitsToday,
    required this.completedHabitsToday,
    required this.currentStreak,
    required this.waterMl,
    required this.moodRating,
  });

  double get taskCompletionRate =>
      totalTasksToday == 0 ? 0 : completedTasksToday / totalTasksToday;

  double get habitCompletionRate =>
      totalHabitsToday == 0 ? 0 : completedHabitsToday / totalHabitsToday;
}

class AISuggestion {
  final String id;
  final String text;
  final String icon;

  const AISuggestion({
    required this.id,
    required this.text,
    required this.icon,
  });
}

class HabitPreview {
  final String id;
  final String name;
  final String emoji;
  final bool completed;

  const HabitPreview({
    required this.id,
    required this.name,
    required this.emoji,
    required this.completed,
  });
}

class TaskPreview {
  final String id;
  final String title;
  final int priority; // 0=low,1=med,2=high,3=urgent
  final bool completed;

  const TaskPreview({
    required this.id,
    required this.title,
    required this.priority,
    required this.completed,
  });
}
