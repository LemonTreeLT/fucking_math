import 'package:flutter/material.dart';
import 'package:fucking_math/providers/tags_proivder.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:fucking_math/widget/common/backgrounds.dart';
import 'package:fucking_math/widget/common/tag_badge.dart';
import 'package:fucking_math/widget/forms/form_builders.dart';
import 'package:provider/provider.dart';
import 'package:fucking_math/widget/ui_constants.dart';

class TagsManager extends StatefulWidget {
  const TagsManager({super.key});

  @override
  State<TagsManager> createState() => _TagsManagerState();
}

class _TagsManagerState extends State<TagsManager> {
  Tag? _selectedTag;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Tags Manager")),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: _TagsDisplayArea(
                    onTagSelect: (tag) => setState(() => _selectedTag = tag),
                  ),
                ),
                boxH16,
                const Expanded(flex: 2, child: _TagsAddingForm()),
              ],
            ),
          ),
          boxW16,
          Expanded(child: _buildDetailedScreen()),
        ],
      ),
    ),
  );

  Widget _buildDetailedScreen() {
    if (_selectedTag == null) {
      return BorderedContainerWithTopText(
        labelText: "详情与编辑",
        child: Center(
          child: Text("点击左侧标签查看详情", style: TextStyle(color: Colors.grey)),
        ),
      );
    }
    return _TagsDetailedForm(
      key: ValueKey(_selectedTag!.id),
      tag: _selectedTag!,
    );
  }
}

class _TagsDetailedForm extends StatefulWidget {
  const _TagsDetailedForm({required this.tag, required super.key});
  final Tag tag;

  @override
  State<StatefulWidget> createState() => _TagsDetailedFormState();
}

class _TagsDetailedFormState extends State<_TagsDetailedForm> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  Subject? _selectedSubject;
  Color? _selectedColor;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.tag.name);
    _descriptionController = TextEditingController(
      text: widget.tag.description,
    );
    _selectedSubject = widget.tag.subject;
    _selectedColor = widget.tag.color != null ? Color(widget.tag.color!) : null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BorderedContainerWithTopText(
    labelText: "详情与编辑",
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TagHeader(tag: widget.tag),
            const SizedBox(height: 24),
            FormBuilders.textField(
              controller: _nameController,
              labelText: '名称',
              hintText: '输入 Tag 名称',
            ),
            boxH16,
            FormBuilders.textField(
              controller: _descriptionController,
              labelText: '描述',
              hintText: '输入描述',
            ),
            boxH16,
            FormBuilders.enumDropdown<Subject>(
              key: UniqueKey(),
              label: '学科',
              items: Subject.values,
              initialValue: widget.tag.subject,
              onChanged: (t) => setState(() => _selectedSubject = t),
            ),
            boxH16,
            FormBuilders.colorPicker(
              context: context,
              currentColor: _selectedColor ?? grey,
              onColorChanged: (c) => setState(() => _selectedColor = c),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => context.read<TagProvider>().changeTag(
                Tag(
                  id: widget.tag.id,
                  name: _nameController.text.trim(),
                  description: _descriptionController.text.trim(),
                  subject: _selectedSubject,
                  color: _selectedColor?.toARGB32(),
                ),
              ),
              label: const Text("保 存"),
              icon: const Icon(Icons.save),
            ),
          ],
        ),
      ),
    ),
  );
}

class TagHeader extends StatelessWidget {
  final Tag tag;
  const TagHeader({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    final tagColor = tag.color != null
        ? Color(tag.color!)
        : Colors.grey.shade800;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "# ${tag.name}",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  tag.description?.isNotEmpty == true
                      ? tag.description!
                      : "暂无描述",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: tagColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: tagColor,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  tag.name.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TagsDisplayArea extends StatelessWidget {
  const _TagsDisplayArea({required this.onTagSelect});
  final ValueChanged<Tag> onTagSelect;

  @override
  Widget build(BuildContext context) => BorderedContainerWithTopText(
    width: double.infinity,
    height: double.infinity,
    labelText: "标签展示",
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          runSpacing: 8,
          spacing: 8,
          children: context
              .select((TagProvider p) => p.tags)
              .map(
                (t) => InkWell(
                  borderRadius: BorderRadius.circular(90),
                  onTap: () => onTagSelect(t),
                  child: TagBadge(tag: t),
                ),
              )
              .toList(),
        ),
      ),
    ),
  );
}

class _TagsAddingForm extends StatefulWidget {
  const _TagsAddingForm();

  @override
  State<StatefulWidget> createState() => _TagsAddingFormState();
}

class _TagsAddingFormState extends State<_TagsAddingForm> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  Subject? _selectedSubject;
  Color _selectedColor = grey;
  Key _subjectKey = UniqueKey();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    context.read<TagProvider>().saveTag(
      _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      color: _selectedColor.toARGB32(),
      subject: _selectedSubject,
    );

    setState(() {
      _nameController.clear();
      _descriptionController.clear();
      _selectedColor = grey;
      _subjectKey = UniqueKey();
    });

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) => BorderedContainerWithTopText(
    labelText: "添加 Tag",
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormBuilders.textField(
              controller: _nameController,
              labelText: 'Tag name',
            ),
            boxH16,
            FormBuilders.textField(
              controller: _descriptionController,
              labelText: 'Description',
            ),
            boxH16,
            FormBuilders.enumDropdown<Subject>(
              key: _subjectKey,
              label: '选择学科',
              items: Subject.values,
              initialValue: null,
              onChanged: (t) => _selectedSubject = t,
            ),
            boxH16,
            FormBuilders.colorPicker(
              context: context,
              currentColor: _selectedColor,
              onColorChanged: (c) => setState(() => _selectedColor = c),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: _submit,
              label: const Text("添加标签"),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    ),
  );
}
