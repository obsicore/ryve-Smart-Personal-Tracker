import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hybrid_tracker/main.dart' show databaseProvider;
import 'package:hybrid_tracker/features/auth/data/models/app_user_model.dart';
import 'package:hybrid_tracker/features/auth/data/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return AuthRepository(db);
});

final authNotifierProvider =
    AsyncNotifierProvider<AuthNotifier, AppUser?>(() => AuthNotifier());

/// Alias kept so every screen/repository that watches `authStateProvider`
/// (originally the Firebase authStateChanges stream) keeps working unchanged.
final authStateProvider = Provider<AsyncValue<AppUser?>>(
  (ref) => ref.watch(authNotifierProvider),
);

class AuthNotifier extends AsyncNotifier<AppUser?> {
  AuthRepository get _repo => ref.read(authRepositoryProvider);

  @override
  Future<AppUser?> build() => _repo.currentUser();

  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.signIn(email, password));
  }

  Future<void> signInWithGoogle() async {
    state = AsyncValue.error(
      Exception('Google sign-in is not set up for this build. Use email & password.'),
      StackTrace.current,
    );
  }

  Future<void> register(String email, String password, String displayName) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repo.register(email, password, displayName));
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repo.signOut();
      return null;
    });
  }
}
