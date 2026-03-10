sealed class TaskEvent {
  final DateTime timestamp;
  TaskEvent() : timestamp = DateTime.now();
}

/// AI 返回了文本内容
class ThinkingEvent extends TaskEvent {
  final String content;
  ThinkingEvent(this.content);
}

/// 工具开始执行
class ToolStartEvent extends TaskEvent {
  final String toolName;
  final Map<String, dynamic> arguments;
  ToolStartEvent(this.toolName, this.arguments);
}

/// 工具执行完成
class ToolEndEvent extends TaskEvent {
  final String toolName;
  final String result;
  ToolEndEvent(this.toolName, this.result);
}

/// 工具内部日志
class LogEvent extends TaskEvent {
  final String message;
  LogEvent(this.message);
}

/// 等待用户确认（挂起循环）
class WaitUserEvent extends TaskEvent {
  final String prompt;
  WaitUserEvent(this.prompt);
}

/// 任务出错
class ErrorEvent extends TaskEvent {
  final String message;
  final Object? error;
  ErrorEvent(this.message, {this.error});
}

/// 任务完成
class DoneEvent extends TaskEvent {
  final String? finalMessage;
  DoneEvent({this.finalMessage});
}
