import 'package:flutter/material.dart';
import 'package:fucking_math/widget/ui_constants.dart';

class ShowAnswerButtonWithPreview extends StatefulWidget {
  const ShowAnswerButtonWithPreview({super.key, this.mistakeID});

  final int? mistakeID;

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
        _buildActionButton(),

        if (widget.mistakeID == null) const Text("Warning: 需要分配错题id"),
        const Spacer(),
        _buildAnswerPreview(),
      ],
    ),
  );

  Widget _buildActionButton() => InkWell(
    onTap: widget.mistakeID == null ? _openAnswerEditingWindow : null,
    child: const Padding(
      padding: EdgeInsets.all(4.0),
      child: Text("点击以编辑答案", style: TextStyle(color: Colors.blue)),
    ),
  );

  void _openAnswerEditingWindow() {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          Padding(padding: const EdgeInsets.all(16), child: dev),
    );
  }

  Widget _buildAnswerPreview() => dev;
}
