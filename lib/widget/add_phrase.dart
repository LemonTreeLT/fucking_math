import 'package:flutter/material.dart';
import 'package:fucking_math/utils/providers/phrase_proivder.dart';
import 'package:fucking_math/utils/providers/words_proivder.dart';
import 'package:fucking_math/widget/backgrounds.dart';
import 'package:fucking_math/widget/collection.dart';
import 'package:fucking_math/widget/tag_selection.dart';
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
  final _phraseInputController = TextEditingController();
  final _definitionInputController = TextEditingController();
  final _noteInputController = TextEditingController();
  final _linkedWordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Word? _selectedWord;
  String? _autocompleteText;
  Set<int> _selectedTagIds = {};

  static const _ignoredStartWords = {
    'be', 'am', 'is', 'are', 'was', 'were',
    'do', 'does', 'did',
    'to', 'a', 'an', 'the',
    'in', 'on', 'at', 'for', 'with', 'by',
    'i', 'you', 'he', 'she', 'it', 'we', 'they',
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

  String? _validatePhrase(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '短语不能为空';
    }
    return null;
  }

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

  String _findTargetWord(List<String> words) {
    if (words.isEmpty) return '';

    final firstWord = words.first.toLowerCase();
    if (_ignoredStartWords.contains(firstWord) && words.length > 1) {
      return words[1].toLowerCase();
    }
    return firstWord;
  }

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
      tags: _selectedTagIds.isEmpty ? null : _selectedTagIds.toList(),
    );

    if (provider.error == null) {
      _clearForm();
    }
  }

  void _clearForm() {
    _phraseInputController.clear();
    _definitionInputController.clear();
    _noteInputController.clear();
    setState(() {
      _selectedWord = null;
      _autocompleteText = null;
      _selectedTagIds.clear();
    });
  }

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
              TagSelectionArea( // ✅ 使用共享组件
                selectedTagIds: _selectedTagIds,
                onSelectionChanged: (newSelection) {
                  setState(() => _selectedTagIds = newSelection);
                },
              ),
              const Spacer(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

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
