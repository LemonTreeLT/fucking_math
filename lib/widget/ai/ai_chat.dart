import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fucking_math/ai/config/ai_config.dart';
import 'package:fucking_math/ai/engine/ai_task_processor.dart';
import 'package:fucking_math/ai/engine/ai_task_service.dart';
import 'package:fucking_math/ai/engine/task_event.dart';
import 'package:fucking_math/ai/repository/ai_history_repository.dart';
import 'package:fucking_math/ai/repository/ai_provider_repository.dart';
import 'package:fucking_math/ai/tools/db/get_db_schema_tool.dart';
import 'package:fucking_math/ai/tools/db/run_sql_mutation_tool.dart';
import 'package:fucking_math/ai/tools/db/run_sql_query_tool.dart';
import 'package:fucking_math/ai/tools/set_title_tool.dart';
import 'package:fucking_math/ai/tools/orchestrator/knowledge_sub_handler.dart';
import 'package:fucking_math/ai/tools/orchestrator/master_orchestrator_tool.dart';
import 'package:fucking_math/ai/tools/orchestrator/questions_sub_handler.dart';
import 'package:fucking_math/ai/tools/orchestrator/phrase_sub_handler.dart';
import 'package:fucking_math/ai/tools/orchestrator/tag_sub_handler.dart';
import 'package:fucking_math/ai/tools/orchestrator/word_sub_handler.dart';
import 'package:fucking_math/ai/types.dart';
import 'package:fucking_math/providers/images.dart';
import 'package:fucking_math/widget/ai/ai_chat_history.dart';
import 'package:fucking_math/widget/ai/ai_chat_input.dart';
import 'package:fucking_math/widget/ai/ai_chat_message_list.dart';
import 'package:get_it/get_it.dart';

class AiChat extends StatefulWidget {
  const AiChat({super.key});

  @override
  State<AiChat> createState() => _AiChatState();
}

class _AiChatState extends State<AiChat> {
  // ──────────────── Layout ────────────────

  @override
  Widget build(BuildContext context) {
    if (_initError != null) {
      return Center(
        child: Text(_initError!, style: const TextStyle(color: Colors.red)),
      );
    }
    return Column(
      children: [
        _buildToolbar(),
        Expanded(
          child: AiChatMessageList(
            messages: _messages,
            isLoading: _isLoading,
            canRegenerate: _canRegenerate,
            scrollController: _scrollCtrl,
            onRegenerate: _regenerate,
            onDelete: _deleteMessage,
            onDeleteFromHere: _deleteFromHere,
            onRegenerateFrom: _regenerateFrom,
            onShowContent: _showContentDialog,
          ),
        ),
        if (_statusMessage != null) _buildStatus(),
        const Divider(height: 1),
        AiChatInput(
          isLoading: _isLoading,
          onSend: _onSend,
          onCancel: _cancelTask,
        ),
      ],
    );
  }

