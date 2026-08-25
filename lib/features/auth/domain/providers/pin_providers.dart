import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/features/auth/data/repositories/pin_repository.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/main.dart' show databaseProvider;

part 'pin_providers.g.dart';

final pinRepositoryProvider = Provider<PinRepository>((ref) {
  return PinRepository(ref.watch(databaseProvider));
});

@riverpod
Future<PinConfig?> pinConfig(Ref ref) {
  final userId = ref.watch(authStateProvider).value?.uid ?? '';
  if (userId.isEmpty) return Future.value(null);
  return ref.watch(pinRepositoryProvider).get(userId);
}

/// True while the app should show the PIN lock screen: set on app pause,
/// cleared once the user successfully unlocks. The app shell listens to
/// [AppLifecycleState] and flips this based on `auto_lock_minutes`.
final appLockedProvider = StateProvider<bool>((ref) => false);
final _pausedAtProvider = StateProvider<DateTime?>((ref) => null);

class LockGate {
  static void onPause(WidgetRef ref) {
    ref.read(_pausedAtProvider.notifier).state = DateTime.now();
  }

  static Future<void> onResume(WidgetRef ref) async {
    final pausedAt = ref.read(_pausedAtProvider.notifier).state;
    if (pausedAt == null) return;
    final config = await ref.read(pinConfigProvider.future);
    if (config == null || config.pinHash == null) return;
    final elapsed = DateTime.now().difference(pausedAt);
    if (elapsed.inMinutes >= config.autoLockMinutes) {
      ref.read(appLockedProvider.notifier).state = true;
    }
  }
}
