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

  Future<void> loadPhrases() async {
    _onLoading();
    _clearError();
    notifyListeners();

    try {
      _setPhrase(await _rep.getAllPhrases());
    } catch(e){}}
}
