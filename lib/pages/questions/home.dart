import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuestionsHome extends StatelessWidget {
  const QuestionsHome({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("题库"),
      actions: [
        Text("Go to:    "),
        _goToEditorPage(context),
        const SizedBox(width: 8),
        _goToPracticePage(context),
      ],
    ),
    body: child,
  );
}

Widget _goToEditorPage(BuildContext context) => ElevatedButton(
  onPressed: () => context.go('/questions/editor'),
  child: const Text("Editor"),
);

Widget _goToPracticePage(BuildContext context) => ElevatedButton(
  onPressed: () => context.go('/questions'),
  child: const Text("Practice"),
);
