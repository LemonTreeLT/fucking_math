import 'dart:convert';

/// 结构化工具调用，从 AiResponse.toolCalls JSON 解析而来
class ToolCall {
  final String id;
  final String name;
  final Map<String, dynamic> arguments;

  ToolCall({required this.id, required this.name, required this.arguments});

  /// 从 AiResponse.toolCalls JSON string 解析出 ToolCall 列表
  ///
  /// toolCallsJson 格式示例:
  /// ```json
  /// [{"id":"call_1","type":"function","function":{"name":"get_weather","arguments":"{\"city\":\"Beijing\"}"}}]
  /// ```
  static List<ToolCall> parseFromJson(String toolCallsJson) {
    final List<dynamic> decoded = jsonDecode(toolCallsJson);
    return decoded.map((item) {
      final function = item['function'] as Map<String, dynamic>;
      final argsRaw = function['arguments'];
      final Map<String, dynamic> args = argsRaw is String
          ? jsonDecode(argsRaw) as Map<String, dynamic>
          : (argsRaw as Map<String, dynamic>?) ?? {};
      return ToolCall(
        id: item['id'] as String,
        name: function['name'] as String,
        arguments: args,
      );
    }).toList();
  }
}

/// 工具执行上下文，注入到 BaseAiTool.call() 中，提供日志和交互能力
class ToolContext {
  final void Function(String message) onLog;
  final Future<bool> Function(String prompt) onConfirm;

  const ToolContext({required this.onLog, required this.onConfirm});

  /// 不需要交互的默认上下文（用于简单场景/测试）
  static final noop = ToolContext(
    onLog: (_) {},
    onConfirm: (_) async => true,
  );
}
