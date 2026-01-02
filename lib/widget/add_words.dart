import 'package:flutter/material.dart';
import 'package:fucking_math/widget/backgrounds.dart';
import 'package:fucking_math/widget/collection.dart';
import 'package:fucking_math/widget/ui_constants.dart';
import 'package:provider/provider.dart';
import 'package:fucking_math/utils/providers/words_proivder.dart';

class AddWordForm extends StatefulWidget {
  const AddWordForm({super.key});

  @override
  State<AddWordForm> createState() => _AddWordFormState();
}

class _AddWordFormState extends State<AddWordForm> {
  final _wordController = TextEditingController();
  final _definitionController = TextEditingController();
  final _definitionPreController = TextEditingController();
  final _noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _wordController.dispose();
    _definitionController.dispose();
    _definitionPreController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  String? _validateWord(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '单词不能为空';
    }
    if (value.contains(' ')) {
      return '单词不应该包含空格';
    }
    return null;
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<WordsProvider>();
    final word = _wordController.text.trim();
    final definitionPre = _definitionPreController.text.trim();
    final definition = _definitionController.text.trim().isEmpty
        ? null
        : _definitionController.text.trim();
    final note = _noteController.text.trim();

    await provider.addWord(
      word,
      definition: definition,
      definitionPre: definitionPre,
      note: note,
      tags: null, // TODO: Complete tags feature
    );

    // Provider内部已处理错误，只需要在成功时清空表单
    if (provider.error == null) _clearForm();
  }

  void _clearForm() {
    _wordController.clear();
    _definitionController.clear();
    _definitionPreController.clear();
    _noteController.clear();
  }

  void _generateDefinition() {
    // TODO: implement ai definition generation
  }

  @override
  Widget build(BuildContext context) {
    return BorderedContainerWithTopText(
      labelText: "Single Words",
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              textInputer(
                controller: _wordController,
                labelText: '单词 (Word)',
                validator: _validateWord,
              ),
              boxH16,
              textInputer(
                controller: _definitionPreController,
                labelText: '简写定义 eg. (apple n. 苹果)',
              ),
              boxH16,
              textInputer(
                controller: _definitionController,
                labelText: '定义 (Definition) (可选)',
                maxLines: 3,
              ),
              boxH16,
              textInputer(
                controller: _noteController,
                labelText: '备注 (Notes) (可选)',
              ),
              boxH16,
              _buildTagsPlaceholder(),
              const Spacer(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTagsPlaceholder() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text('标签选择区域 (Tags) - 待扩展', style: TextStyle(color: grey)),
    );
  }

  Widget _buildActionButtons() {
    return Consumer<WordsProvider>(
      builder: (context, provider, child) {
        return Row(
          spacing: 8.0,
          children: [
            ElevatedButton.icon(
              onPressed: provider.isLoading ? null : _submitForm,
              icon: const Icon(Icons.add),
              label: const Text('添 加 单 词'),
            ),
            ElevatedButton.icon(
              onPressed: provider.isLoading ? null : _generateDefinition,
              icon: const Icon(Icons.translate),
              label: const Text("ai 生成释义"),
            ),
          ],
        );
      },
    );
  }
}
