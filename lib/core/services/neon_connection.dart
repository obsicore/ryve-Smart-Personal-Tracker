import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hybrid_tracker/core/database/remote/neon_http_service.dart';

part 'neon_connection.g.dart';

/// Kept for backward-compat with social_repository.
/// Delegates to [NeonHttpService] under the hood.
class NeonConnectionHolder {
  final _http = NeonHttpService();

  Future<List<Map<String, dynamic>>> query(
    String sql,
    List<dynamic> params,
  ) =>
      _http.query(sql, params);

  Future<List<Map<String, dynamic>>> namedQuery(
    String namedSql,
    Map<String, dynamic> namedParams,
  ) =>
      _http.namedQuery(namedSql, namedParams);
}

@Riverpod(keepAlive: true)
NeonConnectionHolder neonConnectionHolder(Ref ref) => NeonConnectionHolder();
