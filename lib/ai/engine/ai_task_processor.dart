import 'dart:async';

import 'package:fucking_math/ai/config/ai_config.dart';
import 'package:fucking_math/ai/core/ai_client.dart';
import 'package:fucking_math/ai/engine/task_event.dart';
import 'package:fucking_math/ai/engine/tool_context.dart';
import 'package:fucking_math/ai/repository/ai_history_repository.dart';
import 'package:fucking_math/ai/tools/_base_tool.dart';
import 'package:fucking_math/ai/types.dart';
import 'package:fucking_math/utils/outputs.dart';

class AiTaskProcessor {
  final String taskId;
  final int providerId;
  final int sessionId;
  final String model;
  final List<BaseAiTool> tools;
  final String? systemPrompt;
  final AiConfig aiConfig;
  final AiHistoryRepository historyRepo;
  final int maxIterations;

  Completer<bool>? _pendingInteraction;
  bool _isInterrupted = false;
  final _eventController = StreamController<TaskEvent>.broadcast();
  late Conversation _conversation;
  late final Map<String, BaseAiTool> _toolMap;
  int _iterationCount = 0;
  bool _isRunning = false;

  AiTaskProcessor({
    required this.taskId,
    required this.providerId,
    required this.sessionId,
    required this.model,
    required this.tools,
    this.systemPrompt,
    required this.aiConfig,
    required this.historyRepo,
    this.maxIterations = 10,
  }) {
    _toolMap = {for (var t in tools) t.name: t};
  }

  /// UI 监听事件流
  Stream<TaskEvent> get events => _eventController.stream;

  bool get isRunning => _isRunning;

  /// 启动主循环
  Future<void> run() async {
    if (_isRunning) return;
    _isRunning = true;

    // 在循环开始前捕获 provider 配置，防止运行期间被切换
    final baseUrl = aiConfig.baseUrl;
    final apiKey = aiConfig.apiKey;
    if (baseUrl == null || apiKey == null) {
      _eventController.add(ErrorEvent('AI provider not configured'));
      _isRunning = false;
      await _eventController.close();
      return;
    }

    try {
      // 1. 从 DB 加载历史 conversation
      _conversation = await historyRepo.getConversation(sessionId, providerId);

      // 2. 主循环
      while (!_isInterrupted && _iterationCount < maxIterations) {
        // a. 构建 API 请求参数
        final messages = _buildMessages();
        final toolDefs = tools.map((t) => t.toJsonDefinition()).toList();

        // b. 调用 AI API
        final aiResponse = await AiClient.chatCompletion(
          baseUrl: baseUrl,
          apiKey: apiKey,
          model: model,
          messages: messages,
          tools: toolDefs.isNotEmpty ? toolDefs : null,
        );

        // c. 持久化 assistant 消息
        await historyRepo.addMessage(
          providerId: providerId,
          role: Roles.assistant,
          content: aiResponse.content,
          sessionId: sessionId,
          toolCalls: aiResponse.toolCalls,
          tokens: aiResponse.totalTokens,
        );

        // d. 追加到内存 conversation
        _conversation = _conversation.addMessage(Message(
          providerId: providerId,
          role: Roles.assistant,
          content: aiResponse.content,
          toolCalls: aiResponse.toolCalls,
        ));

        // e. 发射 ThinkingEvent
        if (aiResponse.content.isNotEmpty) {
          _eventController.add(ThinkingEvent(aiResponse.content));
        }

        // f. 处理工具调用
        if (aiResponse.toolCalls != null &&
            aiResponse.toolCalls!.isNotEmpty) {
          final toolCalls = ToolCall.parseFromJson(aiResponse.toolCalls!);

          for (final toolCall in toolCalls) {
            if (_isInterrupted) break;

            _eventController
                .add(ToolStartEvent(toolCall.name, toolCall.arguments));

            String result;
            final tool = _toolMap[toolCall.name];

            if (tool == null) {
              result = "Error: unknown tool '${toolCall.name}'";
            } else {
              // 构建 ToolContext，桥接日志和交互到事件流
              final context = ToolContext(
                onLog: (msg) => _eventController.add(LogEvent(msg)),
                onConfirm: _waitForUser,
              );
              try {
                result = await tool.call(toolCall.arguments, context);
              } catch (e) {
                result = "Error: tool execution failed: $e";
              }
            }

            // 持久化 tool result
            await historyRepo.addMessage(
              providerId: providerId,
              role: Roles.tool,
              content: result,
              sessionId: sessionId,
              toolId: toolCall.id,
            );

            // 追加到 conversation
            _conversation = _conversation.addMessage(Message(
              providerId: providerId,
              role: Roles.tool,
              content: result,
              toolId: toolCall.id,
            ));

            _eventController.add(ToolEndEvent(toolCall.name, result));
          }

          _iterationCount++;
          continue; // 将所有 tool results 发回给 AI
        }

        // g. finishReason == "stop" → 任务完成
        _eventController.add(DoneEvent(
          finalMessage:
              aiResponse.content.isNotEmpty ? aiResponse.content : null,
        ));
        break;
      }

      // 达到最大迭代次数
      if (!_isInterrupted && _iterationCount >= maxIterations) {
        _eventController.add(
          ErrorEvent('Max iterations ($maxIterations) reached'),
        );
      }
    } catch (e) {
      debugPrint('[AiTaskProcessor] Error in task $taskId: $e');
      _eventController.add(ErrorEvent(e.toString(), error: e));
    } finally {
      _isRunning = false;
      await _eventController.close();
    }
  }

  /// 构建 API 请求的 messages，在前面插入系统 prompt
  List<Map<String, dynamic>> _buildMessages() {
    final messages = _conversation.toOpenAIFormat();
    if (systemPrompt != null && systemPrompt!.isNotEmpty) {
      messages.insert(0, {'role': 'system', 'content': systemPrompt!});
    }
    return messages;
  }

  /// 挂起循环等待用户确认
  Future<bool> _waitForUser(String prompt) {
    _pendingInteraction = Completer<bool>();
    _eventController.add(WaitUserEvent(prompt));
    return _pendingInteraction!.future;
  }

  /// 用户回复确认结果，恢复循环
  void respond(bool approved) {
    if (_pendingInteraction != null && !_pendingInteraction!.isCompleted) {
      _pendingInteraction!.complete(approved);
    }
  }

  /// 中断任务
  void interrupt() {
    _isInterrupted = true;
    if (_pendingInteraction != null && !_pendingInteraction!.isCompleted) {
      _pendingInteraction!.complete(false);
    }
  }
}
