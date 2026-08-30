import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/core/database/remote/neon_config.dart';
import 'package:hybrid_tracker/core/utils/password_hash.dart';
import 'package:hybrid_tracker/features/auth/data/models/app_user_model.dart';

const _uuid = Uuid();
const _sessionKey = 'current_user_id';

class AuthRepository {
  AuthRepository(this._db);

  final AppDatabase _db;

  // Shared Dio instance — reuse across calls.
  static final _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  static const _headers = {
    'Content-Type': 'application/json',
    'Neon-Connection-String': neonConnectionString,
  };

  /// Execute a parameterised SQL query against Neon via HTTP.
  /// Returns the rows list, or throws on error.
  Future<List<Map<String, dynamic>>> _neonQuery(
    String sql,
    List<dynamic> params,
  ) async {
    final response = await _dio.post<Map<String, dynamic>>(
      neonHttpUrl,
      options: Options(headers: _headers),
      data: {'query': sql, 'params': params},
    );
    final data = response.data;
    if (data == null) return [];
    if (data.containsKey('message')) {
      throw Exception('Neon error: ${data['message']}');
    }
    final rows = data['rows'] as List<dynamic>? ?? [];
    return rows.cast<Map<String, dynamic>>();
  }

  AppUser _rowToUser(User row) => AppUser(
        uid: row.id,
        email: row.email,
        displayName: row.displayName,
        photoURL: row.avatarUrl,
      );

  Future<AppUser?> currentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(_sessionKey);
    if (id == null) return null;
    final row = await (_db.select(_db.users)..where((u) => u.id.equals(id))).getSingleOrNull();
    return row == null ? null : _rowToUser(row);
  }

  Future<AppUser> register(String email, String password, String displayName) async {
    final normalizedEmail = email.trim().toLowerCase();

    // Check Neon first — user may have registered before and lost local data.
    try {
      final rows = await _neonQuery(
        'SELECT id FROM users WHERE email = \$1 LIMIT 1',
        [normalizedEmail],
      );
      if (rows.isNotEmpty) {
        throw Exception('An account already exists with this email.');
      }
    } catch (e) {
      if (e.toString().contains('An account already exists')) rethrow;
      debugPrint('Ryve: Neon duplicate-check failed: $e');
      // Neon unreachable — fall through to local-only check.
    }

    final existing = await (_db.select(_db.users)..where((u) => u.email.equals(normalizedEmail)))
        .getSingleOrNull();
    if (existing != null) {
      throw Exception('An account already exists with this email.');
    }
    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters.');
    }

    final id = _uuid.v4();
    final salt = generateSalt();
    final hash = hashSecret(password, salt);
    final name = displayName.trim();

    await _db.into(_db.users).insert(
          UsersCompanion.insert(
            id: id,
            email: normalizedEmail,
            passwordHash: hash,
            passwordSalt: Value(salt),
            displayName: Value(name),
          ),
        );

    // Push to Neon — uses HTTP/443, works on all Android networks.
    try {
      await _neonQuery(
        '''INSERT INTO users (id, email, display_name, password_hash, password_salt,
             created_at, updated_at, sync_status)
           VALUES (\$1, \$2, \$3, \$4, \$5, NOW(), NOW(), 1)
           ON CONFLICT (id) DO NOTHING''',
        [id, normalizedEmail, name, hash, salt],
      );
      debugPrint('Ryve: user pushed to Neon OK');
    } catch (e) {
      debugPrint('Ryve: Neon push failed (will retry on sync): $e');
      // Non-fatal — SyncService will retry.
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionKey, id);

    return AppUser(uid: id, email: normalizedEmail, displayName: name);
  }

  Future<AppUser> signIn(String email, String password) async {
    final normalizedEmail = email.trim().toLowerCase();
    var row = await (_db.select(_db.users)..where((u) => u.email.equals(normalizedEmail)))
        .getSingleOrNull();

    // If local row is missing (e.g. after reinstall), try to restore from Neon.
    if (row == null) {
      try {
        final rows = await _neonQuery(
          'SELECT id, email, display_name, avatar_url, password_hash, password_salt '
          'FROM users WHERE email = \$1 LIMIT 1',
          [normalizedEmail],
        );
        if (rows.isNotEmpty) {
          final r = rows.first;
          final remoteHash = r['password_hash'] as String;
          final remoteSalt = r['password_salt'] as String? ?? '';
          if (!verifySecret(password, remoteSalt, remoteHash)) {
            throw Exception('Incorrect email or password.');
          }
          // Restore local row so subsequent logins don't need Neon.
          await _db.into(_db.users).insertOnConflictUpdate(
            UsersCompanion.insert(
              id: r['id'] as String,
              email: r['email'] as String,
              passwordHash: remoteHash,
              passwordSalt: Value(remoteSalt),
              displayName: Value(r['display_name'] as String?),
              avatarUrl: Value(r['avatar_url'] as String?),
            ),
          );
          row = await (_db.select(_db.users)
                ..where((u) => u.email.equals(normalizedEmail)))
              .getSingleOrNull();
        }
      } catch (e) {
        if (e.toString().contains('Incorrect email')) rethrow;
        debugPrint('Ryve: Neon restore failed: $e');
        // Neon unreachable — fall through to "not found" error below.
      }
    }

    if (row == null) {
      throw Exception(
          'Account not found. If you registered on this device before reinstalling, '
          'please register again — your account data was not synced to the cloud.');
    }
    if (!verifySecret(password, row.passwordSalt, row.passwordHash)) {
      throw Exception('Incorrect password. Please try again.');
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionKey, row.id);

    return _rowToUser(row);
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
  }
}
