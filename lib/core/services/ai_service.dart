import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/core/services/nim_config.dart';
import 'package:hybrid_tracker/features/ai/data/models/ai_plan_item_model.dart';
import 'package:hybrid_tracker/features/ai/data/models/ai_plan_model.dart';
import 'package:hybrid_tracker/features/ai/data/models/coaching_insight_model.dart';

const _uuid = Uuid();
const _apiKeyPrefsKey = 'ryve_ai_api_key';

/// Generates day plans and coaching insights.
///
/// Priority: NVIDIA NIM (gpt-oss-120b) → NIM fallback (kimi-k3) → Claude → local heuristic.
class AIService {
  AIService(this._db);

  final AppDatabase _db;

  Future<String?> getApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_apiKeyPrefsKey);
  }

  Future<void> setApiKey(String? key) async {
    final prefs = await SharedPreferences.getInstance();
    if (key == null || key.isEmpty) {
      await prefs.remove(_apiKeyPrefsKey);
    } else {
      await prefs.setString(_apiKeyPrefsKey, key);
    }
  }

  Future<({AIPlanModel plan, bool usedAI})> generateDayPlan(
    String userId,
    DateTime date,
  ) async {
    final tasks = await (_db.select(_db.tasks)
          ..where((t) => t.userId.equals(userId) & t.isCompleted.equals(false)))
        .get();
    final habits = await (_db.select(_db.habits)
          ..where((h) => h.userId.equals(userId) & h.isActive.equals(true)))
        .get();

    // 1. Try NVIDIA NIM (gpt-oss-120b ~35s)
    try {
      final nimPlan = await _callNim(
        nimApiKeyPrimary,
        nimModelPrimary,
        userId,
        date,
        tasks,
        habits,
      ).timeout(const Duration(seconds: 60));
      if (nimPlan != null) return (plan: nimPlan, usedAI: true);
    } catch (_) {}

    // 2. Try NIM fallback (kimi-k3 ~60s)
    try {
      final nimPlan = await _callNim(
        nimApiKeyFallback,
        nimModelFallback,
        userId,
        date,
        tasks,
        habits,
      ).timeout(const Duration(seconds: 90));
      if (nimPlan != null) return (plan: nimPlan, usedAI: true);
    } catch (_) {}

    // 3. Try Claude if key configured
    final apiKey = await getApiKey();
    if (apiKey != null && apiKey.isNotEmpty) {
      try {
        final aiPlan = await _callClaude(apiKey, userId, date, tasks, habits)
            .timeout(const Duration(seconds: 30));
        if (aiPlan != null) return (plan: aiPlan, usedAI: true);
      } catch (_) {}
    }

    // 4. Local heuristic
    return (plan: _buildHeuristicPlan(userId, date, tasks, habits), usedAI: false);
  }

  AIPlanModel _buildHeuristicPlan(
    String userId,
    DateTime date,
    List<Task> tasks,
    List<Habit> habits,
  ) {
    final planId = _uuid.v4();
    final sorted = [...tasks]..sort((a, b) => b.priority.compareTo(a.priority));

    final items = <AIPlanItemModel>[];
    var hour = 8;
    var sortOrder = 0;

    for (final habit in habits.take(2)) {
      items.add(AIPlanItemModel(
        id: _uuid.v4(),
        planId: planId,
        slotStart: '${hour.toString().padLeft(2, '0')}:00',
        slotEnd: '${hour.toString().padLeft(2, '0')}:15',
        title: habit.name,
        description: 'Daily habit',
        itemType: AIPlanItemType.habit,
        linkedHabitId: habit.id,
        sortOrder: sortOrder++,
      ));
      hour++;
    }

    for (final task in sorted.take(5)) {
      final durationMin = task.priority >= 2 ? 60 : 30;
      final endHour = hour + (durationMin ~/ 60);
      final endMin = durationMin % 60;
      items.add(AIPlanItemModel(
        id: _uuid.v4(),
        planId: planId,
        slotStart: '${hour.toString().padLeft(2, '0')}:00',
        slotEnd: '${endHour.toString().padLeft(2, '0')}:${endMin.toString().padLeft(2, '0')}',
        title: task.title,
        description: task.description,
        itemType: AIPlanItemType.task,
        linkedTaskId: task.id,
        sortOrder: sortOrder++,
      ));
      hour = endHour + (endMin > 0 ? 1 : 0);

      if (hour < 20 && sortOrder % 3 == 0) {
        items.add(AIPlanItemModel(
          id: _uuid.v4(),
          planId: planId,
          slotStart: '${hour.toString().padLeft(2, '0')}:00',
          slotEnd: '${hour.toString().padLeft(2, '0')}:15',
          title: 'Short break',
          itemType: AIPlanItemType.breakTime,
          sortOrder: sortOrder++,
        ));
        hour++;
      }
      if (hour >= 20) break;
    }

    return AIPlanModel(
      id: planId,
      userId: userId,
      planDate: date,
      status: 'draft',
      promptContext: 'local_heuristic',
      modelUsed: null,
      generatedAt: DateTime.now(),
      createdAt: DateTime.now(),
      items: items,
    );
  }

  Future<AIPlanModel?> _callNim(
    String apiKey,
    String model,
    String userId,
    DateTime date,
    List<Task> tasks,
    List<Habit> habits,
  ) async {
    final dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 90),
    ));

    final taskList = tasks.map((t) => '- ${t.title} (priority ${t.priority})').join('\n');
    final habitList = habits.map((h) => '- ${h.name}').join('\n');
    final dateStr = date.toIso8601String().split('T').first;

    final prompt = '''You are a personal productivity coach. Create a realistic day plan for $dateStr.

Pending tasks (with priority):
$taskList

Habits due today:
$habitList

Return ONLY a JSON array, no prose, no markdown, no code fences:
[{ "slot_start": "HH:MM", "slot_end": "HH:MM", "title": "...", "item_type": "task|habit|break|focus" }]''';

    final response = await dio.post(
      nimBaseUrl,
      options: Options(headers: {
        'Authorization': 'Bearer $apiKey',
        'Accept': 'application/json',
        'content-type': 'application/json',
      }),
      data: {
        'model': model,
        'max_tokens': 1024,
        'temperature': 0.3,
        'stream': false,
        'messages': [
          {'role': 'user', 'content': prompt},
        ],
        if (model == 'openai/gpt-oss-120b' || model == 'openai/gpt-oss-20b')
          'chat_template_kwargs': {'thinking': false},
      },
    );

    final choices = response.data['choices'] as List?;
    if (choices == null || choices.isEmpty) return null;
    final text = choices.first['message']?['content'] as String?;
    if (text == null || text.isEmpty) return null;

    final jsonStart = text.indexOf('[');
    final jsonEnd = text.lastIndexOf(']');
    if (jsonStart == -1 || jsonEnd == -1) return null;
    final parsed = jsonDecode(text.substring(jsonStart, jsonEnd + 1)) as List;

    final planId = _uuid.v4();
    final items = <AIPlanItemModel>[];
    for (var i = 0; i < parsed.length; i++) {
      final row = parsed[i] as Map<String, dynamic>;
      items.add(AIPlanItemModel(
        id: _uuid.v4(),
        planId: planId,
        slotStart: row['slot_start'] as String? ?? '09:00',
        slotEnd: row['slot_end'] as String? ?? '09:30',
        title: row['title'] as String? ?? 'Untitled',
        itemType: AIPlanItemTypeX.fromStorage(row['item_type'] as String? ?? 'task'),
        sortOrder: i,
      ));
    }

    return AIPlanModel(
      id: planId,
      userId: userId,
      planDate: date,
      status: 'draft',
      promptContext: 'nvidia_nim',
      modelUsed: model,
      generatedAt: DateTime.now(),
      createdAt: DateTime.now(),
      items: items,
    );
  }

  Future<AIPlanModel?> _callClaude(
    String apiKey,
    String userId,
    DateTime date,
    List<Task> tasks,
    List<Habit> habits,
  ) async {
    final dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));

    final taskList = tasks.map((t) => '- ${t.title} (priority ${t.priority})').join('\n');
    final habitList = habits.map((h) => '- ${h.name}').join('\n');

    final prompt = '''
You are a personal productivity coach. Given the user's schedule and preferences,
create a realistic day plan for ${date.toIso8601String().split('T').first}.

Pending tasks (with priority):
$taskList

Habits due today:
$habitList

Return ONLY a JSON array of time slots, no prose:
[{ "slot_start": "HH:MM", "slot_end": "HH:MM", "title": "...", "item_type": "task|habit|break|focus" }]
''';

    final response = await dio.post(
      'https://api.anthropic.com/v1/messages',
      options: Options(headers: {
        'x-api-key': apiKey,
        'anthropic-version': '2023-06-01',
        'content-type': 'application/json',
      }),
      data: {
        'model': 'claude-sonnet-4-6',
        'max_tokens': 1024,
        'messages': [
          {'role': 'user', 'content': prompt},
        ],
      },
    );

    final content = response.data['content'] as List?;
    if (content == null || content.isEmpty) return null;
    final text = content.first['text'] as String?;
    if (text == null) return null;

    final jsonStart = text.indexOf('[');
    final jsonEnd = text.lastIndexOf(']');
    if (jsonStart == -1 || jsonEnd == -1) return null;
    final parsed = jsonDecode(text.substring(jsonStart, jsonEnd + 1)) as List;

    final planId = _uuid.v4();
    final items = <AIPlanItemModel>[];
    for (var i = 0; i < parsed.length; i++) {
      final row = parsed[i] as Map<String, dynamic>;
      items.add(AIPlanItemModel(
        id: _uuid.v4(),
        planId: planId,
        slotStart: row['slot_start'] as String? ?? '09:00',
        slotEnd: row['slot_end'] as String? ?? '09:30',
        title: row['title'] as String? ?? 'Untitled',
        itemType: AIPlanItemTypeX.fromStorage(row['item_type'] as String? ?? 'task'),
        sortOrder: i,
      ));
    }

    return AIPlanModel(
      id: planId,
      userId: userId,
      planDate: date,
      status: 'draft',
      promptContext: 'claude_api',
      modelUsed: 'claude-sonnet-4-6',
      generatedAt: DateTime.now(),
      createdAt: DateTime.now(),
      items: items,
    );
  }

  Future<List<CoachingInsightModel>> generateInsights(String userId) async {
    final insights = <CoachingInsightModel>[];
    final now = DateTime.now();

    final sleepLogs = await (_db.select(_db.sleepLogs)
          ..where((s) => s.userId.equals(userId))
          ..orderBy([(s) => OrderingTerm.desc(s.createdAt)])
          ..limit(7))
        .get();
    if (sleepLogs.isNotEmpty) {
      final avgHours = sleepLogs
              .map((s) => s.wakeTime.difference(s.bedtime).inMinutes / 60.0)
              .reduce((a, b) => a + b) /
          sleepLogs.length;
      if (avgHours < 6.5) {
        insights.add(_insight(
          userId,
          'sleep',
          "You've averaged ${avgHours.toStringAsFixed(1)}h of sleep this week — aim for 7-8h to boost focus tomorrow.",
        ));
      }
    }

    final moodLogs = await (_db.select(_db.moodLogs)
          ..where((m) => m.userId.equals(userId))
          ..orderBy([(m) => OrderingTerm.desc(m.logDate)])
          ..limit(7))
        .get();
    if (moodLogs.isNotEmpty) {
      final avgMood = moodLogs.map((m) => m.moodScore).reduce((a, b) => a + b) / moodLogs.length;
      if (avgMood < 5) {
        insights.add(_insight(
          userId,
          'wellness',
          'Your mood has been trending low this week. A short breathing session might help reset.',
        ));
      } else if (avgMood >= 8) {
        insights.add(_insight(
          userId,
          'wellness',
          "Great mood streak this week! You're averaging ${avgMood.toStringAsFixed(1)}/10.",
        ));
      }
    }

    final focusSessions = await (_db.select(_db.focusSessions)
          ..where((f) =>
              f.userId.equals(userId) &
              f.wasCompleted.equals(true) &
              f.startedAt.isBiggerThanValue(now.subtract(const Duration(days: 7)))))
        .get();
    if (focusSessions.isEmpty) {
      insights.add(_insight(
        userId,
        'focus',
        "You haven't logged a focus session this week — try a 25-minute Pomodoro to build momentum.",
      ));
    } else {
      insights.add(_insight(
        userId,
        'focus',
        'You completed ${focusSessions.length} focus sessions this week — keep the streak going.',
      ));
    }

    final habits = await (_db.select(_db.habits)
          ..where((h) => h.userId.equals(userId) & h.isActive.equals(true)))
        .get();
    final todayLogs = await (_db.select(_db.habitLogs)
          ..where((l) =>
              l.userId.equals(userId) &
              l.logDate.isBiggerOrEqualValue(DateTime(now.year, now.month, now.day))))
        .get();
    final loggedHabitIds = todayLogs.map((l) => l.habitId).toSet();
    final pending = habits.where((h) => !loggedHabitIds.contains(h.id)).length;
    if (pending > 0) {
      insights.add(_insight(
        userId,
        'habit',
        "$pending habit${pending == 1 ? '' : 's'} still pending today — small consistent steps build big streaks.",
      ));
    }

    final missedTasks = await (_db.select(_db.tasks)
          ..where((t) =>
              t.userId.equals(userId) &
              t.isCompleted.equals(false) &
              t.dueDate.isSmallerThanValue(DateTime(now.year, now.month, now.day)) &
              t.dueDate.isNotNull()))
        .get();
    for (final task in missedTasks.take(2)) {
      insights.add(_insight(
        userId,
        'reschedule',
        '"${task.title}" is overdue — want to move it to tomorrow?',
        contextJson: jsonEncode({'taskId': task.id}),
      ));
    }

    return insights.take(6).toList();
  }

  CoachingInsightModel _insight(
    String userId,
    String category,
    String content, {
    String? contextJson,
  }) {
    return CoachingInsightModel(
      id: _uuid.v4(),
      userId: userId,
      category: category,
      content: content,
      contextJson: contextJson,
      isRead: false,
      isDismissed: false,
      generatedAt: DateTime.now(),
    );
  }
}
