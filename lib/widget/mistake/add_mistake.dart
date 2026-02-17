import 'package:flutter/material.dart';
import 'package:fucking_math/providers/images.dart';
import 'package:fucking_math/providers/mistakes.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:fucking_math/widget/common/images_picker.dart';
import 'package:fucking_math/widget/common/tag_selection.dart';
import 'package:fucking_math/widget/forms/base_form.dart';
import 'package:fucking_math/widget/forms/form_builders.dart';
import 'package:fucking_math/widget/mistake/answer_edit.dart';
import 'package:fucking_math/widget/mistake/link_knowledge.dart';
import 'package:provider/provider.dart';

class AddMistake extends StatefulWidget {
  const AddMistake({super.key});

  @override
  State<StatefulWidget> createState() => _AddMistakeState();
}

class _AddMistakeState extends GenericFormStateV2<AddMistake> {
  final _titleInputerController = TextEditingController();
  final _bodyInputerController = TextEditingController();
  final _sourceInputerController = TextEditingController();
  final _noteInputerController = TextEditingController();
  final _imagesInputerKey = GlobalKey<ImagesPickerState>();
  final _tagKey = GlobalKey<TagSelectionAreaState>();
  final _knowledgeKey = GlobalKey<KnowledgeLinkFormState>();

  Subject _selectedSubject = Subject.math;

  final double spacing = 10;
  int? _mistakeId;

  String? _validateNotNull(String? value, String desc) =>
      value == null || value.trim().isEmpty ? '$desc 不能为空' : null;

  @override
  Widget content() => Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    spacing: spacing,
    children: [
      _buildTopArea(),

      Expanded(
        child: Column(
          children: [
            const SizedBox(height: 10),
            IntrinsicHeight(child: _buildBottomLayout()),
          ],
        ),
      ),

      _buildActionButton(),
    ],
  );

  Widget _buildBottomLayout() => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // 区域3 - 左侧（占2/3）
      Expanded(flex: 2, child: _buildRightInputArea()),
      const SizedBox(width: 10),
      // 区域4 - 右侧（占1/3）
      Expanded(
        flex: 1,
        child: Column(
          spacing: 8,
          children: [
            Expanded(child: ShowAnswerButtonWithPreview(mistakeID: _mistakeId)),
            Expanded(
              child: KnowledgeLinkButton(
                key: _knowledgeKey,
                mistakeID: _mistakeId,
              ),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _buildTopArea() => Column(
    spacing: spacing,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildTitle(),

      Row(children: [Expanded(child: TagSelectionArea())]),
      tInputer(
        controller: _bodyInputerController,
        labelText: "题干",
        maxLines: 3,
        validator: (v) => _validateNotNull(v, "题干"),
      ),
    ],
  );

  Widget _buildTitle() => Row(
    spacing: 16,
    children: [
      Text(
        "# ${_mistakeId ?? "未分配 ID"}",
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      ),
      Expanded(
        child: Center(
          child: TextFormField(
            controller: _titleInputerController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "输入标题",
            ),
            validator: (value) => _validateNotNull(value, "标题"),
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    ],
  );

  Widget _buildRightInputArea() => Column(
    spacing: spacing,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sInputer((s) => setState(() => _selectedSubject = s!)),
      ImagesPicker(key: _imagesInputerKey, height: 60),
      tInputer(controller: _sourceInputerController, labelText: "来源"),
    ],
  );

  Widget _buildActionButton() => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    spacing: spacing / 2,
    children: [
      ElevatedButton.icon(
        onPressed: _submit,
        label: const Text("保存"),
        icon: const Icon(Icons.save),
      ),
      ElevatedButton.icon(
        onPressed: _mistakeId == null ? _assignID : _showAssignedAlert,
        label: const Text("分配 ID"),
        icon: Icon(Icons.assignment),
      ),
      ElevatedButton.icon(
        onPressed: _clearForm,
        label: const Text("清空表单"),
        icon: Icon(Icons.clear_all),
      ),
    ],
  );

  // TODO: 实现清空表单
  void _clearForm() => _setForm();

  /// 设置表单内容
  void _setForm({
    int? id,
    String? head,
    String? body,
    Set<int>? tags,
    List<GenFile>? images,
    String? source,
    Subject subject = Subject.math,
  }) => setState(() {
    _titleInputerController.text = head ?? "";
    _bodyInputerController.text = body ?? "";
    _tagKey.currentState?.selectedTagIds = tags ?? {};
    _selectedSubject = subject;
    _imagesInputerKey.currentState?.images = images ?? [];
    _sourceInputerController.text = source ?? "";
    _mistakeId = id;
  });

  Future<void> _assignID() async {
    final provider = context.read<MistakesProvider>();
    final newMistake = await provider.assignID();
    setState(() => _mistakeId = newMistake);
  }

  void _showAssignedAlert() => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: const Text("ID 已经分配"),
      duration: const Duration(seconds: 1),
    ),
  );

  Future<void> _submit() async {
    if (!formKey.currentState!.validate()) return;
    final subject = _selectedSubject;
    final head = _titleInputerController.text.trim();
    final body = _bodyInputerController.text.trim();
    final source = _sourceInputerController.text.trim();
    final note = _noteInputerController.text.trim();
    final images = _imagesInputerKey.currentState?.images;
    final tags = _tagKey.currentState?.selectedTagIds;
    final knowledgeIds = _knowledgeKey.currentState?.getSelectedKnowledgeIds
        .toList();

    final MistakesProvider misProvider = context.read();
    final ImagesProvider imgProvider = context.read();

    List<int> imageIDs = [];
    if (images != null) {
      imageIDs = (await imgProvider.uploadImages(images)) ?? [];
    }

    final newID = (await misProvider.createMistakes(
      subject,
      head,
      body,
      source: source,
      note: note,
      images: imageIDs,
      tags: tags?.toList(),
      knowledgeIds: knowledgeIds,
      id: _mistakeId,
    ))?.id;

    setState(() => _mistakeId = newID);
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
}

final tInputer = FormBuilders.textField;
Widget sInputer(void Function(Subject?) onChanged) => FormBuilders.enumDropdown(
  label: '学科',
  items: Subject.values,
  onChanged: onChanged,
  initialValue: Subject.math,
  noneOption: false,
);
