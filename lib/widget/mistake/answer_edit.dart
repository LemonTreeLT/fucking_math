import 'package:flutter/material.dart';
import 'package:fucking_math/extensions/string.dart';
import 'package:fucking_math/providers/images.dart';
import 'package:fucking_math/providers/mistakes.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:fucking_math/widget/common/images_picker.dart';
import 'package:fucking_math/widget/common/tag_badge.dart';
import 'package:fucking_math/widget/common/tag_selection.dart';
import 'package:fucking_math/widget/forms/base_form.dart';
import 'package:fucking_math/widget/forms/form_builders.dart';
import 'package:fucking_math/widget/ui_constants.dart';
import 'package:provider/provider.dart';

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
      children: [_buildHintText(), const Spacer(), _buildAnswerPreview()],
    ),
  );

  Widget _buildHintText() => Center(
    child: widget.mistakeID != null
        ? InkWell(
            onTap: _openAnswerEditingWindow,
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Text("点击以编辑答案", style: TextStyle(color: Colors.blue)),
            ),
          )
        : const Text("分配 ID 以开始编辑答案"),
  );

  void _openAnswerEditingWindow() {
    showDialog(context: context, builder: _buildAnswerPickWindow);
  }

  Widget _buildAnswerPickWindow(BuildContext c) => Padding(
    padding: const EdgeInsets.all(16),
    child: FractionallySizedBox(
      widthFactor: 0.6,
      child: Material(
        borderRadius: BorderRadius.circular(16),
        type: MaterialType.card,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 32,
            bottom: 32,
            right: 32,
          ),
          child: AnswerForm(mistakeID: widget.mistakeID!),
        ),
      ),
    ),
  ); // TODO: Warning: 该处 id = 10为占位符

  Widget _buildAnswerPreview() => dev;
}

/// answer弹出窗口内容
class AnswerForm extends StatefulWidget {
  const AnswerForm({super.key, required this.mistakeID});
  final int mistakeID;
  @override
  State<StatefulWidget> createState() => _AnswerFormState();
}

class _AnswerFormState extends GenericFormStateV3<AnswerForm> {
  @override
  Widget content() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("#${widget.mistakeID} 号错题的答案", style: TextStyle(fontSize: 32)),
      Expanded(
        child: Row(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //   const SizedBox(height: 8),
            Expanded(flex: 2, child: _buildTopArea()),
            Expanded(child: _buildAnswerList()),
          ],
        ),
      ),
    ],
  );

  Widget _buildTopArea() => Column(
    spacing: 8,
    children: [
      Expanded(child: _buildBodyInput()),
      _buildTitleInputer(),
      AnimatedSize(
        duration: Duration(milliseconds: 120),
        child: Visibility(
          visible: _detailsVisable,
          maintainAnimation: true,
          maintainState: true,
          child: Column(
            spacing: 8,
            children: [
              tInputer(controller: _sourceInputerController, labelText: "备注"),
              ImagesPicker(key: _imageKey, height: 60),
              TagSelectionArea(key: _tagsKey),
            ],
          ),
        ),
      ),
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            Expanded(flex: 3, child: _buildNoteInputer()),
            Expanded(child: _buildOtherButton()),
          ],
        ),
      ),

      _buildActionButton(),
    ],
  );

  // ============ LAYOUT CODES ABOVE ============

  final _bodyInputerController = TextEditingController();
  final _titleInputerController = TextEditingController();
  final _noteInputerController = TextEditingController();
  final _sourceInputerController = TextEditingController();
  final _imageKey = GlobalKey<ImagesPickerState>();
  final _tagsKey = GlobalKey<TagSelectionAreaState>();

  bool _detailsVisable = false;

  Widget _buildTitleInputer() =>
      tInputer(controller: _titleInputerController, labelText: "标题");

  Widget _buildOtherButton() => InkWell(
    onTap: () => setState(() => _detailsVisable = !_detailsVisable),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Center(child: Text("其他")),
    ),
  );

  Widget _buildNoteInputer() =>
      tInputer(controller: _noteInputerController, labelText: "备注");

  Widget _buildBodyInput() => tInputer(
    controller: _bodyInputerController,
    labelText: "内容",
    expands: true,
    maxLines: null,
    textAlignVertical: TextAlignVertical.top,
    noCenterLabel: true,
  );

  Widget _buildActionButton() => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    spacing: 8,
    children: [
      ElevatedButton.icon(
        onPressed: _clearForm,
        label: const Text("清空表单"),
        icon: Icon(Icons.clear_all),
      ),
      ElevatedButton.icon(
        onPressed: _addAnswer,
        label: const Text("添加答案"),
        icon: Icon(Icons.save),
      ),
    ],
  );

  void _clearForm() => dev;

  Future<void> _addAnswer() async {
    final MistakesProvider provider = context.read();
    final ImagesProvider imgProvider = context.read();

    final body = _bodyInputerController.text.trim();
    final head = _titleInputerController.text.nullIfEmpty;
    final note = _noteInputerController.text.nullIfEmpty;
    final source = _sourceInputerController.text.nullIfEmpty;
    final tags = _tagsKey.currentState?.selectedTagIds;
    final unsavedImages = _imageKey.currentState?.images;
    final imageIds = unsavedImages != null
        ? await imgProvider.uploadImages(unsavedImages)
        : null;

    provider.createAnswer(
      widget.mistakeID,
      body,
      head: head,
      note: note,
      source: source,
      tags: tags?.toList(),
      imageIds: imageIds,
    );

    setState(() => _loadData());
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) _loadData();
    });
  }

  Future<void> _loadData() async => answers =
      (await context.read<MistakesProvider>().getAnswerOfMistakes(
        widget.mistakeID,
      )) ??
      [];

  // TODO: 完整实现
  List<Answer> answers = [];
  Widget _buildAnswerList() => Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    child: ListView(
      children: (answers
          .map((a) => AnswerListItem(a.id, a.head ?? a.body, a.tags))
          .toList()),
    ),
  );

  @override
  List<TextEditingController> get controllers => [
    _bodyInputerController,
    _noteInputerController,
    _titleInputerController,
    _sourceInputerController,
  ];
}

class AnswerListItem extends StatelessWidget {
  const AnswerListItem(this.id, this.desc, this.tags, {super.key});

  final int id;
  final String desc;
  final List<Tag> tags;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Center(child: _buildIdDisplay()),
      Column(children: [_buildDescDisplay(), _buildTagsDisplay()]),
    ],
  );

  Widget _buildIdDisplay() => Text("# $id");

  Widget _buildDescDisplay() => Text(desc);

  Widget _buildTagsDisplay() =>
      Row(children: tags.map((t) => TagBadge(tag: t)).toList());
}

final tInputer = FormBuilders.textField;
