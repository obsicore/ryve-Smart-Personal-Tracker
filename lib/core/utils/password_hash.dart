import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

const _saltBytes = 16;

String generateSalt() {
  final random = Random.secure();
  final bytes = List<int>.generate(_saltBytes, (_) => random.nextInt(256));
  return base64Url.encode(bytes);
}

String hashSecret(String secret, String salt) =>
    sha256.convert(utf8.encode(salt + secret)).toString();

bool verifySecret(String secret, String salt, String hash) =>
    hashSecret(secret, salt) == hash;
