import 'package:flutter/material.dart';
import 'package:fucking_math/utils/providers/phrase_proivder.dart';
import 'package:fucking_math/utils/providers/words_proivder.dart';
import 'package:fucking_math/widget/backgrounds.dart';
import 'package:fucking_math/widget/collection.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:fucking_math/widget/word_autocomplete_field.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class AddPhraseFrom extends StatefulWidget {
  const AddPhraseFrom({super.key});

  @override
  State<AddPhraseFrom> createState() => _AddPhraseFormState();
}

class _AddPhraseFormState extends State<AddPhraseFrom> {
  final _phraseInputController = TextEditingController();
  final _definitionInputController = TextEditingController();
  final _noteInputController = TextEditingController();
  final _linkedWordController = TextEditingController();
  // Controllers

  final _formKey = GlobalKey<FormState>();

  Word? _selectedWord;

  @override
  void initState() {
    super.initState();
    _phraseInputController.addListener(_updateLinkedWord);
  }

  void _updateLinkedWord() {
    final text = _phraseInputController.text.trim();

    if (text.isEmpty) return;

    final firstWord = text.split(' ').first.toLowerCase();

    final wordsProvider = context.read<WordsProvider>();
    Word? match = wordsProvider.words.firstWhereOrNull(
      (word) => word.word.toLowerCase() == firstWord,
    );

    if (match != null && _selectedWord == null) {
      _linkedWordController.text = match.word;
    }
  }

  @override
  void dispose() {
    _phraseInputController.dispose();
    _definitionInputController.dispose();
    _noteInputController.dispose();
    _linkedWordController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_selectedWord == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('请先选择一个关联单词')));
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final phrase = _phraseInputController.text.trim();
    final definition = _definitionInputController.text.trim();
    final note = _noteInputController.text.trim();

    // TODO: 实现tag添加逻辑
    final List<Tag> tags = [];

    final provider = context.read<PhraseProivder>();
    await provider.addPhrases(
      _selectedWord!.id,
      phrase,
      definition: definition.isEmpty ? null : definition,
      note: note.isEmpty ? null : note,
      tags: tags.map((tag) => tag.id).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BorderedContainerWithTopText(
      labelText: "Phrases",
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 短语输入
              textInputer(
                _phraseInputController,
                '短语 (Phrase)',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return '输入不能为空';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 选择关联单词
              WordAutocompleteField(
                controller: _linkedWordController,
                onWordSelected: (selectedWord) {
                  setState(() {
                    _selectedWord = selectedWord;
                  });
                  if (selectedWord != null) {
                    _linkedWordController.text = selectedWord.word;
                  }
                },
              ),
              const SizedBox(height: 16),

              // 定义输入
              textInputer(
                _definitionInputController,
                '定义 (Definition)',
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // 备注输入
              textInputer(_noteInputController, '备注 (Notes)'),
              const SizedBox(height: 16),

              // 标签选择区域
              // TODO: 实现标签选择功能
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

              // 按钮区域
              Spacer(),
              Row(
                spacing: 8,
                children: [
                  ElevatedButton.icon(
                    onPressed: _submitForm,
                    icon: Icon(Icons.add),
                    label: Text("Add Phrase"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: ai生成定义逻辑
                    },
                    icon: Icon(Icons.translate),
                    label: Text("Generate Definition"),
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
