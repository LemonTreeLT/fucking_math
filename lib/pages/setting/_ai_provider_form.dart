import 'package:flutter/material.dart';
import 'package:fucking_math/db/app_database.dart' show AiProvider;
import 'package:fucking_math/providers/ai_provider.dart';
import 'package:fucking_math/widget/common/backgrounds.dart';
import 'package:fucking_math/widget/forms/form_builders.dart';
import 'package:fucking_math/widget/ui_constants.dart';
import 'package:provider/provider.dart';

class AiProviderForm extends StatefulWidget {
  const AiProviderForm({
    required this.provider,
    required this.onCreated,
    super.key,
  });

  /// null 表示创建模式，非 null 表示编辑模式
  final AiProvider? provider;
  final VoidCallback? onCreated;

  @override
  State<AiProviderForm> createState() => _AiProviderFormState();
}

class _AiProviderFormState extends State<AiProviderForm> {
  late TextEditingController _nameController;
  late TextEditingController _baseUrlController;
  late TextEditingController _apiKeyController;
  late TextEditingController _descriptionController;
  bool _showApiKey = false;
  final _formKey = GlobalKey<FormState>();

  bool get _isCreating => widget.provider == null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.provider?.name ?? '');
    _baseUrlController =
        TextEditingController(text: widget.provider?.baseUrl ?? '');
    _apiKeyController =
        TextEditingController(text: widget.provider?.apiKey ?? '');
    _descriptionController =
        TextEditingController(text: widget.provider?.description ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _baseUrlController.dispose();
    _apiKeyController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BorderedContainerWithTopText(
    labelText: _isCreating ? "新建提供商" : "详情与编辑",
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildFormContent(),
            const Spacer(),
            _buildActionButtons(),
          ],
        ),
      ),
    ),
  );

  Widget _buildFormContent() => SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormBuilders.textField(
          controller: _nameController,
          labelText: '名称',
          hintText: '如：OpenAI, Claude API',
          validator: _validateName,
        ),
        boxH16,
        FormBuilders.textField(
          controller: _baseUrlController,
          labelText: 'Base URL',
          hintText: '如：https://api.openai.com/v1',
          validator: _validateBaseUrl,
        ),
        boxH16,
        _buildApiKeyField(),
        boxH16,
        FormBuilders.textField(
          controller: _descriptionController,
          labelText: '描述',
          hintText: '输入提供商描述（可选）',
          maxLines: 3,
        ),
      ],
    ),
  );

  Widget _buildApiKeyField() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'API Key',
        style: Theme.of(context).inputDecorationTheme.labelStyle,
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: _apiKeyController,
        obscureText: !_showApiKey,
        decoration: InputDecoration(
          hintText: '输入您的 API Key',
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(
              _showApiKey ? Icons.visibility_off : Icons.visibility,
              size: 20,
            ),
            onPressed: () => setState(() => _showApiKey = !_showApiKey),
          ),
        ),
        validator: _validateApiKey,
      ),
    ],
  );

  Widget _buildActionButtons() => Row(
    spacing: 8,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      if (!_isCreating)
        ElevatedButton.icon(
          onPressed: _handleDelete,
          icon: const Icon(Icons.delete),
          label: const Text("删除"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade600,
            foregroundColor: Colors.white,
          ),
        ),
      ElevatedButton.icon(
        onPressed: _isCreating ? _handleCreate : _handleSave,
        icon: Icon(_isCreating ? Icons.add : Icons.save),
        label: Text(_isCreating ? "创建" : "保存"),
      ),
    ],
  );

  String? _validateName(String? value) =>
      value == null || value.trim().isEmpty ? '名称不能为空' : null;

  String? _validateBaseUrl(String? value) =>
      value == null || value.trim().isEmpty ? 'Base URL 不能为空' : null;

  String? _validateApiKey(String? value) =>
      value == null || value.trim().isEmpty ? 'API Key 不能为空' : null;

  Future<void> _handleCreate() async {
    if (!_formKey.currentState!.validate()) return;

    final providerNotifier = context.read<AiProviderProvider>();
    await providerNotifier.createProvider(
      name: _nameController.text.trim(),
      baseUrl: _baseUrlController.text.trim(),
      apiKey: _apiKeyController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("提供商已创建")),
    );
    widget.onCreated?.call();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    final providerNotifier = context.read<AiProviderProvider>();
    final p = widget.provider!;
    await providerNotifier.updateProvider(
      AiProvider(
        id: p.id,
        name: _nameController.text.trim(),
        baseUrl: _baseUrlController.text.trim(),
        apiKey: _apiKeyController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        iconId: p.iconId,
        isActive: p.isActive,
        createdAt: p.createdAt,
      ),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("提供商已保存")),
    );
  }

  Future<void> _handleDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("确认删除"),
        content: Text("确定要删除提供商 ${widget.provider!.name} 吗？"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("取消"),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("删除"),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    await context.read<AiProviderProvider>().deleteProvider(widget.provider!.id);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("提供商已删除")),
    );
  }
}
