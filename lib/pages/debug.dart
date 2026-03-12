// ignore_for_file: unused_element

/*

This file includes draft codes, rubbish, horrible logics and so on

*/

import 'package:flutter/material.dart';
import 'package:fucking_math/widget/ai/ai_chat.dart';

class Debug extends StatelessWidget {
  const Debug({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("Debug 页面"),
      actions: [const Text("Warning: 任何按钮都可能导致毁灭性的数据丢失")],
    ),
    body: const Padding(
      padding: EdgeInsets.all(16),
      child: AiChat(),
    ),
  );
}
