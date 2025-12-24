import 'package:flutter/material.dart';
import 'package:fucking_math/widget/backgrounds.dart';

class AddPhraseFrom extends StatefulWidget {
  const AddPhraseFrom({super.key});

  @override
  State<AddPhraseFrom> createState() => _AddPhraseFormState();
}

class _AddPhraseFormState extends State<AddPhraseFrom> {
  final _phraseInputController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BorderedContainerWithTopText(
      labelText: "Phrases (UNDONE)",
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 短语输入
              TextFormField(
                controller: _phraseInputController,
                decoration: const InputDecoration(
                  labelText: '短语 (Phrase)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return '输入不能为空';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // 定义输入

            ],
          ),
        ),
      ),
    );
  }
}
