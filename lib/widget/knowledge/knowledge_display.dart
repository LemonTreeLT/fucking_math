import 'package:flutter/material.dart';
import 'package:fucking_math/providers/knowledge_page_state.dart';
import 'package:fucking_math/providers/knowledge_proivder.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:fucking_math/widget/common/background_container.dart';
import 'package:fucking_math/widget/forms/form_builders.dart';
import 'package:fucking_math/widget/knowledge/knowledge_list_view.dart';
import 'package:provider/provider.dart';

class KnowledgeDisplay extends StatefulWidget {
  const KnowledgeDisplay({super.key});
  @override
  State<StatefulWidget> createState() => _KnowledgeDisplayState();
}

class _KnowledgeDisplayState extends State<KnowledgeDisplay> {
  KnowledgeProvider get _provider => context.read();
  KnowledgePageState get _stateProvider => context.read();

  @override
  Widget build(BuildContext context) => GenericBackground(
    label: "选择知识点",
    padding: EdgeInsets.all(0),
    child: Column(
      children: [
        Expanded(child: KnowledgeListView(padding: EdgeInsets.symmetric(vertical: 8))),
        const Spacer(),
        _buildActionButton(),
      ],
    ),
  );

  void _updateFilterSubject(Subject? subject) {
    // TODO: 学科过滤功能
  }

  Widget _buildActionButton() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      spacing: 8,
      children: [
        _subjectFilter(),
        Row(
          spacing: 8,
          children: [
            FormBuilders.deleteObject(delete: _deleteKnowledge),
            ElevatedButton.icon(
              onPressed: _refreshList,
              label: Text("刷新"),
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
      ],
    ),
  );

  void _refreshList() => _stateProvider.setKnowledgeList(_provider.getItems);

  Future<void> _deleteKnowledge() async {} // TODO 实现删除逻辑

  Widget _subjectFilter() => FormBuilders.enumDropdown(
    label: "通过学科过滤",
    items: Subject.values,
    onChanged: _updateFilterSubject,
  );
}
