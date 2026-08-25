import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/features/journal/data/models/gratitude_log_model.dart';
import 'package:hybrid_tracker/features/journal/data/models/journal_entry_model.dart';
import 'package:hybrid_tracker/features/journal/data/models/journal_media_model.dart';
import 'package:hybrid_tracker/features/journal/data/models/reflection_prompt_model.dart';

const _uuid = Uuid();

const _seedPrompts = <String>[
  'What made you smile today?',
  'What is a challenge you overcame recently?',
  'Who are you grateful to have in your life right now?',
  'What is one thing you learned this week?',
  'Describe a moment you felt proud of yourself.',
  'What would you tell your younger self today?',
  'What is something you are looking forward to?',
  'What small win deserves more credit than it got?',
  'How did you take care of yourself today?',
  'What is a fear you would like to overcome?',
  'What does your ideal day look like?',
  'What habit are you most proud of building?',
  'Write about a place that makes you feel at peace.',
  'What is something you have been avoiding?',
  'What compliment would you give yourself right now?',
  'What relationship in your life needs more attention?',
  'What is a lesson a mistake recently taught you?',
  'Describe the version of you that you are becoming.',
  'What boundary do you need to set or reinforce?',
  'What is something you take for granted?',
  'What would make today a success?',
  'What is weighing on your mind right now?',
  'What are you doing that no longer serves you?',
  'What made today different from yesterday?',
  'What are three words that describe how you feel right now?',
  'What is a goal you have not told anyone about?',
  'What does progress look like for you this month?',
  'What is one act of kindness you witnessed or gave today?',
  'What would you do today if you knew you could not fail?',
  'What are you most curious about right now?',
];

abstract class JournalRepository {
  Future<void> seedReflectionPromptsIfNeeded();

  Stream<List<JournalEntryModel>> watchEntries(String userId, {String? searchTerm});
  Future<JournalEntryModel?> getEntry(String id);
  Future<void> saveEntry(JournalEntryModel entry);
  Future<void> deleteEntry(String id);
  Future<void> addMedia(JournalMediaModel media);

  Future<GratitudeLogModel?> getGratitudeForDate(String userId, DateTime date);
  Future<void> saveGratitude(GratitudeLogModel log);

  Future<ReflectionPromptModel> promptForDate(DateTime date);
  Future<ReflectionResponseModel?> getResponse(String userId, String promptId);
  Future<void> saveResponse(ReflectionResponseModel response);
}

class JournalRepositoryImpl implements JournalRepository {
  JournalRepositoryImpl(this._db);

  final AppDatabase _db;

  DateTime _dayOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  @override
  Future<void> seedReflectionPromptsIfNeeded() async {
    final existing = await _db.select(_db.reflectionPrompts).get();
    if (existing.isNotEmpty) return;
    for (final content in _seedPrompts) {
      await _db.into(_db.reflectionPrompts).insert(
            ReflectionPromptsCompanion.insert(
              id: _uuid.v4(),
              content: content,
            ),
          );
    }
  }

  Future<List<JournalMediaModel>> _mediaFor(String entryId) async {
    final rows = await (_db.select(_db.journalMedia)
          ..where((m) => m.entryId.equals(entryId)))
        .get();
    return rows
        .map((r) => JournalMediaModel(
              id: r.id,
              entryId: r.entryId,
              mediaType: r.mediaType,
              fileUrl: r.fileUrl,
              thumbnailUrl: r.thumbnailUrl,
              createdAt: r.createdAt,
            ))
        .toList();
  }

  Future<JournalEntryModel> _rowToModel(JournalEntry row) async {
    final media = await _mediaFor(row.id);
    return JournalEntryModel(
      id: row.id,
      userId: row.userId,
      entryDate: row.entryDate,
      title: row.title,
      content: row.content,
      moodTag: row.moodTag,
      isPrivate: row.isPrivate,
      wordCount: row.wordCount,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      syncStatus: row.syncStatus,
      media: media,
    );
  }

  @override
  Stream<List<JournalEntryModel>> watchEntries(String userId, {String? searchTerm}) {
    final query = _db.select(_db.journalEntries)
      ..where((e) => e.userId.equals(userId));
    if (searchTerm != null && searchTerm.trim().isNotEmpty) {
      query.where((e) => e.content.like('%${searchTerm.trim()}%'));
    }
    query.orderBy([(e) => OrderingTerm.desc(e.entryDate)]);
    return query.watch().asyncMap((rows) async {
      final result = <JournalEntryModel>[];
      for (final row in rows) {
        result.add(await _rowToModel(row));
      }
      return result;
    });
  }

