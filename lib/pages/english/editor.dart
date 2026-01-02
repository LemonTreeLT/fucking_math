import 'package:flutter/material.dart';
import 'package:fucking_math/widget/add_phrase.dart';
import 'package:fucking_math/widget/add_words.dart';

class EnglishEditor extends StatelessWidget {
  const EnglishEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        spacing: 20,
        children: const [
          Expanded(child: AddWordForm()),
          Expanded(child: AddPhraseFrom()),
        ],
      ),
    );
  }
}
