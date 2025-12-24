import 'package:drift/drift.dart';
import 'package:fucking_math/db/app_dao.dart';
import 'package:fucking_math/db/app_database.dart' as db;
import 'package:fucking_math/db/tables_english.dart';

class PhraseRepository {
  final PhrasesDao _dao;
  PhraseRepository(this._dao);

  // 添加或者更新一个短语
  Future<void> savePhrase(
    int linkedWordID,
    String phrase, {
    String? definition,
  }) async {
    final ephrase = await _dao.getPhrase(phrase);
    if (ephrase != null) return; // 已存在，跳过

    final phraseID = await _dao.createPhrase(db.PhrasesCompanion.insert(
      wordID: linkedWordID,
      phrase: phrase,
      definition: Value(definition),
    ));

    _dao.addPhraseLog(
      db.PhraseLogsCompanion.insert(
        phraseID: phraseID,
        type: LogType.repeat,
      ),
    );
    
  }
}
