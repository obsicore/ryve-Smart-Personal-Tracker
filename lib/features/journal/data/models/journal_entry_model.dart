import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:hybrid_tracker/features/journal/data/models/journal_media_model.dart';

part 'journal_entry_model.freezed.dart';
part 'journal_entry_model.g.dart';

@freezed
sealed class JournalEntryModel with _$JournalEntryModel {
  const factory JournalEntryModel({
    required String id,
    required String userId,
    required DateTime entryDate,
    String? title,
    @Default('') String content,
    String? moodTag,
    @Default(true) bool isPrivate,
    @Default(0) int wordCount,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(0) int syncStatus,
    @Default([]) List<JournalMediaModel> media,
  }) = _JournalEntryModel;

  factory JournalEntryModel.fromJson(Map<String, dynamic> json) =>
      _$JournalEntryModelFromJson(json);
}

extension JournalEntryModelX on JournalEntryModel {
  String get preview {
    final stripped = content.replaceAll(RegExp(r'[*_#\n]+'), ' ').trim();
    return stripped.length <= 60 ? stripped : '${stripped.substring(0, 60)}…';
  }

  String get displayTitle => (title != null && title!.isNotEmpty) ? title! : preview;
}
