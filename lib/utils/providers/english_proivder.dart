import 'package:flutter/foundation.dart';
import 'package:fucking_math/db/app_database.dart' as db;
import 'package:fucking_math/db/app_dao.dart';
import 'package:fucking_math/utils/db/english_repository.dart';
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

  // --- 操作：添加单词 ---
  Future<void> addWord(
    String word, {
    String? definition,
    String? definitionPre,
    List<int>? tags,
    String? note,
  }) async {
    _error = null;
    try {
      await _repository.saveWord(
        word,
        definition: definition,
        definitionPreview: definitionPre,
        tags: tags,
        note: note
      );
      // 添加成功后刷新列表
      await loadWords();
    } catch (e) {
      _error = '添加单词失败: $e';
      notifyListeners();
      if (kDebugMode) print(_error);
    }
  }

  // --- 查询：加载所有单词 ---
  Future<void> loadWords() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _words = await _repository.getAllWords();
    } catch (e) {
      _error = '加载单词失败: $e';
      if (kDebugMode) print(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 删除单词
  Future<void> deleteWord(int wordID) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.deleteWord(wordID);
    } catch (e) {
      _error = '删除单词失败: $e';
      if (kDebugMode) print(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
