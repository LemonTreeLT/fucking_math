import 'dart:convert';

import 'package:fucking_math/ai/engine/tool_context.dart';
import 'package:fucking_math/ai/tools/_base_tool.dart';
import 'package:fucking_math/ai/tools/orchestrator/sub_action_handler.dart';

class MasterOrchestratorTool extends BaseAiTool {
  final List<SubActionHandler> _handlers;
  MasterOrchestratorTool(this._handlers);

  @override
  String get name => 'master_orchestrator';

  @override
  String get description =>
      '通过 Repository 层对各实体执行批量操作（save/delete/mark_review），'
      '确保业务逻辑（标签关联、日志记录、事务）的完整性。';

  List<AiField> get _mergedDataFields {
    final seen = <String>{};
    return [
      for (final h in _handlers)
        for (final f in h.fields)
          if (seen.add(f.name)) AiField(f.name, f.type),
    ];
  }

  @override
  List<AiField> get fields => [
    AiField(
      'actions',
      AiList(
        '要执行的操作列表，支持批量',
        itemType: AiObject('单个操作', properties: [
          AiField(
            'target',
            AiString('操作目标实体',
                enums: _handlers.map((h) => h.target).toList()),
            isRequired: true,
          ),
          AiField(
            'action',
            AiString(_handlers
                .map((h) => '${h.target}: ${h.supportedActions.join('|')}')
                .join(' | ')),
            isRequired: true,
          ),
          AiField(
            'data',
            AiObject('操作数据，字段因 target 而异',
                properties: _mergedDataFields),
            isRequired: true,
          ),
        ]),
      ),
      isRequired: true,
    ),
  ];

  @override
  Future<String> call(Map<String, dynamic> args, [ToolContext? context]) async {
    final actions = (args['actions'] as List).cast<Map<String, dynamic>>();
    final results = await Future.wait(actions.map(_executeAction));
    return jsonEncode(results);
  }

  Future<Map<String, dynamic>> _executeAction(Map<String, dynamic> item) async {
    final target = item['target'] as String;
    final action = item['action'] as String;
    final raw = Map<String, dynamic>.from(item['data'] ?? {});
    try {
      final handler = _handlers.firstWhere(
        (h) => h.target == target,
        orElse: () => throw ArgumentError('Unknown target: $target'),
      );
      final sanitized = {
        for (final f in handler.fields) f.name: f.getValue(raw),
      };
      final result = await handler.handle(action, sanitized);
      return {'target': target, 'action': action, 'result': result.toString()};
    } catch (e) {
      return {'target': target, 'action': action, 'error': e.toString()};
    }
  }
}
