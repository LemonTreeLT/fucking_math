import 'package:flutter/material.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:fucking_math/widget/common/tag_badge.dart';

class KnowledgeListItem extends StatefulWidget {
  /// 要展示的 Knowledge 对象
  final Knowledge knowledge;

  /// 是否为选中状态
  final bool isSelected;

  /// 点击回调
  final VoidCallback onTap;
  const KnowledgeListItem({
    super.key,
    required this.knowledge,
    required this.isSelected,
    required this.onTap,
  });
  @override
  State<KnowledgeListItem> createState() => _KnowledgeListItemState();
}

class _KnowledgeListItemState extends State<KnowledgeListItem> {
  /// 是否处于 hover 状态（桌面端交互）
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Material(
        color: _getBackgroundColor(colorScheme),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 左侧内容：head + tags
                Expanded(child: _buildLeftContent(theme)),

                const SizedBox(width: 16),

                // 右侧内容：repeat 数字
                _buildRightContent(theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 根据状态计算背景色
  Color _getBackgroundColor(ColorScheme colorScheme) {
    if (widget.isSelected) {
      return colorScheme.primaryContainer;
    }
    if (_isHovering) {
      return colorScheme.surfaceContainerHighest.withAlpha(127);
    }
    return Colors.transparent;
  }

  /// 构建左侧内容（head + tags）
  Widget _buildLeftContent(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Head 标题（支持截断和悬停显示全文）
        _buildHeadText(theme),

        const SizedBox(height: 8),

        // Tags 标签组（支持溢出显示）
        _buildTagsRow(theme),
      ],
    );
  }

  /// 构建 Head 标题文本
  Widget _buildHeadText(ThemeData theme) {
    return Tooltip(
      message: widget.knowledge.head,
      waitDuration: const Duration(milliseconds: 500),
      child: Text(
        widget.knowledge.head,
        style: theme.textTheme.titleMedium?.copyWith(
          color: widget.isSelected
              ? theme.colorScheme.onPrimaryContainer
              : theme.colorScheme.onSurface,
        ),
        maxLines: 2, // 最多显示2行
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// 构建 Tags 标签行
  Widget _buildTagsRow(ThemeData theme) {
    if (widget.knowledge.tags.isEmpty) {
      return const SizedBox.shrink();
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        // 计算可见的 tag 数量
        final visibleTags = _calculateVisibleTags(constraints.maxWidth);
        final hasOverflow = visibleTags < widget.knowledge.tags.length;
        return Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            // 显示可见的 tags
            ...widget.knowledge.tags.map((t) => TagBadge(tag: t)),

            // 如果有溢出，显示 "+N" 按钮
            if (hasOverflow) _buildOverflowIndicator(visibleTags, theme),
          ],
        );
      },
    );
  }

  /// 计算在给定宽度下可以显示多少个 tag
  ///
  /// 注意：这是简化实现，假设每个 tag 平均宽度为 60px
  /// 实际项目中可能需要测量每个 tag 的实际宽度
  /// TODO: 重构计算tag
  int _calculateVisibleTags(double availableWidth) {
    const estimatedTagWidth = 60.0; // 预估的单个 tag 宽度
    const spacing = 6.0;
    const overflowIndicatorWidth = 40.0; // "+N" 按钮的宽度
    // 保守估计：为溢出指示器预留空间
    final effectiveWidth = availableWidth - overflowIndicatorWidth;
    final maxTags = (effectiveWidth / (estimatedTagWidth + spacing)).floor();
    return maxTags.clamp(1, widget.knowledge.tags.length);
  }

  /// 构建溢出指示器（"+N" 按钮，悬停显示所有 tags）
  Widget _buildOverflowIndicator(int visibleCount, ThemeData theme) {
    final hiddenCount = widget.knowledge.tags.length - visibleCount;

    return Tooltip(
      waitDuration: const Duration(milliseconds: 300),
      // 将所有隐藏的 tags 作为 rich 内容展示
      richMessage: WidgetSpan(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: widget.knowledge.tags
                .map((t) => TagBadge(tag: t))
                .toList(),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary.withAlpha(51),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.colorScheme.secondary.withAlpha(76),
            width: 1,
          ),
        ),
        child: Text(
          '+$hiddenCount',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.secondary,
            fontSize: 11,
          ),
        ),
      ),
    );
  }

  /// 构建右侧 Repeat 数字显示
  Widget _buildRightContent(ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${widget.knowledge.editCount}',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: widget.isSelected
                ? theme.colorScheme.onPrimaryContainer
                : theme.colorScheme.primary,
            fontSize: 36, // 调大字体但不使用粗体
            height: 1.0,
          ),
        ),
        Text(
          '次',
          style: theme.textTheme.bodySmall?.copyWith(
            color: widget.isSelected
                ? theme.colorScheme.onPrimaryContainer.withAlpha(178)
                : theme.colorScheme.onSurface.withAlpha(153),
          ),
        ),
      ],
    );
  }
}
