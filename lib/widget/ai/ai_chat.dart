import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fucking_math/ai/config/ai_config.dart';
import 'package:fucking_math/ai/engine/ai_task_processor.dart';
import 'package:fucking_math/ai/engine/ai_task_service.dart';
import 'package:fucking_math/ai/engine/task_event.dart';
import 'package:fucking_math/ai/repository/ai_history_repository.dart';
import 'package:fucking_math/ai/repository/ai_provider_repository.dart';
import 'package:fucking_math/ai/tools/db/get_db_schema_tool.dart';
import 'package:fucking_math/ai/tools/db/run_sql_mutation_tool.dart';
import 'package:fucking_math/ai/tools/db/run_sql_query_tool.dart';
import 'package:fucking_math/ai/tools/orchestrator/knowledge_sub_handler.dart';
import 'package:fucking_math/ai/tools/orchestrator/master_orchestrator_tool.dart';
import 'package:fucking_math/ai/tools/orchestrator/mistakes_sub_handler.dart';
import 'package:fucking_math/ai/tools/orchestrator/phrase_sub_handler.dart';
import 'package:fucking_math/ai/tools/orchestrator/tag_sub_handler.dart';
import 'package:fucking_math/ai/tools/orchestrator/word_sub_handler.dart';
import 'package:fucking_math/ai/types.dart';
import 'package:fucking_math/providers/images.dart';
import 'package:fucking_math/providers/prompt.dart';
import 'package:fucking_math/widget/ai/ai_chat_items.dart';
import 'package:get_it/get_it.dart';

class AiChat extends StatefulWidget {
  const AiChat({super.key});

  @override
  State<AiChat> createState() => _AiChatState();
}

class _AiChatState extends State<AiChat> with TickerProviderStateMixin {
  int? _sessionId;
  List<Message> _messages = [];
  List<({String path, String name})> _pendingImages = [];
  bool _isLoading = false;
  String? _statusMessage;
  bool _canRegenerate = false;
  AiTaskProcessor? _processor;
  StreamSubscription? _sub;

  int _taskGeneration = 0;

  late final TextEditingController _inputCtrl;
  late final TextEditingController _modelCtrl;
  late final ScrollController _scrollCtrl;
  late final ScrollController _inputScrollCtrl;
  late final FocusNode _inputFocusNode;

  // Slash-command prompt overlay state
  List<Prompt> _filteredPrompts = [];
  int _promptHighlightIndex = 0;
  OverlayEntry? _promptOverlay;
  final LayerLink _inputLayerLink = LayerLink();

  // History menu state
  List<Session> _sessions = [];
  OverlayEntry? _historyOverlay;
  final LayerLink _historyLayerLink = LayerLink();
  late final AnimationController _historyAnimCtrl;

  AiHistoryRepository? _historyRepo;
  AiTaskService? _taskService;
  AiConfig? _aiConfig;
  String? _initError;
  List<String> _availableModels = [];
  String? _selectedModel;

  @override
  void initState() {
    super.initState();
    _inputCtrl = TextEditingController();
    _modelCtrl = TextEditingController();
    _scrollCtrl = ScrollController();
    _inputScrollCtrl = ScrollController();
    _inputFocusNode = FocusNode(onKeyEvent: _handleInputKeyEvent);
    _inputCtrl.addListener(_onInputChanged);
    _historyAnimCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _init();
  }

