import 'package:flutter/material.dart';
import 'package:fucking_math/widget/knowledge/add_knowledge.dart';
import 'package:fucking_math/widget/knowledge/knowledge_display.dart';

class KnowledgeEditor extends StatelessWidget {
  const KnowledgeEditor({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      spacing: 16,
      children: [
        Expanded(flex: 2, child: AddKnowledge()),
        Expanded(child: KnowledgeDisplay()),
      ],
    ),
  );
}
