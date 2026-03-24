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
import 'package:fucking_math/utils/types.dart' show ImageStorage;
import 'package:fucking_math/widget/ai/ai_chat_history.dart';
import 'package:fucking_math/widget/ai/ai_chat_input.dart';
import 'package:fucking_math/widget/ai/ai_chat_items.dart'
    show parseToolContent;
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
        if (_isLoading) _buildStatus(),
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
        const SizedBox(width: 4),
        IconButton(
          icon: Icon(
            _systemPrompt != null
                ? Icons.psychology
                : Icons.psychology_outlined,
            color: _systemPrompt != null
                ? Theme.of(context).colorScheme.primary
                : null,
          ),
          tooltip: 'System Prompt',
          onPressed: _showSystemPromptEditor,
        ),
        const SizedBox(width: 4),
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
        if (_statusMessage != null)
          Text(
            _statusMessage!,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        if (_elapsedDisplay.isNotEmpty) ...[
          if (_statusMessage != null) const SizedBox(width: 8),
          Text(
            _elapsedDisplay,
            style: TextStyle(color: Colors.grey[500], fontSize: 12),
          ),
        ],
      ],
    ),
  );

  void _showContentDialog(String content) {
    final parsed = parseToolContent(content);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('工具详情: ${parsed.label}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '调用参数',
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(ctx).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              SelectableText(
                parsed.args ?? '无参数数据',
                style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
              ),
              const Divider(height: 16),
              Text(
                '返回结果',
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(ctx).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              SelectableText(
                parsed.result,
                style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
              ),
            ],
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
  }

  Future<void> _showSystemPromptEditor() async {
    final ctrl = TextEditingController(text: _systemPrompt ?? '');
    final result = await showDialog<String?>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('System Prompt'),
        content: SizedBox(
          width: 500,
          height: 280,
          child: TextField(
            controller: ctrl,
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            decoration: const InputDecoration(
              hintText: '输入系统提示词...',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, ''),
            child: const Text('清除'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, ctrl.text.trim()),
            child: const Text('确认'),
          ),
        ],
      ),
    );
    ctrl.dispose();
    if (result == null) return;
    setState(() => _systemPrompt = result.isEmpty ? null : result);
  }

  // ============ LAYOUT CODES ABOVE ============

  int? _sessionId;
  List<Message> _messages = [];
  List<Session> _sessions = [];
  bool _isLoading = false;
  bool _canRegenerate = false;
  String? _statusMessage;
  DateTime? _taskStartTime;
  Timer? _elapsedTimer;
  String _elapsedDisplay = '';
  String? _systemPrompt;

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
    _aiConfig?.removeListener(_onAiConfigChanged);
    _elapsedTimer?.cancel();
    _sub?.cancel();
    _processor?.interrupt();
    _modelCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _onAiConfigChanged() {
    final models = AiProviderRepository.parseModels(
      _aiConfig?.activeProvider?.modelsJson ?? '[]',
    );
    if (!mounted) return;
    setState(() {
      _availableModels = models;
      if (models.isNotEmpty && (_selectedModel == null || !models.contains(_selectedModel))) {
        _selectedModel = models.first;
        _modelCtrl.text = models.first;
      }
    });
  }

  void _startElapsedTimer() {
    _taskStartTime = DateTime.now();
    _elapsedTimer?.cancel();
    _elapsedTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (!mounted) return;
      final elapsed = DateTime.now().difference(_taskStartTime!);
      setState(
        () => _elapsedDisplay =
            '${(elapsed.inMilliseconds / 1000).toStringAsFixed(1)}s',
      );
    });
  }

  void _stopElapsedTimer() {
    _elapsedTimer?.cancel();
    _elapsedTimer = null;
    _taskStartTime = null;
    _elapsedDisplay = '';
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
    aiConfig.addListener(_onAiConfigChanged);
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
    _startElapsedTimer();

    _sessionId ??= await _historyRepo!.createSession(title: 'New Chat');

    List<int>? imageIds;
    List<ImageStorage>? localImages;
    if (images.isNotEmpty) {
      imageIds = await GetIt.I<ImagesProvider>().uploadImages(images);
      if (imageIds != null && imageIds.length == images.length) {
        localImages = List.generate(
          imageIds.length,
          (i) => ImageStorage(
            imagePath: images[i].path,
            id: imageIds![i],
            name: images[i].name,
          ),
        );
      }
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
          images: localImages,
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
      systemPrompt: _systemPrompt,
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
        _stopElapsedTimer();
        setState(() {
          _statusMessage = null;
          _canRegenerate = true;
        });
        _reloadMessages();
      case ErrorEvent():
        _stopElapsedTimer();
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
    _stopElapsedTimer();
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
    _startElapsedTimer();
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
    _startElapsedTimer();
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
