import 'dart:convert';

import 'package:fucking_math/ai/engine/tool_context.dart';
import 'package:fucking_math/ai/tools/_base_tool.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:get_it/get_it.dart';

class GetDbSchemaTool extends BaseAiTool {
  @override
  String get name => 'get_db_schema';

  @override
  String get description => '查询本地 SQLite 数据库的完整结构，包含所有表、列定义和外键关系';

  @override
  List<AiField> get fields => [];

  @override
  Future<String> call(Map<String, dynamic> args, [ToolContext? context]) async {
    final db = GetIt.instance<AppDatabase>();
    try {
      final tableRows = await db
          .customSelect(
            "SELECT name FROM sqlite_master "
            "WHERE type='table' "
            "AND name NOT LIKE 'sqlite_%' "
            "AND name NOT LIKE 'drift_%' "
            "ORDER BY name",
          )
          .get();

      final tables = <Map<String, dynamic>>[];

      for (final tableRow in tableRows) {
        final tableName = tableRow.data['name'] as String;

        final columnRows =
            await db.customSelect('PRAGMA table_info($tableName)').get();
        final columns = columnRows
            .map(
              (r) => {
                'cid': r.data['cid'],
                'name': r.data['name'],
                'type': r.data['type'],
                'notnull': r.data['notnull'],
                'dflt_value': r.data['dflt_value'],
                'pk': r.data['pk'],
              },
            )
            .toList();

        final fkRows =
            await db.customSelect('PRAGMA foreign_key_list($tableName)').get();
        final foreignKeys = fkRows
            .map(
              (r) => {
                'id': r.data['id'],
                'seq': r.data['seq'],
                'table': r.data['table'],
                'from': r.data['from'],
                'to': r.data['to'],
                'on_update': r.data['on_update'],
                'on_delete': r.data['on_delete'],
              },
            )
            .toList();

        tables.add({
          'name': tableName,
          'columns': columns,
          'foreign_keys': foreignKeys,
        });
      }

      return jsonEncode({'tables': tables});
    } catch (e) {
      return '查询 schema 失败：$e';
    }
  }
}
