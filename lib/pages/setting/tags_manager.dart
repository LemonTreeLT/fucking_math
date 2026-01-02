import 'package:flutter/material.dart';
import 'package:flutter_color_picker_plus/flutter_color_picker_plus.dart';
import 'package:fucking_math/utils/providers/tags_proivder.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:fucking_math/widget/backgrounds.dart';
import 'package:fucking_math/widget/tag_badge.dart';
import 'package:provider/provider.dart';
import 'package:fucking_math/widget/ui_constants.dart';

class TagsManager extends StatefulWidget {
  const TagsManager({super.key});
  @override
  State<TagsManager> createState() => _TagsManagerState();
}

class _TagsManagerState extends State<TagsManager> {
  // 本地状态：当前选中的 Tag
  Tag? _selectedTag;
  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: _buildAppbar(), body: _buildMainScreen());

  AppBar _buildAppbar() => AppBar(title: Text("Tags Manager"));

  Widget _buildMainScreen() => Padding(
    padding: EdgeInsets.all(16),
    child: Row(
      children: [
        Expanded(
          child: Column(
            children: [
              // 传入回调函数
              Expanded(
                child: _TagsDisplayArea(
                  onTagSelect: (tag) => setState(() => _selectedTag = tag),
                ),
              ),
              boxH16,
              Expanded(flex: 2, child: _TagsAddingForm()),
            ],
          ),
        ),
        boxW16,
        // 传入当前选中的 Tag
        Expanded(child: _buildDetailedScreen()),
      ],
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
    // 关键：使用 ValueKey，当 id 变化时强制刷新右侧 Form 的状态
    return _TagsDetailedForm(
      key: ValueKey(_selectedTag!.id),
      tag: _selectedTag!,
    );
  }
}

// 详细与编辑
class _TagsDetailedFormState extends State<_TagsDetailedForm> {
  TagProvider get _provider => context.read();
  Tag get _tag => widget.tag;

  @override
  void initState() {
    super.initState();
    _nameDisplayController = TextEditingController(text: _tag.name);
    _descriptionDisplayController = TextEditingController(
      text: _tag.description,
    );
    _selectedSubject = _tag.subject;
    _selectedColor = _tag.color != null ? Color(_tag.color!) : null;
  }

  @override
  void dispose() {
    _nameDisplayController.dispose();
    _descriptionDisplayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BorderedContainerWithTopText(
    labelText: "详情与编辑",
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TagHeader(tag: _tag),
            const SizedBox(height: 24),
            _buildNameDisplay(),
            boxH16,
            _buildDescriptionDisplay(),
            boxH16,
            _buildSubjectSelector(),
            boxH16,
            _buildColorDisplay(),
            const Spacer(),
            _buildSubmitButton(),
          ],
        ),
      ),
    ),
  );

  // 构建名称展示区
  late TextEditingController _nameDisplayController;
  Widget _buildNameDisplay() =>
      _composeTextDisplayAndEditor(_nameDisplayController, "输入 Tag 名称", "名称");

  // 构建描述展示区
  late TextEditingController _descriptionDisplayController;
  Widget _buildDescriptionDisplay() =>
      _composeTextDisplayAndEditor(_descriptionDisplayController, "输入描述", "描述");

  // 构建学科下来菜单
  Subject? _selectedSubject;
  Widget _buildSubjectSelector() => _composeEnumDropdown(
    "学科",
    UniqueKey(),
    _tag.subject,
    Subject.values,
    (t) => setState(() => _selectedSubject = t),
  );

  // 构建取色板
  Color? _selectedColor;
  Widget _buildColorDisplay() => _composeColorPicker(
    context,
    (t) => setState(() => _selectedColor = t),
    _selectedColor ?? grey,
  );

  // 构建提交按钮
  Widget _buildSubmitButton() => ElevatedButton.icon(
    onPressed: () => _provider.changeTag(
      Tag(
        id: _tag.id,
        name: _nameDisplayController.text.trim(),
        description: _descriptionDisplayController.text.trim(),
        subject: _selectedSubject,
        color: _selectedColor?.toARGB32(),
      ),
    ),
    label: const Text("保 存"),
    icon: Icon(Icons.save),
  );
}

class _TagsDetailedForm extends StatefulWidget {
  const _TagsDetailedForm({required this.tag, required super.key});
  final Tag tag;

  @override
  State<StatefulWidget> createState() => _TagsDetailedFormState();
}

// 平铺展示 Tag
class _TagsDisplayArea extends StatelessWidget {
  const _TagsDisplayArea({required this.onTagSelect});

  final ValueChanged<Tag> onTagSelect;

