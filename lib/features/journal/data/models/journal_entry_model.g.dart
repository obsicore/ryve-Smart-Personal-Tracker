// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JournalEntryModel _$JournalEntryModelFromJson(Map<String, dynamic> json) =>
    _JournalEntryModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      entryDate: DateTime.parse(json['entryDate'] as String),
      title: json['title'] as String?,
      content: json['content'] as String? ?? '',
      moodTag: json['moodTag'] as String?,
      isPrivate: json['isPrivate'] as bool? ?? true,
      wordCount: (json['wordCount'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncStatus: (json['syncStatus'] as num?)?.toInt() ?? 0,
      media: (json['media'] as List<dynamic>?)
              ?.map(
                  (e) => JournalMediaModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$JournalEntryModelToJson(_JournalEntryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'entryDate': instance.entryDate.toIso8601String(),
      'title': instance.title,
      'content': instance.content,
      'moodTag': instance.moodTag,
      'isPrivate': instance.isPrivate,
      'wordCount': instance.wordCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncStatus': instance.syncStatus,
      'media': instance.media,
    };
