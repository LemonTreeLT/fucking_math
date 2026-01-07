import 'package:flutter/material.dart';
import 'package:fucking_math/utils/types.dart';

class KnowledgePageState extends ChangeNotifier {
  Knowledge? _selectedKnowledge;
  Knowledge? get selectedKnowledge => _selectedKnowledge;

  void _actionAndNotify(void Function() action) {
    action();
    notifyListeners();
  }

  void clearSelection() => _actionAndNotify(() => _selectedKnowledge == null);

  void setSelection(Knowledge know) =>
      _actionAndNotify(() => _selectedKnowledge = know);
}
