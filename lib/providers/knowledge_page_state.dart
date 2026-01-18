import 'package:flutter/material.dart';
import 'package:fucking_math/utils/types.dart';

class KnowledgePageState extends ChangeNotifier {
/// 当前选中的 Knowledge（null 表示未选中）
  Knowledge? _selectedKnowledge;
  
  /// Knowledge 列表（维护顺序，支持拖拽排序）
  List<Knowledge> _knowledgeList;
  KnowledgePageState({
    List<Knowledge>? initialList,
  }) : _knowledgeList = initialList ?? [];
  // ==================== Getters ====================
  
  Knowledge? get selectedKnowledge => _selectedKnowledge;
  
  List<Knowledge> get knowledgeList => List.unmodifiable(_knowledgeList);
  
  bool isSelected(Knowledge knowledge) => _selectedKnowledge?.id == knowledge.id;
  // ==================== 选中操作 ====================
  
  /// 选中指定的 Knowledge
  void selectKnowledge(Knowledge knowledge) {
    if (_selectedKnowledge?.id != knowledge.id) {
      _selectedKnowledge = knowledge;
      notifyListeners();
    }
  }
  /// 取消选中
  void clearSelection() {
    if (_selectedKnowledge != null) {
      _selectedKnowledge = null;
      notifyListeners();
    }
  }
  /// 切换选中状态（如果已选中则取消，否则选中）
  void toggleSelection(Knowledge knowledge) {
    if (isSelected(knowledge)) {
      clearSelection();
    } else {
      selectKnowledge(knowledge);
    }
  }
  // ==================== 列表操作 ====================
  
  /// 更新列表顺序（用于拖拽排序）
  void reorderList(int oldIndex, int newIndex) {
    // 处理 Flutter ReorderableList 的 newIndex 逻辑
    // 当向下拖拽时，newIndex 需要减1
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    
    final item = _knowledgeList.removeAt(oldIndex);
    _knowledgeList.insert(newIndex, item);
    notifyListeners();
  }
  /// 设置新的列表（完全替换）
  void setKnowledgeList(List<Knowledge> newList) {
    _knowledgeList = newList;
    
    // 如果当前选中的项不在新列表中，清除选中状态
    if (_selectedKnowledge != null &&
        !newList.any((k) => k.id == _selectedKnowledge!.id)) {
      _selectedKnowledge = null;
    }
    
    notifyListeners();
  }
}
