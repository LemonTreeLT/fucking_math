import 'package:flutter/foundation.dart';
import 'package:fucking_math/db/app_dao.dart' show PhrasesDao;
import 'package:fucking_math/db/app_database.dart' as db show AppDatabase;
import 'package:fucking_math/utils/db/phrase_repository.dart';
import 'package:fucking_math/providers/utils.dart';
import 'package:fucking_math/utils/types.dart';

class PhraseProivder extends ChangeNotifier {
  PhraseProivder(db.AppDatabase db) : _rep = PhraseRepository(PhrasesDao(db));

  final PhraseRepository _rep;
  bool _isLoading = false;
  String? _error;
  List<Phrase> _phrases = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Phrase> get phrases => _phrases;

  void _onLoading() => _isLoading = true;
  void _stopLoading() => _isLoading = false;
  void _clearError() => _error = null;
  void _setError(String errMsg) => _error = errMsg;
  void _setPhrase(List<Phrase> phrases) => _phrases = phrases;

  // 没有后顾之忧的调用你的方法吧
  Future<void> _justDoIt<T>({
    required Future<T> Function() action,
    String? errMsg,
    void Function(T result)? onSuccess,
  }) => justDoIt<T>(
    action,
    errMsg: errMsg,
    onLoading: _onLoading,
    onStopLoading: _stopLoading,
    clearError: _clearError,
    setError: _setError,
    notifyListeners: notifyListeners,
    onSuccess: onSuccess,
  );

  // 将全部短语加载到 Provider 中
  Future<void> loadPhrases() async => _justDoIt(
    action: () async => await _rep.getAllPhrases(),
    onSuccess: (result) => _setPhrase(result),
  );

  // 添加一个短语
  Future<void> addPhrases(
    int linkedWordID,
    String phrase, {
    String? definition,
    String? note,
    List<int>? tags,
  }) async => _justDoIt(
    action: () async => await _rep.savePhrase(
      linkedWordID,
      phrase,
      definition: definition,
      note: note,
      tags: tags,
    ),
    onSuccess: (result) => _phrases.add(result),
  );

  // 删除短语
  Future<void> deletePhrase(int id) async => _justDoIt(
    action: () async => await _rep.deletePhrase(id),
    onSuccess: (result) => _phrases.removeWhere((p) => p.id == id),
  );
}
