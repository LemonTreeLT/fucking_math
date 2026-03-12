import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fucking_math/ai/config/ai_config.dart';
import 'package:fucking_math/ai/engine/ai_task_processor.dart';
import 'package:fucking_math/ai/engine/ai_task_service.dart';
import 'package:fucking_math/ai/engine/task_event.dart';
import 'package:fucking_math/ai/repository/ai_history_repository.dart';
import 'package:fucking_math/ai/tools/db/get_db_schema_tool.dart';
import 'package:fucking_math/ai/tools/db/run_sql_mutation_tool.dart';
import 'package:fucking_math/ai/tools/db/run_sql_query_tool.dart';
import 'package:fucking_math/ai/types.dart';
import 'package:fucking_math/widget/ai/ai_chat_items.dart';
import 'package:get_it/get_it.dart';

// TODO 在发生错误的时候显示重新生成的按钮
// TODO 在发生错误或者断连的时候会在engine内部积压大量的数据，之后DoneEvent时会一次全部展示，而且在此之间删除任何消息也会重新出现
// TODO 工具调用或者展示结果的时候优化ui，展示名字
// TODO ai在思考过程中的流貌似不会被正确展示，所有工具调用会在DoneEvent之后一次展示
// TODO 工具展示时下方的按钮可以移动到右侧
// TODO 工具展示字体美化，暗色模式下看不清
// TODO md&latex渲染支持
class AiChat extends StatefulWidget {
  const AiChat({super.key});

  @override
  State<AiChat> createState() => _AiChatState();
}

class _AiChatState extends State<AiChat> {
  int? _sessionId;
  List<Message> _messages = [];
  bool _isLoading = false;
  String _thinkingContent = '';
  String? _statusMessage;
  bool _canRegenerate = false;
  AiTaskProcessor? _processor;
  StreamSubscription? _sub;

  late final TextEditingController _inputCtrl;
  late final TextEditingController _modelCtrl;
  late final ScrollController _scrollCtrl;

  AiHistoryRepository? _historyRepo;
  AiTaskService? _taskService;
  AiConfig? _aiConfig;
  String? _initError;

  @override
  void initState() {
    super.initState();
    _inputCtrl = TextEditingController();
    _modelCtrl = TextEditingController();
    _scrollCtrl = ScrollController();
    _init();
  }

  Future<void> _init() async {
    final aiConfig = GetIt.I<AiConfig>();
    if (!aiConfig.isConfigured) {
      setState(() => _initError = '未配置 AI 提供商，请先在设置中添加提供商');
      return;
    }
    final historyRepo = GetIt.I<AiHistoryRepository>();
    final sessionId = await historyRepo.createSession(title: 'Debug Chat');
    setState(() {
      _historyRepo = historyRepo;
      _taskService = GetIt.I<AiTaskService>();
      _aiConfig = aiConfig;
      _sessionId = sessionId;
    });
  }

  Future<void> _startTask() async {
    final processor = await _taskService!.startTask(
      sessionId: _sessionId!,
      model: _modelCtrl.text.trim(),
      tools: [GetDbSchemaTool(), RunSqlQueryTool(), RunSqlMutationTool()],
    );
    _processor = processor;
    _sub?.cancel();
    _sub = processor.events.listen(_handleEvent);
  }

  Future<void> _sendMessage() async {
    final text = _inputCtrl.text.trim();
    if (text.isEmpty || _sessionId == null) return;
    final provider = _aiConfig?.activeProvider;
    if (provider == null) return;

    _inputCtrl.clear();
    setState(() {
      _isLoading = true;
      _canRegenerate = false;
    });

    await _historyRepo!.addMessage(
      providerId: provider.id,
      role: Roles.user,
      content: text,
      sessionId: _sessionId,
    );
    setState(
      () => _messages = [
        ..._messages,
        Message(
          role: Roles.user,
          content: text,
          providerId: provider.id,
          session: Session(id: _sessionId),
        ),
      ],
    );
    _scrollToBottom();
    await _startTask();
  }

  void _handleEvent(TaskEvent event) {
    if (!mounted) return;
    switch (event) {
      case ThinkingEvent():
        setState(() => _thinkingContent = event.content);
        _scrollToBottom();
      case ToolStartEvent():
        setState(() => _statusMessage = 'AI 正在调用 ${event.toolName}...');
      case ToolEndEvent():
        setState(() => _statusMessage = null);
      case LogEvent():
        debugPrint('[Tool Log] ${event.message}');
      case WaitUserEvent():
        _showConfirmDialog(event.prompt);
      case DoneEvent():
        setState(() {
          _statusMessage = null;
          _canRegenerate = true;
        });
        _reloadMessages();
      case ErrorEvent():
        setState(() {
          _isLoading = false;
          _thinkingContent = '';
          _statusMessage = null;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('错误：${event.message}')));
    }
  }

