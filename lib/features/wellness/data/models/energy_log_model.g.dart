// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'energy_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EnergyLogModel _$EnergyLogModelFromJson(Map<String, dynamic> json) =>
    _EnergyLogModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      logDate: DateTime.parse(json['logDate'] as String),
      logTime: DateTime.parse(json['logTime'] as String),
      energyLevel: (json['energyLevel'] as num).toInt(),
      note: json['note'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$EnergyLogModelToJson(_EnergyLogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'logDate': instance.logDate.toIso8601String(),
      'logTime': instance.logTime.toIso8601String(),
      'energyLevel': instance.energyLevel,
      'note': instance.note,
      'createdAt': instance.createdAt.toIso8601String(),
    };
