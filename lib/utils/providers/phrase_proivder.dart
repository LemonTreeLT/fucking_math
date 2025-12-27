import 'package:flutter/foundation.dart';
import 'package:fucking_math/db/app_dao.dart';
import 'package:fucking_math/utils/db/phrase_repository.dart';
import 'package:fucking_math/db/app_database.dart' as db;
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
  Future<void> _justDoIt(
    Future<void> Function() action, {
    String? errMsg,
  }) async {
    _onLoading();
    _clearError();
    notifyListeners();

    try {
      await action();
    } catch (e) {
      _setError("${errMsg ?? "操作失败"}: $e");
    } finally {
      _stopLoading();
      notifyListeners();
    }
  }

  // 将全部短语加载到 Provider 中
  Future<void> loadPhrases() async =>
      _justDoIt(() async => _setPhrase(await _rep.getAllPhrases()));

  // 添加一个短语 | Warning: 调用后请手动调用加载方法
  Future<void> addPhrases(
    int linkedWordID,
    String phrase, {
    String? definition,
    String? note,
  }) async => _justDoIt(
    () async => await _rep.savePhrase(
      linkedWordID,
      phrase,
      definition: definition,
      note: note,
    ),
  );

  // 删除短语 | Warning: 调用后请手动调用加载方法
  Future<void> deletePhrase(int id, {bool reload = false}) async =>
      _justDoIt(() async => await _rep.deletePhrase(id));



}
