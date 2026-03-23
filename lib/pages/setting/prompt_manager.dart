import 'package:flutter/material.dart';
import 'package:fucking_math/ai/types.dart' show Prompt;
import 'package:fucking_math/providers/prompt.dart';
import 'package:fucking_math/widget/common/backgrounds.dart';
import 'package:fucking_math/widget/ui_constants.dart';
import 'package:provider/provider.dart';

class PromptManager extends StatefulWidget {
  const PromptManager({super.key});

  @override
  State<PromptManager> createState() => _PromptManagerState();
}

class _PromptManagerState extends State<PromptManager> {
  bool _isCreatingNew = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PromptProvider>().loadPrompts();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Prompt 管理")),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(flex: 1, child: _buildListArea()),
          boxW16,
          Expanded(flex: 1, child: _buildDetailArea()),
        ],
      ),
    ),
  );

  Widget _buildListArea() => BorderedContainerWithTopText(
    labelText: "Prompt 列表",
    child: Column(
      children: [
        Expanded(
          child: Consumer<PromptProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (provider.getItems.isEmpty) {
                return const Center(
                  child: Text(
                    "暂无 Prompt，点击下方按钮添加",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }
              return ListView.separated(
                itemCount: provider.getItems.length,
                separatorBuilder: (_, _) => const Divider(),
                itemBuilder: (context, index) =>
                    _buildListItem(provider.getItems[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => setState(() {
              context.read<PromptProvider>().select(null);
              _isCreatingNew = true;
            }),
            icon: const Icon(Icons.add),
            label: const Text("添加新 Prompt"),
          ),
        ),
      ],
    ),
  );

  Widget _buildListItem(Prompt prompt) => Consumer<PromptProvider>(
    builder: (context, provider, _) => InkWell(
      onTap: () {
        provider.select(prompt);
        setState(() => _isCreatingNew = false);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              prompt.name ?? 'Unnamed',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (prompt.desc?.isNotEmpty ?? false) ...[
              const SizedBox(height: 4),
              Text(
                prompt.desc!,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    ),
  );

  Widget _buildDetailArea() {
    final provider = context.watch<PromptProvider>();

    if (provider.error != null) {
      return BorderedContainerWithTopText(
        labelText: "错误",
        child: Center(child: Text(provider.error!)),
      );
    }

    if (_isCreatingNew) {
      return _PromptForm(
        key: const ValueKey('new'),
        prompt: null,
        onSaved: () => setState(() => _isCreatingNew = false),
      );
    }

    if (provider.selectedItem == null) {
      return BorderedContainerWithTopText(
        labelText: "详情与编辑",
        child: const Center(
          child: Text(
            "点击左侧 Prompt 查看详情，或点击\"添加新 Prompt\"创建",
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return _PromptForm(
      key: ValueKey(provider.selectedItem!.id),
      prompt: provider.selectedItem!,
      onSaved: null,
    );
  }
}

class _PromptForm extends StatefulWidget {
  final Prompt? prompt;
  final VoidCallback? onSaved;

  const _PromptForm({super.key, required this.prompt, required this.onSaved});

  @override
  State<_PromptForm> createState() => _PromptFormState();
}

class _PromptFormState extends State<_PromptForm> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _contentCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.prompt?.name ?? '');
    _descCtrl = TextEditingController(text: widget.prompt?.desc ?? '');
    _contentCtrl = TextEditingController(text: widget.prompt?.content ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BorderedContainerWithTopText(
    labelText: widget.prompt == null ? "新建 Prompt" : "编辑 Prompt",
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _nameCtrl,
          decoration: const InputDecoration(
            labelText: "名称",
            border: OutlineInputBorder(),
            isDense: true,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _descCtrl,
          decoration: const InputDecoration(
            labelText: "描述",
            border: OutlineInputBorder(),
            isDense: true,
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: TextField(
            controller: _contentCtrl,
            textAlignVertical: .top,
            decoration: const InputDecoration(
              labelText: "内容",
              border: OutlineInputBorder(),
              isDense: true,
              alignLabelWithHint: true,
            ),
            maxLines: null,
            expands: true,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (!(widget.prompt == null))
              TextButton.icon(
                onPressed: _delete,
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                label: const Text("删除", style: TextStyle(color: Colors.red)),
              ),
            const SizedBox(width: 8),
            FilledButton(
              onPressed: _save,
              child: Text(widget.prompt == null ? "创建" : "更新"),
            ),
          ],
        ),
      ],
    ),
  );

  Future<void> _save() async {
    final content = _contentCtrl.text.trim();
    if (content.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("内容不能为空")));
      return;
    }
    final provider = context.read<PromptProvider>();
    final name = _nameCtrl.text.trim().isEmpty ? null : _nameCtrl.text.trim();
    final desc = _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim();

    if (widget.prompt == null) {
      await provider.createPrompt(content: content, name: name, desc: desc);
      widget.onSaved?.call();
    } else {
      await provider.updatePrompt(
        widget.prompt!.id!,
        name: name,
        desc: desc,
        content: content,
      );
    }
  }

  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("确认删除"),
        content: Text('删除 "${widget.prompt?.name ?? 'Unnamed'}"？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("取消"),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("删除"),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      await context.read<PromptProvider>().deletePrompt(widget.prompt!.id!);
    }
  }
}
