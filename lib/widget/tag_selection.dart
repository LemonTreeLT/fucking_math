import 'package:flutter/material.dart';
import 'package:fucking_math/utils/providers/tags_proivder.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:fucking_math/widget/tag_badge.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

/// 标签选择组件 - 可在多个表单中复用
class TagSelectionArea extends StatefulWidget {
  final Set<int> selectedTagIds;
  final ValueChanged<Set<int>> onSelectionChanged;

  const TagSelectionArea({
    super.key,
    required this.selectedTagIds,
    required this.onSelectionChanged,
  });

  @override
  State<TagSelectionArea> createState() => _TagSelectionAreaState();
}

class _TagSelectionAreaState extends State<TagSelectionArea> {
  final MenuController _menuController = MenuController();

  List<Tag> _getAvailableTags(List<Tag> allTags) {
    return allTags
        .where((tag) => !widget.selectedTagIds.contains(tag.id))
        .toList();
  }

  List<Tag> _getSelectedTags(List<Tag> allTags) {
    return allTags
        .where((tag) => widget.selectedTagIds.contains(tag.id))
        .toList();
  }

  void _toggleTag(int tagId) {
    final newSelection = Set<int>.from(widget.selectedTagIds);
    if (newSelection.contains(tagId)) {
      newSelection.remove(tagId);
    } else {
      newSelection.add(tagId);
    }
    widget.onSelectionChanged(newSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TagProvider>(
      builder: (context, tagProvider, child) {
        final selectedTags = _getSelectedTags(tagProvider.tags);
        final availableTags = _getAvailableTags(tagProvider.tags);

        return MenuAnchor(
          controller: _menuController,
          alignmentOffset: const Offset(0, 4),
          style: MenuStyle(
            elevation: const WidgetStatePropertyAll(8),
            backgroundColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.surface,
            ),
          ),
          menuChildren: [
            Container(
              constraints: const BoxConstraints(maxHeight: 240, maxWidth: 300),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...availableTags.map((tag) {
                      return TagBadge(
                        tag: tag,
                        onTap: () {
                          _toggleTag(tag.id);
                          _menuController.close();
                        },
                      );
                    }),
                    NewTagButton(
                      onCreateTag: (name) async {
                        await tagProvider.saveTag(name);
                        if (tagProvider.error == null) {
                          final newTag = tagProvider.tags.firstWhereOrNull(
                            (tag) => tag.name == name,
                          );
                          if (newTag != null) {
                            _toggleTag(newTag.id);
                          }
                        }
                        _menuController.close();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
          child: InkWell(
            onTap: () => _menuController.open(),
            child: Container(
              constraints: const BoxConstraints(minHeight: 48, maxHeight: 100),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: selectedTags.isEmpty
                  ? Row(
                      children: [
                        Icon(Icons.add, size: 16, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          '点击选择标签',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: selectedTags.map((tag) {
                          return GestureDetector(
                            onTap: () => _toggleTag(tag.id),
                            child: TagBadge(tag: tag),
                          );
                        }).toList(),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}

/// 新建标签按钮
class NewTagButton extends StatefulWidget {
  final ValueChanged<String> onCreateTag;

  const NewTagButton({super.key, required this.onCreateTag});

  @override
  State<NewTagButton> createState() => _NewTagButtonState();
}

class _NewTagButtonState extends State<NewTagButton> {
  bool _isCreating = false;
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    widget.onCreateTag(name);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isCreating) {
      return Container(
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          autofocus: true,
          decoration: InputDecoration(
            hintText: '输入标签名',
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          style: const TextStyle(fontSize: 12),
          onSubmitted: (_) => _submit(),
        ),
      );
    }

    return InkWell(
      onTap: () {
        setState(() => _isCreating = true);
        Future.delayed(
          const Duration(milliseconds: 50),
          () => _focusNode.requestFocus(),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.colorScheme.outline,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add,
              size: 14,
              color: theme.colorScheme.onSecondaryContainer,
            ),
            const SizedBox(width: 4),
            Text(
              '新建标签',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
