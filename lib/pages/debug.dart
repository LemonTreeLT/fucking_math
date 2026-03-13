// ignore_for_file: unused_element

/*

This file includes draft codes, rubbish, horrible logics and so on

*/

import 'package:flutter/material.dart';
import 'package:fucking_math/ai/tools/orchestrator/knowledge_sub_handler.dart';
import 'package:fucking_math/ai/tools/orchestrator/master_orchestrator_tool.dart';
import 'package:fucking_math/ai/tools/orchestrator/mistakes_sub_handler.dart';
import 'package:fucking_math/ai/tools/orchestrator/phrase_sub_handler.dart';
import 'package:fucking_math/ai/tools/orchestrator/tag_sub_handler.dart';
import 'package:fucking_math/ai/tools/orchestrator/word_sub_handler.dart';
import 'package:fucking_math/widget/ai/ai_chat.dart';
import 'package:get_it/get_it.dart';

class Debug extends StatelessWidget {
  const Debug({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("Debug 页面"),
      actions: [
        Row(
          children: [
            const Text("Warning: 任何按钮都可能导致毁灭性的数据丢失"),
            TextButton(
              onPressed: () {
                final a = MasterOrchestratorTool([
                  PhraseSubHandler(GetIt.I.call()),
                  MistakesSubHandler(GetIt.I.call()),
                  KnowledgeSubHandler(GetIt.I.call()),
                  WordSubHandler(GetIt.I.call()),
                  TagSubHandler(GetIt.I.call()),
                ]);
                debugPrint(a.toJsonDefinition().toString());
              },
              child: const Text("Debug 1"),
            ),
          ],
        ),
      ],
    ),
    body: const Padding(padding: EdgeInsets.all(16), child: AiChat()),
  );
}
