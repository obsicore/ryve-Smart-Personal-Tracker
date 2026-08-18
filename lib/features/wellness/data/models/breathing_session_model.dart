import 'package:freezed_annotation/freezed_annotation.dart';

part 'breathing_session_model.freezed.dart';
part 'breathing_session_model.g.dart';

@freezed
sealed class BreathingSessionModel with _$BreathingSessionModel {
  const factory BreathingSessionModel({
    required String id,
    required String userId,
    required String technique,
    required int durationMin,
    @Default(0) int cyclesCompleted,
    int? moodBefore,
    int? moodAfter,
    @Default(false) bool completed,
    required DateTime startedAt,
    DateTime? endedAt,
    required DateTime createdAt,
  }) = _BreathingSessionModel;

  factory BreathingSessionModel.fromJson(Map<String, dynamic> json) =>
      _$BreathingSessionModelFromJson(json);
}

class BreathingTechnique {
  final String id;
  final String label;
  final int inhaleSec;
  final int holdSec;
  final int exhaleSec;

  const BreathingTechnique({
    required this.id,
    required this.label,
    required this.inhaleSec,
    required this.holdSec,
    required this.exhaleSec,
  });
}

const breathingTechniques = [
  BreathingTechnique(id: '4-7-8', label: '4-7-8', inhaleSec: 4, holdSec: 7, exhaleSec: 8),
  BreathingTechnique(id: 'box', label: 'Box Breathing', inhaleSec: 4, holdSec: 4, exhaleSec: 4),
  BreathingTechnique(id: 'belly', label: 'Deep Belly', inhaleSec: 5, holdSec: 2, exhaleSec: 6),
];
