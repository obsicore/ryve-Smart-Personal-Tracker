import 'package:freezed_annotation/freezed_annotation.dart';

part 'alarm_model.freezed.dart';
part 'alarm_model.g.dart';

enum AlarmMissionType { none, math, shake }

@freezed
sealed class AlarmModel with _$AlarmModel {
  const factory AlarmModel({
    required String id,
    required String userId,
    @Default('Wake Up') String label,
    required String time,
    @Default('1,2,3,4,5,6,7') String daysOfWeek,
    @Default(true) bool isEnabled,
    @Default(AlarmMissionType.none) AlarmMissionType missionType,
    @Default(3) int snoozeCount,
    @Default(5) int snoozeDurationMinutes,
    @Default('default') String soundName,
    required DateTime createdAt,
  }) = _AlarmModel;

  factory AlarmModel.fromJson(Map<String, dynamic> json) =>
      _$AlarmModelFromJson(json);
}

extension AlarmModelX on AlarmModel {
  List<int> get activeDays =>
      daysOfWeek.split(',').map(int.parse).toList();

  String get timeFormatted {
    final parts = time.split(':');
    final h = int.parse(parts[0]);
    final m = int.parse(parts[1]);
    final period = h >= 12 ? 'PM' : 'AM';
    final displayH = h > 12 ? h - 12 : (h == 0 ? 12 : h);
    return '$displayH:${m.toString().padLeft(2, '0')} $period';
  }

  String get daysLabel {
    final days = activeDays;
    if (days.length == 7) return 'Every day';
    if (days.length == 5 && !days.contains(6) && !days.contains(7)) {
      return 'Weekdays';
    }
    if (days.length == 2 && days.contains(6) && days.contains(7)) {
      return 'Weekends';
    }
    const abbrs = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days.map((d) => abbrs[d - 1]).join(' ');
  }
}
