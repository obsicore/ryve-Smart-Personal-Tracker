import 'package:freezed_annotation/freezed_annotation.dart';

part 'partner_model.freezed.dart';

@freezed
sealed class PartnerModel with _$PartnerModel {
  const factory PartnerModel({
    required String id,
    required String userId,
    required String partnerId,
    required String partnerDisplayName,
    required String status,
    required int partnerStreak,
    required int partnerHabitsToday,
    DateTime? partnerLastActive,
    required DateTime createdAt,
  }) = _PartnerModel;
}

@freezed
sealed class PartnerCheckInModel with _$PartnerCheckInModel {
  const factory PartnerCheckInModel({
    required String id,
    required String partnershipId,
    required String userId,
    required String fromDisplayName,
    String? note,
    required DateTime createdAt,
  }) = _PartnerCheckInModel;
}
