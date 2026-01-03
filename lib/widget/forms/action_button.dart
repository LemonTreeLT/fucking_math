import 'package:flutter/material.dart';

class FormActionButtons extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onSubmit;
  final VoidCallback onGenerate;
  final String submitLabel;
  final String generateLabel;

  const FormActionButtons({
    super.key,
    required this.isLoading,
    required this.onSubmit,
    required this.onGenerate,
    this.submitLabel = '提交',
    this.generateLabel = 'AI 生成',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.0,
      children: [
        ElevatedButton.icon(
          onPressed: isLoading ? null : onSubmit,
          icon: const Icon(Icons.add),
          label: Text(submitLabel),
        ),
        ElevatedButton.icon(
          onPressed: isLoading ? null : onGenerate,
          icon: const Icon(Icons.translate),
          label: Text(generateLabel),
        ),
      ],
    );
  }
}
