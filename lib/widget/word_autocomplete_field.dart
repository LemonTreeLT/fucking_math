// lib/widget/word_autocomplete_field.dart
import 'package:flutter/material.dart';
import 'package:fucking_math/utils/providers/word_proivder.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:provider/provider.dart';

class WordAutocompleteField extends StatelessWidget {
  final Function(Word? selectedWord) onWordSelected;
  final TextEditingController? controller;
  final String? initialValue;

  const WordAutocompleteField({
    Key? key,
    required this.onWordSelected,
    this.controller,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 确保 WordsProvider 可用
    final wordsProvider = context.watch<WordsProvider>();

    return Autocomplete<Word>(
      // 告诉 Autocomplete 如何将 Word 对象转为字符串显示在输入框里
      displayStringForOption: (Word option) => option.word,

      // 核心：根据用户输入构建选项列表
      optionsBuilder: (TextEditingValue textEditingValue) {
        final query = textEditingValue.text.toLowerCase();
        if (query.isEmpty) {
          return const Iterable<Word>.empty();
        }
        return wordsProvider.words.where((Word word) {
          return word.word.toLowerCase().startsWith(query);
        });
      },

      // 当用户从下拉列表中选择一项时调用
      onSelected: (Word selection) {
        onWordSelected(selection);
      },

      // 自定义输入框的外观
      fieldViewBuilder:
          (
            BuildContext context,
            TextEditingController fieldTextEditingController,
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return TextFormField(
              // 使用传入的 controller 或它自带的
              controller: controller ?? fieldTextEditingController,
              focusNode: fieldFocusNode,
              decoration: const InputDecoration(
                labelText: '关联单词 (Linked Word)',
                hintText: '搜索单词...',
                border: OutlineInputBorder(),
              ),
              // 添加一个校验器，确保用户最终选择了一个有效的单词
              // 注意：这里的校验逻辑可能需要根据你的具体需求调整
              validator: (value) {
                // 一个简单的校验：如果输入框有文字，但它不对应任何一个已知单词，则提示错误
                if (value != null && value.isNotEmpty) {
                  final isMatch = wordsProvider.words.any(
                    (w) => w.word.toLowerCase() == value.toLowerCase(),
                  );
                  if (!isMatch) {
                    return '请从列表中选择一个有效的单词';
                  }
                }
                return null; // 校验通过
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
