import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart' show Share, XFile;
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/core/database/local/app_database.dart';
import 'package:hybrid_tracker/main.dart' show databaseProvider;

part 'backup_service.g.dart';

const _uuid = Uuid();

/// Every user-owned table this backup walks. Each must have a `user_id`
/// column (verified against the schema — see docs/DATABASE.md) so a single
/// generic query works for all of them. Tables keyed only by a parent id
/// (`subtasks` by task_id, `milestones` by goal_id) are intentionally
/// excluded — a full export would need a join per parent table, deferred.
const _userOwnedTables = [
  'tasks', 'time_blocks', 'tags',
  'habits', 'habit_logs', 'routines', 'routine_logs',
  'goals',
  'journal_entries', 'gratitude_logs', 'reflection_responses',
  'mood_logs', 'energy_logs', 'water_logs', 'workout_logs',
  'breathing_sessions', 'daily_step_logs',
  'sleep_logs', 'alarms', 'focus_sessions',
  'calendar_events',
  'xp_events', 'user_badges', 'streaks',
  'user_challenges',
];

class RestoreResult {
  final int tablesRestored;
  const RestoreResult(this.tablesRestored);
}

class BackupService {
  BackupService(this._db);

  final AppDatabase _db;

  Future<File> exportAllData(String userId, {Directory? outputDir}) async {
    final data = <String, dynamic>{
      'exported_at': DateTime.now().toIso8601String(),
      'version': '1.0',
      'user_id': userId,
    };
    for (final table in _userOwnedTables) {
      final rows = await _db
          .customSelect('SELECT * FROM $table WHERE user_id = ?', variables: [Variable.withString(userId)])
          .get();
      data[table] = rows.map((r) => _jsonSafe(r.data)).toList();
    }
    final dir = outputDir ?? await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final file = File('${dir.path}/ryve_backup_$timestamp.json');
    await file.writeAsString(jsonEncode(data));

    await _db.into(_db.backupManifests).insert(BackupManifestsCompanion.insert(
          id: _uuid.v4(),
          userId: userId,
          filePath: file.path,
          version: '1.0',
        ));

    return file;
  }

  Future<void> shareBackup(File file) => Share.shareXFiles([XFile(file.path)], text: 'Ryve data backup');

  /// Opens a file picker for a previously exported JSON backup, validates
  /// its version, and upserts every table's rows. Newer-local-wins when the
  /// row already exists locally with a newer `updated_at`; rows without an
  /// `updated_at` column always get overwritten (their tables have no
  /// conflict concept, e.g. xp_events is append-only by id).
  Future<RestoreResult?> pickAndRestore(String userId) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    final path = result?.files.single.path;
    if (path == null) return null;
    return restoreFromFile(File(path));
  }

  Future<RestoreResult> restoreFromFile(File file) async {
    final content = await file.readAsString();
    final data = jsonDecode(content) as Map<String, dynamic>;
    if (data['version'] != '1.0') {
      throw Exception('Unsupported backup version: ${data['version']}');
    }

    var restored = 0;
    for (final table in _userOwnedTables) {
      final rows = data[table] as List<dynamic>?;
      if (rows == null || rows.isEmpty) continue;
      for (final row in rows) {
        await _restoreRow(table, Map<String, dynamic>.from(row as Map));
      }
      restored++;
    }
    return RestoreResult(restored);
  }

  Future<void> _restoreRow(String table, Map<String, dynamic> row) async {
    if (row.containsKey('updated_at') && row['id'] != null) {
      final existing = await _db
          .customSelect('SELECT updated_at FROM $table WHERE id = ?', variables: [Variable.withString(row['id'] as String)])
          .getSingleOrNull();
      if (existing != null) {
        final localUpdated = existing.data['updated_at'];
        final remoteUpdated = row['updated_at'];
        if (localUpdated != null && remoteUpdated != null && (localUpdated as num) >= (remoteUpdated as num)) {
          return;
        }
      }
    }
    final columns = row.keys.toList();
    final placeholders = columns.map((_) => '?').join(', ');
    final updateClause = columns.where((c) => c != 'id').map((c) => '$c = excluded.$c').join(', ');
    final values = columns.map((c) => row[c]).toList();
    await _db.customStatement(
      'INSERT INTO $table (${columns.join(', ')}) VALUES ($placeholders) '
      'ON CONFLICT(id) DO UPDATE SET $updateClause',
      values,
    );
  }

  Map<String, dynamic> _jsonSafe(Map<String, dynamic> row) {
    return row.map((k, v) {
      if (v is DateTime) return MapEntry(k, v.millisecondsSinceEpoch);
      return MapEntry(k, v);
    });
  }
}

@Riverpod(keepAlive: true)
BackupService backupService(Ref ref) {
  return BackupService(ref.watch(databaseProvider));
}
