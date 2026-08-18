import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user_model.freezed.dart';

@freezed
sealed class AppUser with _$AppUser {
  const factory AppUser({
    required String uid,
    required String email,
    String? displayName,
    String? photoURL,
  }) = _AppUser;
}
