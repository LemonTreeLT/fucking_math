import 'package:flutter/material.dart';
import 'package:fucking_math/widget/question/add_question.dart';
import 'package:fucking_math/widget/question/questions_display.dart';

class QuestionsEditor extends StatelessWidget {
  const QuestionsEditor({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      spacing: 16,
      children: [
        Expanded(flex: 2, child: AddQuestion()),
        Expanded(child: QuestionsDisplay()),
      ],
    ),
  );
}
