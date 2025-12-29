import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class KnowledgeShell extends StatelessWidget {
  const KnowledgeShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Knowledge Learning"),
        actions: [
          Text('Go to:   '),
          _goToEditorPage(context),
          const SizedBox(width: 8),
          _goToLearningPage(context),
        ],
      ),
      body: child,
    );
  }
}

Widget _goToEditorPage(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      context.go('/knowledge/editor');
    },
    child: const Text("Editor"),
  );
}

Widget _goToLearningPage(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      context.go('/knowledge');
    },
    child: const Text("Learning"),
  );
}