  Widget _buildToolbar() => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        AiChatHistoryButton(
          sessions: _sessions,
          currentSessionId: _sessionId,
          enabled: _historyRepo != null,
          onNewSession: _newSession,
          onLoadSession: _loadSession,
          onRename: _renameSession,
          onDelete: _deleteSession,
        ),
        const SizedBox(width: 8),
        Expanded(child: _buildModelSelector()),
      ],
    ),
  );

  Widget _buildModelSelector() => _availableModels.isNotEmpty
      ? DropdownButtonFormField<String>(
          initialValue: _selectedModel,
          decoration: const InputDecoration(
            labelText: '模型名称',
            border: OutlineInputBorder(),
            isDense: true,
          ),
          items: _availableModels
              .map((m) => DropdownMenuItem(value: m, child: Text(m)))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedModel = value;
                _modelCtrl.text = value;
              });
            }
          },
        )
      : TextField(
          controller: _modelCtrl,
          decoration: const InputDecoration(
            labelText: '模型名称',
            hintText: '未配置模型列表，请手动输入',
            border: OutlineInputBorder(),
            isDense: true,
          ),
        );

  Widget _buildStatus() => Padding(
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
  );

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

  // ============ LAYOUT CODES ABOVE ============

  int? _sessionId;
  List<Message> _messages = [];
  List<Session> _sessions = [];
  bool _isLoading = false;
  bool _canRegenerate = false;
  String? _statusMessage;

  AiTaskProcessor? _processor;
  StreamSubscription? _sub;
  int _taskGeneration = 0;

  late final TextEditingController _modelCtrl;
  late final ScrollController _scrollCtrl;

  AiHistoryRepository? _historyRepo;
  AiTaskService? _taskService;
  AiConfig? _aiConfig;
  String? _initError;
  List<String> _availableModels = [];
  String? _selectedModel;

  @override
  void initState() {
    super.initState();
    _modelCtrl = TextEditingController();
    _scrollCtrl = ScrollController();
    _init();
  }

  @override
  void dispose() {
    _sub?.cancel();
    _processor?.interrupt();
    _modelCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  Future<void> _init() async {
    final aiConfig = GetIt.I<AiConfig>();
    if (!aiConfig.isConfigured) {
      setState(() => _initError = '未配置 AI 提供商，请先在设置中添加提供商');
      return;
    }
    final models = AiProviderRepository.parseModels(
      aiConfig.activeProvider?.modelsJson ?? '[]',
    );
    setState(() {
      _historyRepo = GetIt.I<AiHistoryRepository>();
      _taskService = GetIt.I<AiTaskService>();
      _aiConfig = aiConfig;
      _availableModels = models;
      if (models.isNotEmpty) {
        _selectedModel = models.first;
        _modelCtrl.text = models.first;
      }
    });
    await _loadSessions();
  }

  // ──────────────── Sessions ────────────────

  Future<void> _loadSessions() async {
    final sessions = await _historyRepo!.getAllSessions();
    if (mounted) setState(() => _sessions = sessions);
  }

  Future<void> _loadSession(int sessionId) async {
    final provider = _aiConfig?.activeProvider;
    if (provider == null) return;
    final conversation = await _historyRepo!.getConversation(
      sessionId,
      provider.id,
    );
    setState(() {
      _sessionId = sessionId;
      _messages = conversation.messages;
      _canRegenerate = false;
      _isLoading = false;
    });
    _scrollToBottom();
  }

  void _newSession() => setState(() {
    _sessionId = null;
    _messages = [];
    _canRegenerate = false;
  });

  Future<void> _renameSession(Session s, String title) async {
    if (s.id == null) return;
    await _historyRepo!.updateSessionTitle(s.id!, title);
    await _loadSessions();
  }

  Future<void> _deleteSession(Session s) async {
    if (s.id == null) return;
    await _historyRepo!.deleteSession(s.id!);
    if (_sessionId == s.id) _newSession();
    await _loadSessions();
  }

  // ──────────────── Task management ────────────────

  Future<void> _onSend(
    String text,
    List<({String path, String name})> images,
  ) async {
    final provider = _aiConfig?.activeProvider;
    if (provider == null) return;

    setState(() {
      _isLoading = true;
      _canRegenerate = false;
    });

    _sessionId ??= await _historyRepo!.createSession(title: 'New Chat');

    List<int>? imageIds;
    if (images.isNotEmpty) {
      imageIds = await GetIt.I<ImagesProvider>().uploadImages(images);
    }

    await _historyRepo!.addMessage(
      providerId: provider.id,
      role: Roles.user,
      content: text,
      sessionId: _sessionId,
      imageIds: imageIds,
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
    await _loadSessions();
    await _startTask();
  }

  Future<void> _startTask() async {
    final gen = ++_taskGeneration;
    final modelToUse = _selectedModel ?? _modelCtrl.text.trim();
    if (modelToUse.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('请选择或输入模型名称')));
      return;
    }
    final processor = await _taskService!.startTask(
      sessionId: _sessionId!,
      model: modelToUse,
      onTitleChanged: _loadSessions,
      tools: [
        GetDbSchemaTool(),
        RunSqlQueryTool(),
        RunSqlMutationTool(),
        SetTitleTool(),
        MasterOrchestratorTool([
          PhraseSubHandler(GetIt.I.call()),
          QuestionsSubHandler(GetIt.I.call()),
          KnowledgeSubHandler(GetIt.I.call()),
          WordSubHandler(GetIt.I.call()),
          TagSubHandler(GetIt.I.call()),
        ]),
      ],
    );
    _processor = processor;
    _sub?.cancel();
    _sub = processor.events.listen((event) {
      if (gen == _taskGeneration) _handleEvent(event);
    });
  }

  void _handleEvent(TaskEvent event) {
    if (!mounted) return;
    switch (event) {
      case ThinkingEvent():
        _reloadMessagesKeepLoading();
        _scrollToBottom();
      case ToolStartEvent():
        setState(() => _statusMessage = 'AI 正在调用 ${event.toolName}...');
      case ToolEndEvent():
        setState(() => _statusMessage = null);
        _reloadMessagesKeepLoading();
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
          _statusMessage = null;
          _canRegenerate = true;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('错误：${event.message}')));
    }
  }

  Future<void> _showConfirmDialog(String prompt) async => _processor?.respond(
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

  void _cancelTask() {
    _taskGeneration++;
    _sub?.cancel();
    _processor?.interrupt();
    setState(() {
      _isLoading = false;
      _statusMessage = null;
    });
  }

  // ──────────────── Message operations ────────────────

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
      _statusMessage = null;
    });
    _scrollToBottom();
    await _startTask();
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
      _statusMessage = null;
    });
    _scrollToBottom();
    await _startTask();
  }

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
      _isLoading = false;
    });
    _scrollToBottom();
  }

  Future<void> _reloadMessagesKeepLoading() async {
    final provider = _aiConfig?.activeProvider;
    if (_sessionId == null || provider == null) return;
    final conversation = await _historyRepo!.getConversation(
      _sessionId!,
      provider.id,
    );
    if (!mounted) return;
    setState(() => _messages = conversation.messages);
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
}
