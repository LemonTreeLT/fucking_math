import 'package:flutter/material.dart';
import 'package:fucking_math/widget/ui_constants.dart';

class ShowAnswerButtonWithPreview extends StatefulWidget {
  const ShowAnswerButtonWithPreview({super.key});
  @override
  State<StatefulWidget> createState() => AnswerState();
}

class AnswerState extends State<ShowAnswerButtonWithPreview> {
  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      border: BoxBorder.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: _openAnswerEditingWindow,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: const Text("点击以编辑答案", style: TextStyle(color: Colors.blue)),
          ),
        ),
        const Text("Warning: 你需要分配错题id之后进行操作"),
        const Spacer(),
        _buildAnswerPreview(),
      ],
    ),
  );

  void _openAnswerEditingWindow() {}

  Widget _buildAnswerPreview() => dev;
}
