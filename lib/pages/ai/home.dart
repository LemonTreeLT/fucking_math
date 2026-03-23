import 'package:flutter/material.dart';
import 'package:fucking_math/widget/ai/ai_chat.dart';

class AiChatHome extends StatelessWidget {
  const AiChatHome({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Padding(padding: const EdgeInsets.all(16), child: AiChat()),
  );
}
