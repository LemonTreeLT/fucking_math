import 'package:flutter/material.dart';
import 'package:fucking_math/providers/mistakes.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:fucking_math/widget/forms/base_form.dart';
import 'package:fucking_math/widget/ui_constants.dart';
import 'package:provider/provider.dart';
import 'package:fucking_math/extensions/provider_getter.dart';

class MistakesDisplay extends StatefulWidget {
  const MistakesDisplay({super.key});

  @override
  State<StatefulWidget> createState() => _MistakesDisplay();
}

class _MistakesDisplay extends GenericFormStateV2<MistakesDisplay> {
  @override
  Widget content() => Column(
    spacing: 16,
    children: [
      _buildSearchBar(),
      Expanded(child: _buildList()),
      _buildActionButton(),
    ],
  );

  Widget _buildList() => Consumer<MistakesProvider>(
    builder: (context, value, child) {
      final provider = context.misRead;

      return ListView(
        children: provider.filteredList
            .map(
              (m) => _MistakeListItem(
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
    onChanged: (value) => setState(() => context.misRead.search(value)),
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
      context.read<MistakesProvider>().search("");
    });
  }

  // TODO 实现删除错题逻辑
  void _delete() => dev;

  void _clearSelection() => context.read<MistakesProvider>().select(null);

  @override
  List<TextEditingController> get controllers => [];

  @override
  String get formTitle => "选择错题";
}

class _MistakeListItem extends StatelessWidget {
  final Mistake mistake;
  final void Function()? onTap;
  final bool selected;

  const _MistakeListItem(this.mistake, this.selected, this.onTap);
  @override
  Widget build(BuildContext context) => ListTile(
    title: Text("# ${mistake.id}"),
    subtitle: Text(mistake.head),
    trailing: SizedBox(
      width: 100,
      child: Text(mistake.body, overflow: TextOverflow.ellipsis, maxLines: 2),
    ),
    selected: selected,
    onTap: onTap,
    shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(16)),
  );
}
