import 'package:flutter/material.dart';
import 'package:fucking_math/providers/images.dart';
import 'package:fucking_math/providers/mistakes.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:fucking_math/widget/common/images_picker.dart';
import 'package:fucking_math/widget/common/tag_selection.dart';
import 'package:fucking_math/widget/forms/base_form.dart';
import 'package:fucking_math/widget/forms/form_builders.dart';
import 'package:provider/provider.dart';

class AddMistake extends StatefulWidget {
  const AddMistake({super.key});

  @override
  State<StatefulWidget> createState() => _AddMistakeState();
}

class _AddMistakeState extends GenericFormState<AddMistake> {
  final _titleInputerController = TextEditingController();
  final _bodyInputerController = TextEditingController();
  final _sourceInputerController = TextEditingController();
  final _noteInputerController = TextEditingController();
  final _imagesInputerKey = GlobalKey<ImagesPickerState>();

  Subject _selectedSubject = Subject.math;
  Set<int> _selectedTags = {};

  @override
  List<Widget> buildFormFields(BuildContext context) => [
    tInputer(controller: _titleInputerController, labelText: "标题"),
    TagSelectionArea(
      selectedTagIds: _selectedTags,
      onSelectionChanged: (tags) => setState(() => _selectedTags = tags),
    ),
    tInputer(controller: _bodyInputerController, labelText: "题干", maxLines: 3),

    Row(
      spacing: spacing,
      children: [
        Expanded(child: _buildRightInputArea()),
        Expanded(child: _buildAnswerEditingArea()),
      ],
    ),
  ];

  Widget _buildAnswerEditingArea() => Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white, width: 1),
    ),
    child: Text("deving"),
  );

  Widget _buildRightInputArea() => Column(
    spacing: spacing,
    children: [
      sInputer((s) => setState(() => _selectedSubject = s!)),
      tInputer(controller: _sourceInputerController, labelText: "来源"),
      _buildImageUplaoder(),
    ],
  );

  Widget _buildImageUplaoder() => ImagesPicker(key: _imagesInputerKey,);

  // TODO: 提交按钮 & 编辑模式切换
  @override
  Widget buildActionButton() => ElevatedButton.icon(
    onPressed: _submit,
    label: const Text("保存"),
    icon: const Icon(Icons.save),
  );

  Future<void> _submit() async {
    final subject = _selectedSubject;
    final head = _titleInputerController.text.trim();
    final body = _bodyInputerController.text.trim();
    final source = _sourceInputerController.text.trim();
    final note = _noteInputerController.text.trim();
    final images = _imagesInputerKey.currentState?.images;
    final tags = _selectedTags;

    final MistakesProvider misProvider = context.read();
    final ImagesProvider imgProvider = context.read();

    List<int> imageIDs =[];
    if (images != null) imageIDs = (await imgProvider.uploadImages(images))??[];

    await misProvider.createMistakes(
      subject,
      head,
      body,
      source: source,
      note: note,
      images: imageIDs,
      tags: tags.toList(),
    );
  }

  @override
  List<TextEditingController> get controllers => [
    _bodyInputerController,
    _titleInputerController,
    _sourceInputerController,
    _noteInputerController,
  ];

  @override
  String get formTitle => "添加错题";

  @override
  double get spacing => 16;
}

final tInputer = FormBuilders.textField;
Widget sInputer(void Function(Subject?) onChanged) => FormBuilders.enumDropdown(
  label: '学科',
  items: Subject.values,
  onChanged: onChanged,
  initialValue: Subject.math,
  noneOption: false,
);