  @override
  Widget build(BuildContext context) => BorderedContainerWithTopText(
    width: double.infinity,
    height: double.infinity,
    labelText: "标签展示",
    child: Padding(
      padding: EdgeInsets.all(16),
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

class TagHeader extends StatelessWidget {
  final Tag tag;
  const TagHeader({super.key, required this.tag});
  @override
  Widget build(BuildContext context) {
    // 颜色处理：如果 tag 没有颜色，使用灰色
    final tagColor = tag.color != null
        ? Color(tag.color!)
        : Colors.grey.shade800;
    // 关键组件：IntrinsicHeight
    // 它强制 Row 的高度等于其最高子元素的高度（这里是左侧的文本列）
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch, // 关键：让右侧子元素纵向拉伸以填满高度
        children: [
          // --- 左侧：主标题 + 副标题 ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center, // 文本垂直居中分布
              children: [
                // 主标题
                Text(
                  "# ${tag.name}",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4), // 间距
                // 副标题
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

          const SizedBox(width: 16), // 左右间距
          // --- 右侧：圆角方形 ---
          // AspectRatio 设为 1，保证它是个正方形
          // 由于外层 Row 是 stretch，它的高度已经被锁死为左侧文本的高度
          // 所以 AspectRatio 会根据高度自动计算宽度，形成正方形
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: tagColor,
                borderRadius: BorderRadius.circular(8), // 圆角
                boxShadow: [
                  BoxShadow(
                    color: tagColor.withAlpha(76),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              // 可以在里面放个 Icon 或者 tag 首字母，不需要可以留空
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

// 添加 Tag 组件
class _TagsAddingForm extends StatefulWidget {
  const _TagsAddingForm();

  @override
  State<StatefulWidget> createState() => _TagsAddingFormState();
}

class _TagsAddingFormState extends State<_TagsAddingForm> {
  TagProvider get _provider => context.read();

  @override
  Widget build(BuildContext context) => BorderedContainerWithTopText(
    labelText: "添加 Tag",
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildNameInputer(),
            boxH16,
            _buildDescriptionInputer(),
            boxH16,
            _buildSubjectSelector(),
            boxH16,
            _buildColorPicker(),
            const Spacer(),
            _buildAddingButton(),
          ],
        ),
      ),
    ),
  );

  // 表单内容辅助构建
  final _nameInputer = TextEditingController();
  Widget _buildNameInputer() => _composeTextInputer(_nameInputer, "Tag name");

  final _descriptionInputer = TextEditingController();
  Widget _buildDescriptionInputer() =>
      _composeTextInputer(_descriptionInputer, "Description");

  // 下拉菜单构建
  Subject? _selectedSubject;
  Key _addingSelectSubjectKey = UniqueKey();
  Widget _buildSubjectSelector() => _composeEnumDropdown(
    "选择学科",
    _addingSelectSubjectKey,
    null,
    Subject.values,
    (t) => _selectedSubject = t,
  );

  // 取色器构建
  Color _selectedColor = grey;
  Widget _buildColorPicker() => _composeColorPicker(
    context,
    (c) => setState(() => _selectedColor = c),
    _selectedColor,
  );

  // 提交按钮构建
  Widget _buildAddingButton() => ElevatedButton.icon(
    onPressed: _submit,
    label: const Text("添加标签"),
    icon: const Icon(Icons.add),
  );

  @override
  void dispose() {
    _nameInputer.dispose();
    _descriptionInputer.dispose();
    super.dispose();
  }

  void _submit() {
    _provider.saveTag(
      _nameInputer.text.trim(),
      description: _descriptionInputer.text.trim(),
      color: _selectedColor.toARGB32(),
      subject: _selectedSubject,
    );
    setState(() {
      _nameInputer.clear();
      _descriptionInputer.clear();
      _selectedColor = grey;
      _addingSelectSubjectKey = UniqueKey();
    });
    FocusScope.of(context).unfocus();
  }
}

// 辅助方法
Widget _composeTextInputer(TextEditingController controller, String text) =>
    TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: text, border: border),
    );

Widget _composeTextDisplayAndEditor(
  TextEditingController c,
  String source,
  String label,
) => TextFormField(
  decoration: InputDecoration(
    hintText: source,
    border: border,
    label: Text(label),
  ),
  controller: c,
);

Widget _composeEnumDropdown(
  String label,
  Key updateKey,
  Subject? initValue,
  List<Subject> items,
  Function(Subject?) onChanged,
) => DropdownButtonFormField<Subject?>(
  key: updateKey,
  initialValue: initValue,
  onChanged: onChanged,
  decoration: InputDecoration(labelText: label, border: border),
  items: [
    const DropdownMenuItem(value: null, child: Text("None")),
    ...items.map((e) => DropdownMenuItem(value: e, child: Text(e.name))),
  ],
);

Widget _composeColorPicker(
  BuildContext context,
  Function(Color c) updateColor,
  Color colorPreivew,
) => InkWell(
  onTap: () async => await _pickColor(context, updateColor, colorPreivew),
  child: Container(
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.grey),
    ),
    child: Row(
      children: [
        boxW16,
        const Text('点击编辑颜色'),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorPreivew,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    ),
  ),
);

Future<void> _pickColor(
  BuildContext context,
  Function(Color) onColorChanged,
  Color initialColor,
) async {
  Color pickedColor = initialColor;
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('选择颜色'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: pickedColor,
          onColorChanged: (color) => pickedColor = color,
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('确定'),
          onPressed: () {
            onColorChanged(pickedColor);
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}
