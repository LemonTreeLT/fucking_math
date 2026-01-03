// lib/widget/word_autocomplete_field.dart
import 'package:flutter/material.dart';
import 'package:fucking_math/providers/words_proivder.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:provider/provider.dart';

class WordAutocompleteField extends StatelessWidget {
  // <--- 改回 StatelessWidget
  final Function(Word? selectedWord) onWordSelected;
  final String? initialValue;
  const WordAutocompleteField({
    super.key,
    required this.onWordSelected,
    this.initialValue,
  });
  @override
  Widget build(BuildContext context) {
    final wordsProvider = context.watch<WordsProvider>();
    final key = ValueKey<String?>(initialValue);
    return Autocomplete<Word>(
      key: key, // <-- 传递 Key
      initialValue: TextEditingValue(text: initialValue ?? ''), // <-- 设置初始值
      displayStringForOption: (Word option) => option.word,

      optionsBuilder: (TextEditingValue textEditingValue) {
        final query = textEditingValue.text.toLowerCase();
        if (query.isEmpty) {
          // 当输入框变为空时，通知父组件 selection 已清除
          // 使用 addPostFrameCallback 防止在 build 期间调用 setState
          WidgetsBinding.instance.addPostFrameCallback((_) {
            onWordSelected(null);
          });
          return const Iterable<Word>.empty();
        }
        return wordsProvider.words.where((Word word) {
          return word.word.toLowerCase().startsWith(query);
        });
      },

      onSelected: onWordSelected, // 直接传递回调
      fieldViewBuilder:
          (
            BuildContext context,
            TextEditingController fieldTextEditingController, // <-- 使用这个！
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return TextFormField(
              controller: fieldTextEditingController, // <-- 重新用回它
              focusNode: fieldFocusNode,
              decoration: const InputDecoration(
                labelText: '关联单词 (Linked Word)',
                hintText: '输入短语可自动匹配，或手动搜索',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  final isMatch = wordsProvider.words.any(
                    (w) => w.word.toLowerCase() == value.toLowerCase(),
                  );
                  if (!isMatch) {
                    return '请从列表中选择一个有效的单词';
                  }
                }
                return null;
              },
            );
          },
      // 自定义下拉列表的 UI
      optionsViewBuilder:
          (
            BuildContext context,
            AutocompleteOnSelected<Word> onSelected,
            Iterable<Word> options,
          ) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 250),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Word option = options.elementAt(index);
                      return ListTile(
                        title: Text(option.word),
                        subtitle: Text(
                          option.definitionPreview ?? '暂无预览',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          onSelected(option);
                        },
                      );
                    },
                  ),
                ),
              ),
            );
          },
    );
  }
}
