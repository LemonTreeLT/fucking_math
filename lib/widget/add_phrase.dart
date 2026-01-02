import 'package:flutter/material.dart';
import 'package:fucking_math/utils/providers/phrase_proivder.dart';
import 'package:fucking_math/utils/providers/words_proivder.dart';
import 'package:fucking_math/widget/backgrounds.dart';
import 'package:fucking_math/widget/collection.dart';
import 'package:fucking_math/widget/ui_constants.dart';
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
  // 控制器
  final _phraseInputController = TextEditingController();
  final _definitionInputController = TextEditingController();
  final _noteInputController = TextEditingController();
  final _linkedWordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // 状态
  Word? _selectedWord;
  String? _autocompleteText;

  // 常量
  static const _ignoredStartWords = {
    'be', 'am', 'is', 'are', 'was', 'were',
    'do', 'does', 'did',
    'to', 'a', 'an', 'the',
    'in', 'on', 'at', 'for', 'with', 'by',
    'i', 'you', 'he', 'she', 'it', 'we', 'they', // 多行集合
  };

  @override
  void initState() {
    super.initState();
    _phraseInputController.addListener(_updateLinkedWordSuggestion);
  }

  @override
  void dispose() {
    _phraseInputController.removeListener(_updateLinkedWordSuggestion);
    _phraseInputController.dispose();
    _definitionInputController.dispose();
    _noteInputController.dispose();
    _linkedWordController.dispose();
    super.dispose();
  }

  // 验证短语输入
  String? _validatePhrase(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '短语不能为空';
    }
    return null;
  }

  // 更新关联单词建议
  void _updateLinkedWordSuggestion() {
    final text = _phraseInputController.text.trim();

    if (text.isEmpty) {
      setState(() {
        _selectedWord = null;
        _autocompleteText = null;
      });
      return;
    }

    final words = text.split(' ').where((s) => s.isNotEmpty).toList();
    if (words.isEmpty) return;

    final targetWord = _findTargetWord(words);
    final wordsProvider = context.read<WordsProvider>();
    final match = wordsProvider.words.firstWhereOrNull(
      (word) => word.word.toLowerCase().startsWith(targetWord),
    );

    if (match != null) {
      setState(() {
        _selectedWord = match;
        _autocompleteText = match.word;
      });
    }
  }

  // 查找目标单词（跳过忽略词）
  String _findTargetWord(List<String> words) {
    if (words.isEmpty) return '';

    final firstWord = words.first.toLowerCase();
    if (_ignoredStartWords.contains(firstWord) && words.length > 1) {
      return words[1].toLowerCase();
    }
    return firstWord;
  }

  // 提交表单
  Future<void> _submitForm() async {
    if (_selectedWord == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('请先选择一个关联单词')));
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<PhraseProivder>();
    final phrase = _phraseInputController.text.trim();
    final definition = _definitionInputController.text.trim();
    final note = _noteInputController.text.trim();

    await provider.addPhrases(
      _selectedWord!.id,
      phrase,
      definition: definition.isEmpty ? null : definition,
      note: note.isEmpty ? null : note,
      tags: null, // TODO: Complete tags feature
    );

    // Provider内部已处理错误，只需要在成功时清空表单
    if (provider.error == null) {
      _clearForm();
    }
  }

  // 清空表单
  void _clearForm() {
    _phraseInputController.clear();
    _definitionInputController.clear();
    _noteInputController.clear();
    setState(() {
      _selectedWord = null;
      _autocompleteText = null;
    });
  }

  // AI 生成定义（待实现）
  void _generateDefinition() {
    // TODO: implement ai definition generation
  }

  @override
  Widget build(BuildContext context) {
    return BorderedContainerWithTopText(
      labelText: "Phrases",
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              textInputer(
                controller: _phraseInputController,
                labelText: '短语 (Phrase)',
                validator: _validatePhrase,
              ),
              boxH16,
              WordAutocompleteField(
                initialValue: _autocompleteText,
                onWordSelected: (selectedWord) => setState(() {
                  _selectedWord = selectedWord;
                  _autocompleteText = selectedWord?.word;
                }),
              ),
              boxH16,
              textInputer(
                controller: _definitionInputController,
                labelText: '定义 (Definition) (可选)',
                maxLines: 3,
              ),
              boxH16,
              textInputer(
                controller: _noteInputController,
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

  // 标签占位区域
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

  // 操作按钮区域
  Widget _buildActionButtons() {
    return Consumer<PhraseProivder>(
      builder: (context, provider, child) {
        return Row(
          spacing: 8.0,
          children: [
            ElevatedButton.icon(
              onPressed: provider.isLoading ? null : _submitForm,
              icon: const Icon(Icons.add),
              label: const Text('添 加 短 语'),
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
