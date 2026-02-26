import 'package:flutter/material.dart';
import 'package:fucking_math/providers/knowledge.dart';
import 'package:fucking_math/providers/mistakes.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:fucking_math/widget/ui_constants.dart';
import 'package:provider/provider.dart';

class KnowledgeLinkButton extends StatefulWidget {
  const KnowledgeLinkButton({super.key, this.mistakeID});

  final int? mistakeID;

  @override
  State<StatefulWidget> createState() => _KnowledgeLinkButtonState();
}

class _KnowledgeLinkButtonState extends State<KnowledgeLinkButton> {
  int _linkedCount = 0;

  bool _isEnabled() => widget.mistakeID != null && widget.mistakeID! > 0;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: _isEnabled() ? _openKnowledgeLinkDialog : null,
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              _isEnabled() ? '点击以关联知识点' : '分配 ID 以开始关联知识点',
              style: TextStyle(
                color: _isEnabled() ? Colors.blue : Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
          const Spacer(),
          Text(
            '已关联 $_linkedCount 个知识点',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // TODO 在编辑完成之后需要调用_loaddata

  Future<void> _loadData() async {
    final fetchedKnowledgeCount = widget.mistakeID == null
        ? 0
        : (await context.read<MistakesProvider>().getMistakeKnowledge(
            widget.mistakeID!,
          ))?.length;

    setState(() => _linkedCount = fetchedKnowledgeCount ?? 0);
  }

  void _openKnowledgeLinkDialog() => showDialog(
    context: context,
    builder: (c) => _buildKnowledgeLinkDialog(c),
  );

  Widget _buildKnowledgeLinkDialog(BuildContext c) => Padding(
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
          child: KnowledgeLinkForm(mistakeID: widget.mistakeID!),
        ),
      ),
    ),
  );
}

class KnowledgeLinkForm extends StatefulWidget {
  const KnowledgeLinkForm({super.key, required this.mistakeID});

  final int mistakeID;

  @override
  State<StatefulWidget> createState() => KnowledgeLinkFormState();
}

class KnowledgeLinkFormState extends State<KnowledgeLinkForm> {
  late Set<int> _selectedKnowledgeIds;

  Set<int> get getSelectedKnowledgeIds => _selectedKnowledgeIds;

  @override
  void initState() {
    super.initState();
    _selectedKnowledgeIds = <int>{};

    Future.microtask(() {
      if (mounted) _loadInitialSelection();
    });
  }

  Future<void> _loadInitialSelection() async {
    final provider = context.read<MistakesProvider>();
    final knowledge = await provider.getMistakeKnowledge(widget.mistakeID);

    if (knowledge != null) {
      setState(
            () => _selectedKnowledgeIds = knowledge.map((k) => k.id).toSet(),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildTitle(),
      const SizedBox(height: 16),
      Expanded(child: _buildMainContent()),
      const SizedBox(height: 16),
      _buildActionButtons(),
    ],
  );

  Widget _buildTitle() => Text(
    '#${widget.mistakeID} 的相关知识点',
    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  );

  Widget _buildMainContent() => Row(
    children: [
      Expanded(flex: 2, child: _buildKnowledgeList()),
      const SizedBox(width: 16),
      Expanded(child: _buildSelectedList()),
    ],
  );

  Widget _buildKnowledgeList() => Consumer<KnowledgeProvider>(
    builder: (context, knowledgeProvider, _) {
      final filteredKnowledge = knowledgeProvider.getItems;

      return filteredKnowledge.isEmpty
          ? const Center(child: Text('没有相关知识点'))
          : ListView.builder(
              itemCount: filteredKnowledge.length,
              itemBuilder: (context, index) =>
                  _buildKnowledgeCheckboxTile(filteredKnowledge[index]),
            );
    },
  );

  Widget _buildKnowledgeCheckboxTile(Knowledge knowledge) => CheckboxListTile(
    value: _selectedKnowledgeIds.contains(knowledge.id),
    onChanged: (value) => _toggleKnowledge(knowledge.id, value ?? false),
    title: Text(knowledge.head),
    subtitle: Text(
      knowledge.body,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
  );

  void _toggleKnowledge(int knowledgeId, bool isSelected) => setState(
    () => isSelected
        ? _selectedKnowledgeIds.add(knowledgeId)
        : _selectedKnowledgeIds.remove(knowledgeId),
  );

  Widget _buildSelectedList() => Consumer<KnowledgeProvider>(
    builder: (context, knowledgeProvider, _) {
      final selected = knowledgeProvider.getItems
          .where((k) => _selectedKnowledgeIds.contains(k.id))
          .toList();

      return Container(
        decoration: BoxDecoration(border: Border.all(color: grey),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '      已选择',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: selected.length,
                itemBuilder: (context, index) =>
                    _buildSelectedChip(selected[index]),
              ),
            ),
          ],
        ),
      );
    },
  );

  Widget _buildSelectedChip(Knowledge knowledge) =>
      ListTile(
        title: Text(knowledge.head),
        trailing: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _toggleKnowledge(knowledge.id, false),
        ),
        dense: true, // 使布局更紧凑，高度接近 Chip
        visualDensity: VisualDensity.compact,
  );

  Widget _buildActionButtons() => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      ElevatedButton(onPressed: _exit, child: const Text('取消')),
      const SizedBox(width: 8),
      ElevatedButton(onPressed: _exit, child: const Text('确定')),
    ],
  );

  void _exit() => Navigator.of(context).pop();
}
