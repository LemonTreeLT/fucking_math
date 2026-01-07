import 'package:flutter/material.dart';
import 'package:fucking_math/widget/forms/add_knowledge.dart';

class KnowledgeEditor extends StatelessWidget{
  const KnowledgeEditor({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Row(children: [Expanded(child: AddKnowledge())]),
  );
}