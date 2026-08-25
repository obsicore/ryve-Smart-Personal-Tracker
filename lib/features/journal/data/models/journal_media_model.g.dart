// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_media_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JournalMediaModel _$JournalMediaModelFromJson(Map<String, dynamic> json) =>
    _JournalMediaModel(
      id: json['id'] as String,
      entryId: json['entryId'] as String,
      mediaType: json['mediaType'] as String? ?? 'image',
      fileUrl: json['fileUrl'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$JournalMediaModelToJson(_JournalMediaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'entryId': instance.entryId,
      'mediaType': instance.mediaType,
      'fileUrl': instance.fileUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'createdAt': instance.createdAt.toIso8601String(),
    };
