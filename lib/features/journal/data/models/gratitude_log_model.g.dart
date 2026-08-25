// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gratitude_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GratitudeLogModel _$GratitudeLogModelFromJson(Map<String, dynamic> json) =>
    _GratitudeLogModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      logDate: DateTime.parse(json['logDate'] as String),
      item1: json['item1'] as String,
      item2: json['item2'] as String?,
      item3: json['item3'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      syncStatus: (json['syncStatus'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$GratitudeLogModelToJson(_GratitudeLogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'logDate': instance.logDate.toIso8601String(),
      'item1': instance.item1,
      'item2': instance.item2,
      'item3': instance.item3,
      'createdAt': instance.createdAt.toIso8601String(),
      'syncStatus': instance.syncStatus,
    };
