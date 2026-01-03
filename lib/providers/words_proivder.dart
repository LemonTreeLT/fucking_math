import 'package:flutter/foundation.dart';
import 'package:fucking_math/db/app_database.dart' as db;
import 'package:fucking_math/db/app_dao.dart';
import 'package:fucking_math/utils/db/english_repository.dart';

import 'package:fucking_math/providers/utils.dart'; 
import 'package:fucking_math/utils/types.dart';

class WordsProvider extends ChangeNotifier {
  final WordsRepository _repository;

  List<Word> _words = [];
  bool _isLoading = false;
  String? _error;

  List<Word> get words => _words;
  bool get isLoading => _isLoading;
  String? get error => _error;

  WordsProvider(db.AppDatabase database)
      : _repository = WordsRepository(WordsDao(database));

  // --- 状态管理的私有辅助方法 ---
  void _onLoading() => _isLoading = true;
  void _onStopLoading() => _isLoading = false;
  void _clearError() => _error = null;
  void _setError(String errMsg) => _error = errMsg;
  void _setWords(List<Word> words) => _words = words;

  // --- 粘合剂：将通用工具与当前 Provider 绑定 ---
  Future<void> _justDoIt<T>({
    required Future<T> Function() action,
    String? errMsg,
    void Function(T result)? onSuccess,
  }) =>
      justDoIt<T>(
        action,
        errMsg: errMsg,
        onLoading: _onLoading,
        onStopLoading: _onStopLoading,
        clearError: _clearError,
        setError: _setError,
        notifyListeners: notifyListeners,
        onSuccess: onSuccess,
      );

  // --- 操作：添加单词  ---
  Future<void> addWord(
    String word, {
    String? definition,
    String? definitionPre,
    List<int>? tags,
    String? note,
  }) async =>
      _justDoIt<Word>(
        action: () => _repository.saveWord(
          word,
          definition: definition,
          definitionPreview: definitionPre,
          tags: tags,
          note: note,
        ),
        onSuccess: (newWord) => _words.add(newWord),
        errMsg: "添加单词失败",
      );

  // --- 查询：加载所有单词  ---
  Future<void> loadWords() async => _justDoIt<List<Word>>(
        action: () => _repository.getAllWords(),
        onSuccess: _setWords,
        errMsg: "加载单词失败",
      );

  // --- 操作：删除单词  ---
  Future<void> deleteWord(int wordID) async => _justDoIt<void>(
        action: () => _repository.deleteWord(wordID),
        onSuccess: (_) => _words.removeWhere((word) => word.id == wordID),
        errMsg: "删除单词失败",
      );
}
