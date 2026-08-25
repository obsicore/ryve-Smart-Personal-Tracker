import 'package:drift/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/core/utils/password_hash.dart';
import 'package:hybrid_tracker/features/auth/data/models/app_user_model.dart';

const _uuid = Uuid();
const _sessionKey = 'current_user_id';

class AuthRepository {
  AuthRepository(this._db);

  final AppDatabase _db;

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
    await _db.into(_db.users).insert(
          UsersCompanion.insert(
            id: id,
            email: normalizedEmail,
            passwordHash: hashSecret(password, salt),
            passwordSalt: Value(salt),
            displayName: Value(displayName.trim()),
          ),
        );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionKey, id);

    return AppUser(uid: id, email: normalizedEmail, displayName: displayName.trim());
  }

  Future<AppUser> signIn(String email, String password) async {
    final normalizedEmail = email.trim().toLowerCase();
    final row = await (_db.select(_db.users)..where((u) => u.email.equals(normalizedEmail)))
        .getSingleOrNull();
    if (row == null || !verifySecret(password, row.passwordSalt, row.passwordHash)) {
      throw Exception('Incorrect email or password.');
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
