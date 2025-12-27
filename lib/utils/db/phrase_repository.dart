import 'package:drift/drift.dart';
import 'package:fucking_math/db/app_dao.dart';
import 'package:fucking_math/db/app_database.dart' as db;
import 'package:fucking_math/db/tables_english.dart';
import 'package:fucking_math/utils/types.dart';

class PhraseRepository {
  final PhrasesDao _dao;
  PhraseRepository(this._dao);

  // 添加或者更新一个短语
  Future<void> savePhrase(
    int linkedWordID,
    String phrase, {
    String? definition,
    String? note,
    List<int>? tags,
  }) async {
    final ephrase = await _dao.getPhrase(phrase);
    if (ephrase != null) {
      // 已存在，更新
      await _dao.updatePhrase(
        ephrase.copyWith(wordID: linkedWordID, definition: Value(definition)),
      );

      _dao.addPhraseLog(
        db.PhraseLogsCompanion.insert(
          phraseID: ephrase.id,
          type: LogType.repeat,
          notes: Value(note),
        ),
      );

      return;
    }

    final phraseID = await _dao.createPhrase(
      db.PhrasesCompanion.insert(
        wordID: linkedWordID,
        phrase: phrase,
        definition: Value(definition),
      ),
    );

    _dao.addPhraseLog(
      db.PhraseLogsCompanion.insert(
        phraseID: phraseID,
        type: LogType.repeat,
        notes: Value(note),
      ),
    );
  }

  // 一次性获取全部短语
  Future<List<Phrase>> getAllPhrases() async {
    final result = (await _dao.getAllPhrases())
        .map(
          (pharse) async => (
            phrase: pharse.phrase,
            id: pharse.id,
            linkedWordID: pharse.wordID,
            definition: pharse.definition,
            tags: (await _dao.getPhraseTags(pharse.id))
                .map(
                  (tag) => (
                    name: tag.tag,
                    id: tag.id,
                    description: tag.description,
                    color: tag.color,
                    subject: tag.subject,
                  ),
                )
                .toList(),
          ),
        )
        .toList();

    return Future.wait(result);
  }

  // 删除短语
  Future<void> deletePhrase(int id) async => await _dao.deletePhrase(id);
}
