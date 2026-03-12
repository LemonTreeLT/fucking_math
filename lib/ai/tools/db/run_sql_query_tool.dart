import 'dart:convert';

import 'package:fucking_math/ai/engine/tool_context.dart';
import 'package:fucking_math/ai/tools/_base_tool.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:get_it/get_it.dart';

class RunSqlQueryTool extends BaseAiTool {
  @override
  String get name => 'run_sql_query';

  @override
  String get description =>
      '执行只读 SQL 查询（SELECT / WITH CTE），返回结果集 JSON。最多返回 100 行。';

  static const _sqlField = AiField<String>(
    'sql',
    AiString('要执行的 SELECT 或 WITH 查询语句'),
    isRequired: true,
  );

  @override
  List<AiField> get fields => [_sqlField];

  @override
  Future<String> call(Map<String, dynamic> args, [ToolContext? context]) async {
    final sql = _sqlField.getValue(args);
    if (sql == null || sql.trim().isEmpty) {
      return '缺少必填参数：sql';
    }

    final trimmed = sql.trim();
    final firstWord = trimmed.split(RegExp(r'\s+'))[0].toLowerCase();
    if (firstWord != 'select' && firstWord != 'with') {
      return '只允许执行 SELECT 或 WITH（CTE）查询，当前首词：$firstWord';
    }

    final effectiveSql = RegExp(r'\bLIMIT\b', caseSensitive: false).hasMatch(trimmed)
        ? trimmed
        : '$trimmed LIMIT 100';

    final db = GetIt.instance<AppDatabase>();
    try {
      final rows = await db.customSelect(effectiveSql).get();
      if (rows.isEmpty) return '[]';
      return jsonEncode(rows.map((r) => r.data).toList());
    } catch (e) {
      return '查询执行失败：$e';
    }
  }
}
