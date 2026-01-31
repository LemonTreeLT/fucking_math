import 'package:flutter/material.dart';
import 'package:fucking_math/extensions/list.dart';
import 'package:fucking_math/providers/phrase.dart';
import 'package:fucking_math/providers/words.dart';
import 'package:fucking_math/utils/mixin/form_helper.dart';
import 'package:fucking_math/utils/mixin/provider_error_handle.dart';
import 'package:fucking_math/widget/common/backgrounds.dart';
import 'package:fucking_math/widget/common/tag_selection.dart';
import 'package:fucking_math/widget/forms/action_button.dart';
import 'package:fucking_math/widget/forms/form_builders.dart';
import 'package:fucking_math/widget/ui_constants.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:fucking_math/widget/inputs/word_autocomplete_field.dart';
import 'package:provider/provider.dart';

class AddPhraseForm extends StatefulWidget {
  const AddPhraseForm({super.key});
  @override
  State<AddPhraseForm> createState() => _AddPhraseFormState();
}

class _AddPhraseFormState extends State<AddPhraseForm>
    with FormClearable<AddPhraseForm>, ProviderErrorHandler<AddPhraseForm> {
  final _phraseInputController = TextEditingController();
  final _definitionInputController = TextEditingController();
  final _noteInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Word? _selectedWord;
  String? _autocompleteText;
  Set<int> _selectedTagIds = {};
  static const _ignoredStartWords = {
    'be', 'am', 'is', 'are', 'was', 'were',
    'do', 'does', 'did',
    'to', 'a', 'an', 'the',
    'in', 'on', 'at', 'for', 'with', 'by',
    'i', 'you', 'he', 'she', 'it', 'we', 'they', // 防止换行
  };
  @override
  void initState() {
    super.initState();
    _phraseInputController.addListener(_updateLinkedWordSuggestion);
  }

  @override
  List<TextEditingController> get controllers => [
        _phraseInputController,
        _definitionInputController,
        _noteInputController,
      ];

  @override
  Set<int> get tagSelection => _selectedTagIds;

  @override
  void clearForm() {
    super.clearForm();
    setState(() {
      _selectedWord = null;
      _autocompleteText = null;
    });
  }

  @override
  void dispose() {
    _phraseInputController.removeListener(_updateLinkedWordSuggestion);
    _phraseInputController.dispose();
    _definitionInputController.dispose();
    _noteInputController.dispose();
    super.dispose();
  }

  String? _validatePhrase(String? value) {
    if (value == null || value.trim().isEmpty) return '短语不能为空';
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
    final match = wordsProvider.getItems.firstWhereOrNull(
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
    final provider = context.read<PhraseProvider>();
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
      clearForm();
    }
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
              FormBuilders.textField(
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
              FormBuilders.textField(
                controller: _definitionInputController,
                labelText: '定义 (Definition) (可选)',
                maxLines: 3,
              ),
              boxH16,
              FormBuilders.textField(
                controller: _noteInputController,
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
              Consumer<PhraseProvider>(
                builder: (context, provider, child) {
                  handleProviderError(provider.error);
                  return FormActionButtons(
                    isLoading: provider.isLoading,
                    onSubmit: _submitForm,
                    onGenerate: _generateDefinition,
                    submitLabel: '添 加 短 语',
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
