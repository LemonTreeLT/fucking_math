import 'package:flutter/material.dart';
import 'package:fucking_math/ai/types.dart';
import 'package:fucking_math/providers/prompt.dart';
import 'package:get_it/get_it.dart';

class AiSystemPromptDialog extends StatefulWidget {
  const AiSystemPromptDialog({super.key, this.initialPrompt});

  final String? initialPrompt;

  @override
  State<AiSystemPromptDialog> createState() => _AiSystemPromptDialogState();
}

class _AiSystemPromptDialogState extends State<AiSystemPromptDialog> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(text: widget.initialPrompt ?? '');
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Row(
      children: [
        const Expanded(child: Text('System Prompt')),
        PopupMenuButton<Prompt>(
          tooltip: '加载已有提示词',
          icon: const Icon(Icons.library_books_outlined),
          itemBuilder: (_) => GetIt.I<PromptProvider>()
              .getItems
              .where((p) => p.name != null)
              .map((p) => PopupMenuItem(
                    value: p,
                    child: ListTile(
                      title: Text(p.name!),
                      subtitle: p.desc != null
                          ? Text(p.desc!, maxLines: 1, overflow: TextOverflow.ellipsis)
                          : null,
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ))
              .toList(),
          onSelected: _loadPrompt,
        ),
      ],
    ),
    content: SizedBox(
      width: 500,
      height: 280,
      child: TextField(
        controller: _ctrl,
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
        onPressed: () => Navigator.pop(context),
        child: const Text('取消'),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context, ''),
        child: const Text('清除'),
      ),
      FilledButton(
        onPressed: () => Navigator.pop(context, _ctrl.text.trim()),
        child: const Text('确认'),
      ),
    ],
  );

  Future<void> _loadPrompt(Prompt prompt) async {
    final args = prompt.getArgs(prompt.content);
    if (args.isEmpty) {
      _ctrl.text = prompt.content;
      return;
    }
    final controllers = {for (final a in args) a: TextEditingController()};
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('填写参数: ${prompt.name ?? ''}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final arg in args)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TextField(
                    controller: controllers[arg],
                    decoration: InputDecoration(
                      labelText: arg,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
            ],
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
      _ctrl.text = prompt
          .build({for (final e in controllers.entries) e.key: e.value.text})
          .content;
    }
    for (final c in controllers.values) {
      c.dispose();
    }
  }
}
