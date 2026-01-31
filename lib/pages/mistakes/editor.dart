import 'package:flutter/material.dart';
import 'package:fucking_math/widget/mistake/add_mistake.dart';
import 'package:fucking_math/widget/mistake/mistakes_display.dart';

class MistakesEditor extends StatelessWidget {
  const MistakesEditor({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      spacing: 16,
      children: [
        Expanded(flex: 2, child: AddMistake()),
        Expanded(child: MistakesDisplay()),
      ],
    ),
  );
}
