import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Per-install SQLCipher passphrase, generated once and kept in the
/// platform keystore (Android Keystore-backed via flutter_secure_storage).
/// Never written to Drift, SharedPreferences, or Neon.
class SecureDbKey {
  SecureDbKey._();

  static const _storageKey = 'ryve_sqlcipher_key';
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static Future<String> getOrCreate() async {
    final existing = await _storage.read(key: _storageKey);
    if (existing != null && existing.isNotEmpty) return existing;

    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    final passphrase = base64UrlEncode(bytes);
    await _storage.write(key: _storageKey, value: passphrase);
    return passphrase;
  }
}