  @override
  Future<JournalEntryModel?> getEntry(String id) async {
    final row = await (_db.select(_db.journalEntries)..where((e) => e.id.equals(id)))
        .getSingleOrNull();
    if (row == null) return null;
    return _rowToModel(row);
  }

  @override
  Future<void> saveEntry(JournalEntryModel entry) async {
    final wordCount = entry.content.trim().isEmpty
        ? 0
        : entry.content.trim().split(RegExp(r'\s+')).length;
    await _db.into(_db.journalEntries).insertOnConflictUpdate(
          JournalEntriesCompanion(
            id: Value(entry.id),
            userId: Value(entry.userId),
            entryDate: Value(entry.entryDate),
            title: Value(entry.title),
            content: Value(entry.content),
            moodTag: Value(entry.moodTag),
            isPrivate: Value(entry.isPrivate),
            wordCount: Value(wordCount),
            createdAt: Value(entry.createdAt),
            updatedAt: Value(DateTime.now()),
            syncStatus: const Value(0),
          ),
        );
  }

  @override
  Future<void> deleteEntry(String id) async {
    await (_db.delete(_db.journalMedia)..where((m) => m.entryId.equals(id))).go();
    await (_db.delete(_db.journalEntries)..where((e) => e.id.equals(id))).go();
  }

  @override
  Future<void> addMedia(JournalMediaModel media) async {
    await _db.into(_db.journalMedia).insertOnConflictUpdate(
          JournalMediaCompanion(
            id: Value(media.id),
            entryId: Value(media.entryId),
            mediaType: Value(media.mediaType),
            fileUrl: Value(media.fileUrl),
            thumbnailUrl: Value(media.thumbnailUrl),
            createdAt: Value(media.createdAt),
          ),
        );
  }

  @override
  Future<GratitudeLogModel?> getGratitudeForDate(String userId, DateTime date) async {
    final day = _dayOnly(date);
    final row = await (_db.select(_db.gratitudeLogs)
          ..where((g) => g.userId.equals(userId) & g.logDate.equals(day)))
        .getSingleOrNull();
    if (row == null) return null;
    return GratitudeLogModel(
      id: row.id,
      userId: row.userId,
      logDate: row.logDate,
      item1: row.item1,
      item2: row.item2,
      item3: row.item3,
      createdAt: row.createdAt,
      syncStatus: row.syncStatus,
    );
  }

  @override
  Future<void> saveGratitude(GratitudeLogModel log) async {
    await _db.into(_db.gratitudeLogs).insertOnConflictUpdate(
          GratitudeLogsCompanion(
            id: Value(log.id),
            userId: Value(log.userId),
            logDate: Value(_dayOnly(log.logDate)),
            item1: Value(log.item1),
            item2: Value(log.item2),
            item3: Value(log.item3),
            createdAt: Value(log.createdAt),
            syncStatus: const Value(0),
          ),
        );
  }

  @override
  Future<ReflectionPromptModel> promptForDate(DateTime date) async {
    final prompts = await (_db.select(_db.reflectionPrompts)
          ..where((p) => p.isActive.equals(true)))
        .get();
    if (prompts.isEmpty) {
      return ReflectionPromptModel(
        id: 'fallback',
        content: 'What are you grateful for today?',
        createdAt: DateTime.now(),
      );
    }
    final dayIndex = int.parse(
      '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}',
    );
    final row = prompts[dayIndex % prompts.length];
    return ReflectionPromptModel(
      id: row.id,
      content: row.content,
      category: row.category,
      isActive: row.isActive,
      createdAt: row.createdAt,
    );
  }

  @override
  Future<ReflectionResponseModel?> getResponse(String userId, String promptId) async {
    final row = await (_db.select(_db.reflectionResponses)
          ..where((r) => r.userId.equals(userId) & r.promptId.equals(promptId))
          ..orderBy([(r) => OrderingTerm.desc(r.createdAt)])
          ..limit(1))
        .getSingleOrNull();
    if (row == null) return null;
    return ReflectionResponseModel(
      id: row.id,
      userId: row.userId,
      promptId: row.promptId,
      response: row.response,
      createdAt: row.createdAt,
    );
  }

  @override
  Future<void> saveResponse(ReflectionResponseModel response) async {
    await _db.into(_db.reflectionResponses).insertOnConflictUpdate(
          ReflectionResponsesCompanion(
            id: Value(response.id),
            userId: Value(response.userId),
            promptId: Value(response.promptId),
            response: Value(response.response),
            createdAt: Value(response.createdAt),
          ),
        );
  }
}