  Future<void> _showConfirmDialog(String prompt) async {
    _processor?.respond(
      await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => AlertDialog(
              title: const Text('AI 请求确认'),
              content: Text(prompt),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: const Text('拒绝'),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: const Text('允许'),
                ),
              ],
            ),
          ) ??
          false,
    );
  }

  void _cancelTask() {
    _sub?.cancel();
    _processor?.interrupt();
    setState(() {
      _isLoading = false;
      _thinkingContent = '';
      _statusMessage = null;
    });
  }

  Future<void> _regenerate() async {
    if (_sessionId == null || _aiConfig?.activeProvider == null) return;
    final lastUserIndex = _messages.lastIndexWhere((m) => m.role == Roles.user);
    if (lastUserIndex == -1) return;
    for (final msg in _messages.sublist(lastUserIndex + 1)) {
      if (msg.id != null) await _historyRepo!.deleteHistoryById(msg.id!);
    }
    setState(() {
      _messages = _messages.sublist(0, lastUserIndex + 1);
      _isLoading = true;
      _canRegenerate = false;
      _thinkingContent = '';
      _statusMessage = null;
    });
    _scrollToBottom();
    await _startTask();
  }

  Future<void> _reloadMessages() async {
    final provider = _aiConfig?.activeProvider;
    if (_sessionId == null || provider == null) return;
    final conversation = await _historyRepo!.getConversation(
      _sessionId!,
      provider.id,
    );
    if (!mounted) return;
    setState(() {
      _messages = conversation.messages;
      _thinkingContent = '';
      _isLoading = false;
    });
    _scrollToBottom();
  }

  void _scrollToBottom() => WidgetsBinding.instance.addPostFrameCallback((_) {
    if (_scrollCtrl.hasClients) {
      _scrollCtrl.animateTo(
        _scrollCtrl.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  });

  Future<void> _deleteMessage(Message msg) async {
    if (msg.id != null) await _historyRepo!.deleteHistoryById(msg.id!);
    if (!mounted) return;
    setState(() => _messages = _messages.where((m) => m != msg).toList());
  }

  Future<void> _deleteFromHere(Message msg) async {
    final index = _messages.indexOf(msg);
    if (index == -1) return;
    final toDelete = _messages.sublist(index);
    for (final m in toDelete) {
      if (m.id != null) await _historyRepo!.deleteHistoryById(m.id!);
    }
    if (!mounted) return;
    final currentIndex = _messages.indexOf(msg);
    setState(
      () => _messages = currentIndex != -1
          ? _messages.sublist(0, currentIndex)
          : _messages.where((m) => !toDelete.contains(m)).toList(),
    );
  }

  Future<void> _regenerateFrom(Message msg) async {
    if (_sessionId == null || _aiConfig?.activeProvider == null) return;
    final msgIndex = _messages.indexOf(msg);
    if (msgIndex == -1) return;
    final userIndex = _messages
        .sublist(0, msgIndex)
        .lastIndexWhere((m) => m.role == Roles.user);
    if (userIndex == -1) return;
    for (final m in _messages.sublist(userIndex + 1)) {
      if (m.id != null) await _historyRepo!.deleteHistoryById(m.id!);
    }
    setState(() {
      _messages = _messages.sublist(0, userIndex + 1);
      _isLoading = true;
      _canRegenerate = false;
      _thinkingContent = '';
      _statusMessage = null;
    });
    _scrollToBottom();
    await _startTask();
  }

  void _showContentDialog(String content) => showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('工具结果'),
      content: SingleChildScrollView(
        child: SelectableText(
          content,
          style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('关闭'),
        ),
      ],
    ),
  );

  @override
  void dispose() {
    _sub?.cancel();
    _processor?.interrupt();
    _inputCtrl.dispose();
    _modelCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_initError != null) {
      return Center(
        child: Text(_initError!, style: const TextStyle(color: Colors.red)),
      );
    }

    final visibleMessages = _messages
        .where((m) => !(m.role == Roles.assistant && m.content.trim().isEmpty))
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: TextField(
            controller: _modelCtrl,
            decoration: const InputDecoration(
              labelText: '模型名称',
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: _scrollCtrl,
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount:
                visibleMessages.length +
                (_isLoading ? 1 : 0) +
                (!_isLoading && _canRegenerate ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == visibleMessages.length && _isLoading) {
                return buildChatBubble(
                  isUser: false,
                  content: _thinkingContent,
                  isThinking: true,
                  isLoadingSpinner: _thinkingContent.isEmpty,
                );
              }
              if (index == visibleMessages.length && _canRegenerate) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextButton.icon(
                      onPressed: _regenerate,
                      icon: const Icon(Icons.refresh),
                      label: const Text('重新生成'),
                    ),
                  ),
                );
              }
              final msg = visibleMessages[index];
              return Column(
                crossAxisAlignment: msg.role == Roles.user
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  msg.role == Roles.tool
                      ? buildToolRow(msg.content, _showContentDialog)
                      : buildChatBubble(
                          isUser: msg.role == Roles.user,
                          content: msg.content,
                        ),
                  buildMessageActions(
                    msg,
                    isLoading: _isLoading,
                    onDelete: _deleteMessage,
                    onDeleteFromHere: _deleteFromHere,
                    onRegenerate: _regenerateFrom,
                  ),
                ],
              );
            },
          ),
        ),
        if (_statusMessage != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: 8),
                Text(
                  _statusMessage!,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _inputCtrl,
                  decoration: const InputDecoration(
                    hintText: '输入消息...',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  onSubmitted: (_) => _isLoading ? null : _sendMessage(),
                  maxLines: null,
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: _isLoading ? _cancelTask : _sendMessage,
                icon: Icon(_isLoading ? Icons.stop : Icons.send),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
