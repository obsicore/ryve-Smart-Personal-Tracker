import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'neon_config.dart';

/// Converts `@name` placeholders to positional `$N` placeholders.
({String sql, List<dynamic> params}) _convertNamed(
  String namedSql,
  Map<String, dynamic> namedParams,
) {
  final paramOrder = <String>[];
  final positionalSql = namedSql.replaceAllMapped(
    RegExp(r'@(\w+)'),
    (match) {
      final name = match.group(1)!;
      final existing = paramOrder.indexOf(name);
      if (existing >= 0) return '\$${existing + 1}';
      paramOrder.add(name);
      return '\$${paramOrder.length}';
    },
  );
  return (
    sql: positionalSql,
    params: paramOrder.map((n) => namedParams[n]).toList(),
  );
}

/// Thin HTTP client for Neon's serverless SQL endpoint (`/sql`).
/// Uses port 443 — works on all Android network conditions (no raw TCP).
class NeonHttpService {
  static final _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ));

  static const _headers = {
    'Content-Type': 'application/json',
    'Neon-Connection-String': neonConnectionString,
  };

  /// Execute SQL with positional `$N` params.
  Future<List<Map<String, dynamic>>> query(
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
      throw Exception('Neon: ${data['message']}');
    }
    return (data['rows'] as List<dynamic>? ?? []).cast<Map<String, dynamic>>();
  }

  /// Execute SQL with `@name` placeholders (auto-converted to positional).
  Future<List<Map<String, dynamic>>> namedQuery(
    String namedSql,
    Map<String, dynamic> namedParams,
  ) async {
    final converted = _convertNamed(namedSql, namedParams);
    return query(converted.sql, converted.params);
  }
}

final neonHttpServiceProvider = Provider<NeonHttpService>(
  (ref) => NeonHttpService(),
);
