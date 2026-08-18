// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WaterLogModel _$WaterLogModelFromJson(Map<String, dynamic> json) =>
    _WaterLogModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      logDate: DateTime.parse(json['logDate'] as String),
      logTime: DateTime.parse(json['logTime'] as String),
      amountMl: (json['amountMl'] as num).toInt(),
      containerType: json['containerType'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      syncStatus: (json['syncStatus'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$WaterLogModelToJson(_WaterLogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'logDate': instance.logDate.toIso8601String(),
      'logTime': instance.logTime.toIso8601String(),
      'amountMl': instance.amountMl,
      'containerType': instance.containerType,
      'createdAt': instance.createdAt.toIso8601String(),
      'syncStatus': instance.syncStatus,
    };
