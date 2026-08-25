import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/core/utils/password_hash.dart';

const _uuid = Uuid();

enum PinVerifyResult { correct, incorrect, lockedOut }

const List<Duration> lockoutSteps = [
  Duration(seconds: 30),
  Duration(minutes: 5),
  Duration(minutes: 30),
];

class PinRepository {
  PinRepository(this._db);

  final AppDatabase _db;

  Future<PinConfig?> get(String userId) => (_db.select(_db.pinConfigs)
        ..where((t) => t.userId.equals(userId)))
      .getSingleOrNull();

  Future<void> setPin(String userId, String pin) async {
    final existing = await get(userId);
    final salt = generateSalt();
    final hash = hashSecret(pin, salt);
    if (existing == null) {
      await _db.into(_db.pinConfigs).insert(PinConfigsCompanion.insert(
            id: _uuid.v4(),
            userId: userId,
            pinHash: Value(hash),
            pinSalt: Value(salt),
          ));
    } else {
      await (_db.update(_db.pinConfigs)..where((t) => t.id.equals(existing.id))).write(
        PinConfigsCompanion(
          pinHash: Value(hash),
          pinSalt: Value(salt),
          failedAttempts: const Value(0),
          lockedUntil: const Value(null),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  Future<void> setBiometricEnabled(String userId, bool enabled) async {
    final existing = await get(userId);
    if (existing == null) return;
    await (_db.update(_db.pinConfigs)..where((t) => t.id.equals(existing.id)))
        .write(PinConfigsCompanion(biometricEnabled: Value(enabled)));
  }

  Future<void> setAutoLockMinutes(String userId, int minutes) async {
    final existing = await get(userId);
    if (existing == null) return;
    await (_db.update(_db.pinConfigs)..where((t) => t.id.equals(existing.id)))
        .write(PinConfigsCompanion(autoLockMinutes: Value(minutes)));
  }

  /// Checks the PIN and applies progressive lockout after 5 misses.
  /// Enforced here (not just in the UI) so no future caller can bypass
  /// lockout by skipping a UI-layer check.
  Future<PinVerifyResult> verifyPin(String userId, String pin) async {
    final config = await get(userId);
    if (config == null || config.pinHash == null || config.pinSalt == null) {
      return PinVerifyResult.incorrect;
    }
    if (config.lockedUntil != null && config.lockedUntil!.isAfter(DateTime.now())) {
      return PinVerifyResult.lockedOut;
    }
    if (verifySecret(pin, config.pinSalt!, config.pinHash!)) {
      await (_db.update(_db.pinConfigs)..where((t) => t.id.equals(config.id))).write(
        const PinConfigsCompanion(failedAttempts: Value(0), lockedUntil: Value(null)),
      );
      return PinVerifyResult.correct;
    }
    final attempts = config.failedAttempts + 1;
    DateTime? lockedUntil;
    if (attempts >= 5) {
      final stepIndex = ((attempts - 5) ~/ 5).clamp(0, lockoutSteps.length - 1);
      lockedUntil = DateTime.now().add(lockoutSteps[stepIndex]);
    }
    await (_db.update(_db.pinConfigs)..where((t) => t.id.equals(config.id))).write(
      PinConfigsCompanion(failedAttempts: Value(attempts), lockedUntil: Value(lockedUntil)),
    );
    return PinVerifyResult.incorrect;
  }
}
