import 'package:flutter/material.dart';
import 'package:fucking_math/providers/questions.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:fucking_math/widget/forms/base_form.dart';
import 'package:provider/provider.dart';
import 'package:fucking_math/extensions/provider_getter.dart';

class QuestionsDisplay extends StatefulWidget {
  const QuestionsDisplay({super.key});

  @override
  State<StatefulWidget> createState() => _QuestionsDisplay();
}

class _QuestionsDisplay extends GenericFormStateV2<QuestionsDisplay> {
  @override
  Widget content() => Column(
    spacing: 16,
    children: [
      _buildSearchBar(),
      Expanded(child: _buildList()),
      _buildActionButton(),
    ],
  );
  Widget _buildList() => Consumer<QuestionsProvider>(
    builder: (context, value, child) {
      final provider = context.quesRead;

      return ListView(
        children: provider.filteredList
            .map(
              (m) => _QuestionListItem(
                m,
                provider.selectedItem == m.id,
                () => provider.select(m.id),
              ),
            )
            .toList(),
      );
    },
  );

  Widget _buildSearchBar() => TextFormField(
    decoration: InputDecoration(hint: const Text("搜索")),
    onChanged: (value) => setState(() => context.quesRead.search(value)),
  );

  Widget _buildActionButton() => Row(
    spacing: 16,
    children: [
      ElevatedButton.icon(
        onPressed: _delete,
        label: const Text("删除"),
        icon: Icon(Icons.delete),
      ),
      ElevatedButton.icon(
        onPressed: _clearSelection,
        label: const Text("清除选择"),
        icon: Icon(Icons.clear),
      ),
    ],
  );

  // ===================== UI CODE ABOVE =====================

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuestionsProvider>().search("");
    });
  }

  void _delete() {
    final provider = context.quesRead;
    final selection = provider.selectedItem;

    if (selection != null) provider.removeQuestions(selection);
  }

  void _clearSelection() => context.read<QuestionsProvider>().select(null);

  @override
  List<TextEditingController> get controllers => [];

  @override
  String get formTitle => "选择题目";
}

class _QuestionListItem extends StatelessWidget {
  final Question question;
  final void Function()? onTap;
  final bool selected;

  const _QuestionListItem(this.question, this.selected, this.onTap);

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.all(0),
    title: Text("# ${question.id}"),
    subtitle: Text(question.head),
    trailing: SizedBox(
      width: 100,
      child: Text(question.body, overflow: TextOverflow.ellipsis, maxLines: 2),
    ),
    selected: selected,
    onTap: onTap,
    shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(16)),
  );
}
