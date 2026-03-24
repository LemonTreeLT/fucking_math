import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fucking_math/ai/types.dart';
import 'package:fucking_math/providers/prompt.dart';
import 'package:get_it/get_it.dart';

class AiChatPromptOverlay extends StatefulWidget {
  const AiChatPromptOverlay({
    super.key,
    required this.inputController,
    required this.inputLayerLink,
  });

  final TextEditingController inputController;
  final LayerLink inputLayerLink;

  @override
  State<AiChatPromptOverlay> createState() => AiChatPromptOverlayState();
}

class AiChatPromptOverlayState extends State<AiChatPromptOverlay> {
  // ──────────────── Layout ────────────────

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();

  Widget _buildOverlay() {
    if (_filtered.isEmpty) return const SizedBox.shrink();
    return CompositedTransformFollower(
      link: widget.inputLayerLink,
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
              itemCount: _filtered.length,
              itemBuilder: (ctx, i) => ListTile(
                dense: true,
                selected: i == _highlightIndex,
                selectedTileColor: Theme.of(ctx).colorScheme.primaryContainer,
                title: Text(_filtered[i].name!),
                subtitle: _filtered[i].desc != null
                    ? Text(_filtered[i].desc!, maxLines: 1)
                    : null,
                onTap: () => _selectPrompt(_filtered[i]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============ LAYOUT CODES ABOVE ============

  List<Prompt> _filtered = [];
  int _highlightIndex = 0;
  OverlayEntry? _overlay;

  @override
  void initState() {
    super.initState();
    widget.inputController.addListener(_onInputChanged);
  }

  @override
  void dispose() {
    widget.inputController.removeListener(_onInputChanged);
    _hideOverlay();
    super.dispose();
  }

  KeyEventResult handleKeyEvent(FocusNode node, KeyEvent event) {
    if (_overlay == null) return KeyEventResult.ignored;
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowUp:
        setState(() => _highlightIndex =
            (_highlightIndex - 1).clamp(0, _filtered.length - 1));
        _overlay?.markNeedsBuild();
        return KeyEventResult.handled;
      case LogicalKeyboardKey.arrowDown:
        setState(() => _highlightIndex =
            (_highlightIndex + 1).clamp(0, _filtered.length - 1));
        _overlay?.markNeedsBuild();
        return KeyEventResult.handled;
      case LogicalKeyboardKey.enter:
        if (_filtered.isNotEmpty) _selectPrompt(_filtered[_highlightIndex]);
        return KeyEventResult.handled;
      case LogicalKeyboardKey.escape:
        _hideOverlay();
        return KeyEventResult.handled;
      case LogicalKeyboardKey.space:
        _hideOverlay();
        return KeyEventResult.ignored;
      default:
        return KeyEventResult.ignored;
    }
  }

  void _onInputChanged() {
    final text = widget.inputController.text;
    if (text.startsWith('/')) {
      final query = text.substring(1).toLowerCase();
      final filtered = GetIt.I<PromptProvider>()
          .getItems
          .where((p) => p.name != null && p.name!.toLowerCase().contains(query))
          .toList();
      setState(() {
        _filtered = filtered;
        _highlightIndex = 0;
      });
      filtered.isNotEmpty ? _showOrUpdate() : _hideOverlay();
    } else {
      _hideOverlay();
    }
  }

  void _showOrUpdate() {
    if (_overlay != null) {
      _overlay!.markNeedsBuild();
    } else {
      _overlay = OverlayEntry(builder: (_) => _buildOverlay());
      Overlay.of(context).insert(_overlay!);
    }
  }

  void _hideOverlay() {
    _overlay?.remove();
    _overlay = null;
  }

  Future<void> _selectPrompt(Prompt prompt) async {
    _hideOverlay();
    final args = prompt.getArgs(prompt.content);
    if (args.isEmpty) {
      widget.inputController.text = prompt.content;
      widget.inputController.selection =
          TextSelection.collapsed(offset: prompt.content.length);
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
      widget.inputController.text = result.content;
      widget.inputController.selection =
          TextSelection.collapsed(offset: result.content.length);
    }
    for (final c in controllers.values) {
      c.dispose();
    }
  }
}
