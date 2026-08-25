import 'package:freezed_annotation/freezed_annotation.dart';

part 'journal_media_model.freezed.dart';
part 'journal_media_model.g.dart';

@freezed
sealed class JournalMediaModel with _$JournalMediaModel {
  const factory JournalMediaModel({
    required String id,
    required String entryId,
    @Default('image') String mediaType,
    required String fileUrl,
    String? thumbnailUrl,
    required DateTime createdAt,
  }) = _JournalMediaModel;

  factory JournalMediaModel.fromJson(Map<String, dynamic> json) =>
      _$JournalMediaModelFromJson(json);
}
