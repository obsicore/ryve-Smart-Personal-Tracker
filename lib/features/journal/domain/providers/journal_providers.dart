import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/main.dart' show databaseProvider;
import 'package:hybrid_tracker/core/services/xp_service.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/journal/data/models/gratitude_log_model.dart';
import 'package:hybrid_tracker/features/journal/data/models/journal_entry_model.dart';
import 'package:hybrid_tracker/features/journal/data/models/journal_media_model.dart';
import 'package:hybrid_tracker/features/journal/data/models/reflection_prompt_model.dart';
import 'package:hybrid_tracker/features/journal/data/repositories/journal_repository.dart';

part 'journal_providers.g.dart';

const _uuid = Uuid();
String get newJournalId => _uuid.v4();

final journalRepositoryProvider = Provider<JournalRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return JournalRepositoryImpl(db);
});

String _uid(Ref ref) => ref.watch(authStateProvider).valueOrNull?.uid ?? '';

@riverpod
Stream<List<JournalEntryModel>> journalEntries(Ref ref, {String? search}) {
  ref.watch(journalRepositoryProvider).seedReflectionPromptsIfNeeded();
  return ref.watch(journalRepositoryProvider).watchEntries(_uid(ref), searchTerm: search);
}

@riverpod
Future<JournalEntryModel?> journalEntryById(Ref ref, String id) {
  return ref.watch(journalRepositoryProvider).getEntry(id);
}

@riverpod
Future<GratitudeLogModel?> todayGratitude(Ref ref) {
  return ref.watch(journalRepositoryProvider).getGratitudeForDate(_uid(ref), DateTime.now());
}

@riverpod
Future<ReflectionPromptModel> todayReflectionPrompt(Ref ref) {
  return ref.watch(journalRepositoryProvider).promptForDate(DateTime.now());
}

@riverpod
Future<ReflectionResponseModel?> reflectionResponseFor(Ref ref, String promptId) {
  return ref.watch(journalRepositoryProvider).getResponse(_uid(ref), promptId);
}

@riverpod
class JournalNotifier extends _$JournalNotifier {
  @override
  Future<void> build() async {}

  Future<void> saveEntry(JournalEntryModel entry, {bool isNew = false}) async {
    await ref.read(journalRepositoryProvider).saveEntry(entry);
    if (isNew) {
      await ref.read(xpServiceProvider).award(XPEvent.journalEntry, entityId: entry.id);
    }
  }

  Future<void> deleteEntry(String id) =>
      ref.read(journalRepositoryProvider).deleteEntry(id);

  Future<void> addMedia(JournalMediaModel media) =>
      ref.read(journalRepositoryProvider).addMedia(media);

  Future<void> saveGratitude(GratitudeLogModel log) =>
      ref.read(journalRepositoryProvider).saveGratitude(log);

  Future<void> saveReflectionResponse(ReflectionResponseModel response) =>
      ref.read(journalRepositoryProvider).saveResponse(response);
}
