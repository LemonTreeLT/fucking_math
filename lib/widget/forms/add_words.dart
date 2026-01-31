import 'package:flutter/material.dart';
import 'package:fucking_math/utils/mixin/form_helper.dart';
import 'package:fucking_math/utils/mixin/provider_error_handle.dart';
import 'package:fucking_math/widget/common/backgrounds.dart';
import 'package:fucking_math/widget/forms/action_button.dart';
import 'package:fucking_math/widget/forms/form_builders.dart';
import 'package:fucking_math/widget/ui_constants.dart';
import 'package:fucking_math/widget/common/tag_selection.dart';
import 'package:provider/provider.dart';
import 'package:fucking_math/providers/words.dart';

class AddWordForm extends StatefulWidget {
  const AddWordForm({super.key});
  @override
  State<AddWordForm> createState() => _AddWordFormState();
}

class _AddWordFormState extends State<AddWordForm>
    with FormClearable<AddWordForm>, ProviderErrorHandler<AddWordForm> {
  final _wordController = TextEditingController();
  final _definitionController = TextEditingController();
  final _definitionPreController = TextEditingController();
  final _noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Set<int> _selectedTagIds = {};
  @override
  List<TextEditingController> get controllers => [
        _wordController,
        _definitionController,
        _definitionPreController,
        _noteController
      ];

  @override
  Set<int> get tagSelection => _selectedTagIds;

  @override
  void dispose() {
    _wordController.dispose();
    _definitionController.dispose();
    _definitionPreController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  String? _validateWord(String? value) {
    if (value == null || value.trim().isEmpty) return '单词不能为空';
    if (value.contains(' ')) return '单词不应该包含空格';
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
      tags: _selectedTagIds.isEmpty ? null : _selectedTagIds.toList(),
    );
    if (provider.error == null) clearForm();
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
              FormBuilders.textField(
                controller: _wordController,
                labelText: '单词 (Word)',
                validator: _validateWord,
              ),
              boxH16,
              FormBuilders.textField(
                controller: _definitionPreController,
                labelText: '简写定义 eg. (apple n. 苹果)',
              ),
              boxH16,
              FormBuilders.textField(
                controller: _definitionController,
                labelText: '定义 (Definition) (可选)',
                maxLines: 3,
              ),
              boxH16,
              FormBuilders.textField(
                controller: _noteController,
                labelText: '备注 (Notes) (可选)',
              ),
              boxH16,
              TagSelectionArea(
                selectedTagIds: _selectedTagIds,
                onSelectionChanged: (newSelection) {
                  setState(() => _selectedTagIds = newSelection);
                },
              ),
              const Spacer(),
              Consumer<WordsProvider>(
                builder: (context, provider, child) {
                  handleProviderError(provider.error);
                  return FormActionButtons(
                    isLoading: provider.isLoading,
                    onSubmit: _submitForm,
                    onGenerate: _generateDefinition,
                    submitLabel: '添 加 单 词',
                    generateLabel: 'AI 生成释义',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
