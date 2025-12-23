import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fucking_math/utils/providers/english_proivder.dart';

class AddWordForm extends StatefulWidget {
  const AddWordForm({super.key});

  @override
  State<AddWordForm> createState() => _AddWordFormState();
}

class _AddWordFormState extends State<AddWordForm> {
  // 1. 局部状态：用于管理文本输入
  final _wordController = TextEditingController();
  final _definitionController = TextEditingController();

  // 3. 局部状态：用于管理表单验证
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // 释放资源，防止内存泄漏
    _wordController.dispose();
    _definitionController.dispose();
    super.dispose();
  }

  // --- 提交逻辑 ---
  void _submitForm() async {
    // 验证表单
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final provider = context.read<WordsProvider>();
    final word = _wordController.text.trim();
    final definition = _definitionController.text.trim().isEmpty
        ? null
        : _definitionController.text.trim();

    // TODO: Complete tags feature
    const List<int>? tags = null;

    try {
      await provider.addWord(word, definition: definition, tags: tags);

      // 成功后清空表单
      _wordController.clear();
      _definitionController.clear();

      // 显示成功提示
      if (context.mounted) {
        ScaffoldMessenger.of(
          // ignore: use_build_context_synchronously
          context,
        ).showSnackBar(SnackBar(content: Text('单词 "$word" 添加成功!')));
      }
    } catch (e) {
      // 错误信息会由 provider 内部处理和打印
      if (context.mounted) {
        ScaffoldMessenger.of(
          // ignore: use_build_context_synchronously
          context,
        ).showSnackBar(SnackBar(content: Text('添加失败: ${provider.error}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // --- 1. 单词输入 ---
              TextFormField(
                controller: _wordController,
                decoration: const InputDecoration(
                  labelText: '单词 (Word)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '单词不能为空';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // --- 2. 定义输入 ---
              TextFormField(
                controller: _definitionController,
                decoration: const InputDecoration(
                  labelText: '定义 (Definition) (可选)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // --- 3. 标签 (Tags) 预留扩展区域 ---
              // 暂时用一个 Container 占位
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '标签选择区域 (Tags) - 待扩展',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 24),

              Row(
                spacing: 8.0,

                children: [
                  // --- 5. 提交按钮 ---
                  ElevatedButton.icon(
                    onPressed: _submitForm,
                    icon: const Icon(Icons.add),
                    label: const Text('添 加 单 词'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: implement ai definition generation.
                    },
                    icon: const Icon(Icons.translate),
                    label: const Text("ai 生成释义"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
