import 'package:flutter/material.dart';
import 'package:fucking_math/extensions/string.dart';
import 'package:fucking_math/providers/knowledge.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:fucking_math/widget/common/tag_selection.dart';
import 'package:fucking_math/widget/forms/base_form.dart';
import 'package:fucking_math/widget/forms/form_builders.dart';
import 'package:fucking_math/widget/ui_constants.dart';
import 'package:provider/provider.dart';

class AddKnowledge extends StatefulWidget {
  const AddKnowledge({super.key});
  @override
  State<AddKnowledge> createState() => _AddKnowledgeState();
}

class _AddKnowledgeState extends GenericFormStateV2<AddKnowledge> {
  final _headInputerController = TextEditingController();
  final _bodyInputerController = TextEditingController();
  final _noteInputerController = TextEditingController();
  final _tagKey = GlobalKey<TagSelectionAreaState>();

  Subject _selectedSuject = Subject.math;

  @override
  Widget content() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      tInputer(controller: _headInputerController, labelText: "概述"),
      boxH16,
      sInputer((t) => setState(() => _selectedSuject = t!)),
      boxH16,
      tInputer(
        controller: _bodyInputerController,
        labelText: "详细描述",
        maxLines: 3,
      ),
      boxH16,
      TagSelectionArea(key: _tagKey),
      boxH16,
      tInputer(controller: _noteInputerController, labelText: "提交描述"),
      const Spacer(),
      buildActionButton(),
    ],
  );

  Future<void> _saveKnowledge() async {
    context.read<KnowledgeProvider>().saveKnowledge(
      _selectedSuject,
      _headInputerController.text.trim(),
      _bodyInputerController.text.trim(),
      tags: _tagKey.currentState?.selectedTagIds.toList(),
      note: _noteInputerController.text.nullIfEmpty,
    );
  }

  // TODO: 实现接收provider状态动态更新列表
  Widget buildActionButton() => Row(
    children: [
      ElevatedButton.icon(
        onPressed: _saveKnowledge,
        label: Text("保存"),
        icon: Icon(Icons.save),
      ),
    ],
  );

  @override
  List<TextEditingController> get controllers => [
    _headInputerController,
    _bodyInputerController,
  ];

  @override
  String get formTitle => "编辑 / 添加";
}

final tInputer = FormBuilders.textField;
Widget sInputer(void Function(Subject?) onChanged) => FormBuilders.enumDropdown(
  label: '学科',
  items: Subject.values,
  onChanged: onChanged,
  initialValue: Subject.math,
  noneOption: false,
);
