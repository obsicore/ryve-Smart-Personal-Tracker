import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postgres/postgres.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hybrid_tracker/core/database/remote/neon_config.dart';

part 'neon_connection.g.dart';

/// Shared, lazily-opened Postgres connection to Neon. Every remote-backed
/// service (SyncService, social/community repositories) uses this instead
/// of opening its own connection.
class NeonConnectionHolder {
  Connection? _conn;

  Future<Connection> get() async {
    if (_conn != null && _conn!.isOpen) return _conn!;
    _conn = await Connection.open(
      Endpoint(
        host: neonHost,
        database: neonDatabase,
        username: neonUser,
        password: neonPassword,
      ),
      settings: const ConnectionSettings(sslMode: SslMode.require),
    );
    return _conn!;
  }

  Future<void> close() async {
    await _conn?.close();
    _conn = null;
  }
}

@Riverpod(keepAlive: true)
NeonConnectionHolder neonConnectionHolder(Ref ref) {
  final holder = NeonConnectionHolder();
  ref.onDispose(holder.close);
  return holder;
}