  Future<void> _init() async {
    final aiConfig = GetIt.I<AiConfig>();
    if (!aiConfig.isConfigured) {
      setState(() => _initError = '未配置 AI 提供商，请先在设置中添加提供商');
      return;
    }
    final historyRepo = GetIt.I<AiHistoryRepository>();
    final sessionId = await historyRepo.createSession(title: 'New Chat');

    final models = AiProviderRepository.parseModels(
      aiConfig.activeProvider?.modelsJson ?? '[]',
    );

    setState(() {
      _historyRepo = historyRepo;
      _taskService = GetIt.I<AiTaskService>();
      _aiConfig = aiConfig;
      _sessionId = sessionId;
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
    _hideHistoryOverlay();
    final provider = _aiConfig?.activeProvider;
    if (provider == null) return;
    final conversation = await _historyRepo!.getConversation(sessionId, provider.id);
    setState(() {
      _sessionId = sessionId;
      _messages = conversation.messages;
      _canRegenerate = false;
      _isLoading = false;
    });
    _scrollToBottom();
  }

  Future<void> _newSession() async {
    _hideHistoryOverlay();
    final id = await _historyRepo!.createSession(title: 'New Chat');
    setState(() {
      _sessionId = id;
      _messages = [];
      _canRegenerate = false;
    });
    await _loadSessions();
  }

  Future<void> _showRenameDialog(Session s) async {
    final ctrl = TextEditingController(text: s.title ?? '');
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('重命名对话'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: '对话名称',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('确认')),
        ],
      ),
    );
    if (confirmed == true && s.id != null) {
      await _historyRepo!.updateSessionTitle(s.id!, ctrl.text.trim());
      await _loadSessions();
    }
    ctrl.dispose();
  }

  Future<void> _deleteSession(Session s) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('删除对话'),
        content: Text('确认删除"${s.title ?? '对话 #${s.id}'}"？'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('删除'),
          ),
        ],
      ),
    );
    if (confirmed == true && s.id != null) {
      await _historyRepo!.deleteSession(s.id!);
      if (_sessionId == s.id) {
        await _newSession();
      } else {
        await _loadSessions();
      }
    }
  }

  // ──────────────── History overlay ────────────────

  void _toggleHistoryMenu() {
    if (_historyOverlay != null) {
      _hideHistoryOverlay();
    } else {
      _showHistoryOverlay();
    }
  }

  void _showHistoryOverlay() {
    _historyAnimCtrl.forward(from: 0);
    _historyOverlay = OverlayEntry(builder: (_) => _buildHistoryOverlay());
    Overlay.of(context).insert(_historyOverlay!);
  }

  void _hideHistoryOverlay() {
    _historyOverlay?.remove();
    _historyOverlay = null;
  }

  Widget _buildHistoryOverlay() {
    final animation = CurvedAnimation(parent: _historyAnimCtrl, curve: Curves.easeOut);
    return Stack(
      children: [
        // Transparent barrier
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _hideHistoryOverlay,
          ),
        ),
        CompositedTransformFollower(
          link: _historyLayerLink,
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          offset: const Offset(0, 4),
          child: AnimatedBuilder(
            animation: animation,
            builder: (ctx, child) => FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween(begin: 0.85, end: 1.0).animate(animation),
                alignment: Alignment.topLeft,
                child: child,
              ),
            ),
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(12),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 240, maxWidth: 320),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text('新建对话'),
                      onTap: _newSession,
                    ),
                    const Divider(height: 1),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 280),
                      child: _sessions.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text('暂无历史对话', style: TextStyle(color: Colors.grey)),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: _sessions.length,
                              itemBuilder: (ctx, i) {
                                final s = _sessions[i];
                                final isCurrent = s.id == _sessionId;
                                return ListTile(
                                  selected: isCurrent,
                                  leading: const Icon(Icons.chat_bubble_outline),
                                  title: Text(
                                    s.title?.isNotEmpty == true ? s.title! : '对话 #${s.id}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit, size: 18),
                                        visualDensity: VisualDensity.compact,
                                        onPressed: () => _showRenameDialog(s),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete, size: 18),
                                        visualDensity: VisualDensity.compact,
                                        onPressed: () => _deleteSession(s),
                                      ),
                                    ],
                                  ),
                                  onTap: () => _loadSession(s.id!),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ──────────────── Prompt overlay ────────────────

  void _onInputChanged() {
    final text = _inputCtrl.text;
    if (text.startsWith('/')) {
      final query = text.substring(1).toLowerCase();
      final filtered = GetIt.I<PromptProvider>()
          .getItems
          .where((p) => p.name != null && p.name!.toLowerCase().contains(query))
          .toList();
      setState(() {
        _filteredPrompts = filtered;
        _promptHighlightIndex = 0;
      });
      if (filtered.isNotEmpty) {
        _showOrUpdateOverlay();
      } else {
        _hidePromptOverlay();
      }
    } else {
      _hidePromptOverlay();
    }
  }

  void _showOrUpdateOverlay() {
    if (_promptOverlay != null) {
      _promptOverlay!.markNeedsBuild();
    } else {
      _promptOverlay = OverlayEntry(builder: (_) => _buildPromptOverlay());
      Overlay.of(context).insert(_promptOverlay!);
    }
  }

  void _hidePromptOverlay() {
    _promptOverlay?.remove();
    _promptOverlay = null;
  }

  Widget _buildPromptOverlay() {
    if (_filteredPrompts.isEmpty) return const SizedBox.shrink();
    return CompositedTransformFollower(
      link: _inputLayerLink,
      targetAnchor: Alignment.topLeft,
      followerAnchor: Alignment.bottomLeft,
      offset: const Offset(0, -4),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(8),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400, maxHeight: 220),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredPrompts.length,
              itemBuilder: (ctx, i) {
                final prompt = _filteredPrompts[i];
                final highlighted = i == _promptHighlightIndex;
                return ListTile(
                  dense: true,
                  selected: highlighted,
                  selectedTileColor: Theme.of(ctx).colorScheme.primaryContainer,
                  title: Text(prompt.name!),
                  subtitle: prompt.desc != null ? Text(prompt.desc!, maxLines: 1) : null,
                  onTap: () => _selectPrompt(prompt),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  KeyEventResult _handleInputKeyEvent(FocusNode node, KeyEvent event) {
    if (_promptOverlay == null) return KeyEventResult.ignored;
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowUp:
        setState(() {
          _promptHighlightIndex =
              (_promptHighlightIndex - 1).clamp(0, _filteredPrompts.length - 1);
        });
        _promptOverlay?.markNeedsBuild();
        return KeyEventResult.handled;
      case LogicalKeyboardKey.arrowDown:
        setState(() {
          _promptHighlightIndex =
              (_promptHighlightIndex + 1).clamp(0, _filteredPrompts.length - 1);
        });
        _promptOverlay?.markNeedsBuild();
        return KeyEventResult.handled;
      case LogicalKeyboardKey.enter:
        if (_filteredPrompts.isNotEmpty) {
          _selectPrompt(_filteredPrompts[_promptHighlightIndex]);
        }
        return KeyEventResult.handled;
      case LogicalKeyboardKey.escape:
        _hidePromptOverlay();
        return KeyEventResult.handled;
      case LogicalKeyboardKey.space:
        _hidePromptOverlay();
        return KeyEventResult.ignored;
      default:
        return KeyEventResult.ignored;
    }
  }

  Future<void> _selectPrompt(Prompt prompt) async {
    _hidePromptOverlay();
    final args = prompt.getArgs(prompt.content);
    if (args.isEmpty) {
      _inputCtrl.text = prompt.content;
      _inputCtrl.selection = TextSelection.collapsed(offset: prompt.content.length);
    } else {
      await _showArgDialog(prompt, args);
    }
  }

  Future<void> _showArgDialog(Prompt prompt, List<String> args) async {
    final controllers = {for (final a in args) a: TextEditingController()};
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('填写参数: ${prompt.name ?? ''}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: args
                .map((arg) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: TextField(
                        controller: controllers[arg],
                        decoration: InputDecoration(
                          labelText: arg,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('确认'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      final filled = {for (final e in controllers.entries) e.key: e.value.text};
      final result = prompt.build(filled);
      _inputCtrl.text = result.content;
      _inputCtrl.selection = TextSelection.collapsed(offset: result.content.length);
    }
    for (final c in controllers.values) {
      c.dispose();
    }
  }

  // ──────────────── Task management ────────────────

  Future<void> _startTask() async {
    final gen = ++_taskGeneration;
    final modelToUse = _selectedModel ?? _modelCtrl.text.trim();
    if (modelToUse.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请选择或输入模型名称')),
      );
      return;
    }
    final processor = await _taskService!.startTask(
      sessionId: _sessionId!,
      model: modelToUse,
      tools: [
        GetDbSchemaTool(),
        RunSqlQueryTool(),
        RunSqlMutationTool(),
        MasterOrchestratorTool([
          PhraseSubHandler(GetIt.I.call()),
          MistakesSubHandler(GetIt.I.call()),
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

  Future<void> _pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (result == null) return;
    final picked = result.files
        .where((f) => f.path != null)
        .map((f) => (path: f.path!, name: f.name))
        .toList();
    setState(() => _pendingImages = [..._pendingImages, ...picked]);
  }

  Future<void> _sendMessage() async {
    final text = _inputCtrl.text.trim();
    if ((text.isEmpty && _pendingImages.isEmpty) || _sessionId == null) return;
    final provider = _aiConfig?.activeProvider;
    if (provider == null) return;

    _inputCtrl.clear();
    final imagesToSend = List<({String path, String name})>.from(_pendingImages);
    setState(() {
      _isLoading = true;
      _canRegenerate = false;
      _pendingImages = [];
    });

    List<int>? imageIds;
    if (imagesToSend.isNotEmpty) {
      imageIds = await GetIt.I<ImagesProvider>().uploadImages(imagesToSend);
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
    await _startTask();
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('错误：${event.message}')),
        );
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
    _taskGeneration++;
    _sub?.cancel();
    _processor?.interrupt();
    setState(() {
      _isLoading = false;
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
    _inputCtrl.removeListener(_onInputChanged);
    _inputCtrl.dispose();
    _modelCtrl.dispose();
    _scrollCtrl.dispose();
    _inputScrollCtrl.dispose();
    _inputFocusNode.dispose();
    _hidePromptOverlay();
    _hideHistoryOverlay();
    _historyAnimCtrl.dispose();
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
          child: Row(
            children: [
              CompositedTransformTarget(
                link: _historyLayerLink,
                child: IconButton(
                  icon: const Icon(Icons.history),
                  style: IconButton.styleFrom(shape: const CircleBorder()),
                  onPressed: _historyRepo == null ? null : _toggleHistoryMenu,
                ),
              ),
              Expanded(
                child: _availableModels.isNotEmpty
                    ? DropdownButtonFormField<String>(
                        initialValue: _selectedModel,
                        decoration: const InputDecoration(
                          labelText: '模型名称',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        items: _availableModels
                            .map((model) => DropdownMenuItem(
                                  value: model,
                                  child: Text(model),
                                ))
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
                      ),
              ),
            ],
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
                  content: '',
                  isLoadingSpinner: true,
                  context: context,
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
              final actionBtn = buildMessageActions(
                msg,
                isLoading: _isLoading,
                onDelete: _deleteMessage,
                onDeleteFromHere: _deleteFromHere,
                onRegenerate: _regenerateFrom,
              );
              final cAlignment =
                  (msg.role == Roles.user || msg.role == Roles.tool)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start;

              return Column(
                crossAxisAlignment: cAlignment,
                children: [
                  msg.role == Roles.tool
                      ? buildToolRow(
                          msg.content,
                          _showContentDialog,
                          context,
                          actionBtn,
                        )
                      : Column(
                          crossAxisAlignment: cAlignment,
                          children: [
                            buildChatBubble(
                              isUser: msg.role == Roles.user,
                              content: msg.content,
                              context: context,
                              images: msg.images,
                            ),
                            actionBtn,
                          ],
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
        if (_pendingImages.isNotEmpty)
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              itemCount: _pendingImages.length,
              itemBuilder: (ctx, i) => Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.file(
                        File(_pendingImages[i].path),
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stack) =>
                            const Icon(Icons.broken_image, size: 40),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 6,
                    child: GestureDetector(
                      onTap: () => setState(
                        () => _pendingImages = [..._pendingImages]..removeAt(i),
                      ),
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, size: 12, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: CompositedTransformTarget(
            link: _inputLayerLink,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: _isLoading ? null : _pickImages,
                ),
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 120),
                    child: Scrollbar(
                      controller: _inputScrollCtrl,
                      child: TextField(
                        focusNode: _inputFocusNode,
                        controller: _inputCtrl,
                        scrollController: _inputScrollCtrl,
                        decoration: const InputDecoration(
                          hintText: '输入消息...',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        onSubmitted: (_) => _isLoading ? null : _sendMessage(),
                        maxLines: null,
                      ),
                    ),
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
        ),
      ],
    );
  }
}
