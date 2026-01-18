import 'package:flutter/material.dart';
import 'package:fucking_math/providers/knowledge_page_state.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:fucking_math/widget/knowledge/knowledge_list_item.dart';
import 'package:provider/provider.dart';

class KnowledgeListView extends StatelessWidget {
  /// 是否启用拖拽排序
  final bool enableReorder;
  
  /// 列表内边距
  final EdgeInsets? padding;
  const KnowledgeListView({
    super.key,
    this.enableReorder = true,
    this.padding,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<KnowledgePageState>(
      builder: (context, provider, child) {
        final knowledgeList = provider.knowledgeList;
        if (knowledgeList.isEmpty) {
          return _buildEmptyState(context);
        }
        // 根据是否启用排序选择不同的列表组件
        return enableReorder
            ? _buildReorderableList(context, provider, knowledgeList)
            : _buildNormalList(context, provider, knowledgeList);
      },
    );
  }
  /// 构建空状态提示
  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            '暂无数据',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
  /// 构建支持拖拽排序的列表
  Widget _buildReorderableList(
    BuildContext context,
    KnowledgePageState provider,
    List<Knowledge> knowledgeList,
  ) {
    return ReorderableListView.builder(
      padding: padding ?? const EdgeInsets.all(16),
      itemCount: knowledgeList.length,
      onReorder: provider.reorderList,
      proxyDecorator: _buildProxyDecorator,
      buildDefaultDragHandles: false, // 禁用默认拖拽手柄，整个项都可拖拽
      itemBuilder: (context, index) {
        final knowledge = knowledgeList[index];
        final isSelected = provider.isSelected(knowledge);
        return ReorderableDragStartListener(
          key: ValueKey(knowledge.id),
          index: index,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: KnowledgeListItem(
              knowledge: knowledge,
              isSelected: isSelected,
              onTap: () => provider.toggleSelection(knowledge),
            ),
          ),
        );
      },
    );
  }
  /// 构建普通列表（无拖拽功能，性能更优）
  Widget _buildNormalList(
    BuildContext context,
    KnowledgePageState provider,
    List<Knowledge> knowledgeList,
  ) {
    return ListView.builder(
      padding: padding ?? const EdgeInsets.all(16),
      itemCount: knowledgeList.length,
      itemBuilder: (context, index) {
        final knowledge = knowledgeList[index];
        final isSelected = provider.isSelected(knowledge);
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: KnowledgeListItem(
            knowledge: knowledge,
            isSelected: isSelected,
            onTap: () => provider.toggleSelection(knowledge),
          ),
        );
      },
    );
  }
  /// 拖拽时的代理装饰器（提供视觉反馈）
  Widget _buildProxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        
        return Material(
          elevation: 8 * animation.value, // 拖拽时提升阴影
          borderRadius: BorderRadius.circular(8),
          child: Opacity(
            opacity: 0.8 + (0.2 * (1 - animation.value)), // 拖拽时略微透明
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}