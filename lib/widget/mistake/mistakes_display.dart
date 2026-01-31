import 'package:flutter/material.dart';

class MistakesDisplay extends StatefulWidget {
  const MistakesDisplay({super.key});

  @override
  State<StatefulWidget> createState() => _MistakesDisplay();
}

class _MistakesDisplay extends State<MistakesDisplay> {
  @override
  Widget build(BuildContext context) =>
      Center(child: Text("Mistake selector: In deving"));
}
