import 'package:fucking_math/ai/engine/tool_context.dart';
import 'package:fucking_math/ai/tools/_base_tool.dart';
import 'package:fucking_math/ai/tools/db/sql_validator.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:get_it/get_it.dart';

class RunSqlMutationTool extends BaseAiTool {
  @override
  String get name => 'run_sql_mutation';

  @override
  String get description =>
      '执行数据变更 SQL（INSERT / UPDATE / DELETE），执行前会展示风险评估并请求用户确认。';

  static const _sqlField = AiField<String>(
    'sql',
    AiString('要执行的 INSERT、UPDATE 或 DELETE 语句'),
    isRequired: true,
  );

  @override
  List<AiField> get fields => [_sqlField];

  @override
  Future<String> call(Map<String, dynamic> args, [ToolContext? context]) async {
    if (context == null) {
      return '此操作需要用户交互确认，无法在无上下文场景中执行';
    }

    final sql = _sqlField.getValue(args);
    if (sql == null || sql.trim().isEmpty) {
      return '缺少必填参数：sql';
    }

    final result = SqlValidator.validate(sql.trim());
    if (!result.isAllowed) {
      return '操作被拒绝：${result.summary}';
    }

    final riskLabel = switch (result.riskLevel) {
      RiskLevel.low => '低',
      RiskLevel.medium => '中',
      RiskLevel.high => '高',
    };

    final warningText = result.warnings.isEmpty
        ? ''
        : '\n警告：\n${result.warnings.map((w) => '  • $w').join('\n')}';

    final confirmMessage =
        '即将执行 SQL 变更操作\n'
        '风险等级：$riskLabel\n'
        '摘要：${result.summary}$warningText\n\n'
        'SQL：\n$sql';

    final confirmed = await context.onConfirm(confirmMessage);
    if (!confirmed) {
      return '用户已取消操作';
    }

    final db = GetIt.instance<AppDatabase>();
    try {
      await db.customStatement(sql.trim());
      return '操作成功执行';
    } catch (e) {
      return '执行失败：$e';
    }
  }
}
