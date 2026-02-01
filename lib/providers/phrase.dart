import 'package:fucking_math/db/app_database.dart' show AppDatabase;
import 'package:fucking_math/db/daos/phrase.dart';
import 'package:fucking_math/extensions/list.dart';
import 'package:fucking_math/providers/base_db_proivder.dart';
import 'package:fucking_math/utils/repository/phrase.dart';
import 'package:fucking_math/utils/types.dart';

class PhraseProvider extends BaseRepositoryProvider<Phrase, PhraseRepository> {
  PhraseProvider(AppDatabase db) : super(PhraseRepository(PhrasesDao(db)));

  // 将全部短语加载到 Provider 中
  Future<void> loadPhrases() async => justDoIt(
    action: () async => await rep.getAllPhrases(),
    onSucces: (result) => setItems(result),
  );

  // 添加一个短语
  Future<void> addPhrases(
    int linkedWordID,
    String phrase, {
    String? definition,
    String? note,
    List<int>? tags,
  }) async => justDoIt(
    action: () async => await rep.savePhrase(
      linkedWordID,
      phrase,
      definition: definition,
      note: note,
      tags: tags,
    ),
    onSucces: (result) =>
        setItems(items.withUpsert(result, (t) => t.id == result.id)),
  );

  // 删除短语
  Future<void> deletePhrase(int id) async => justDoIt(
    action: () async => await rep.deletePhrase(id),
    onSucces: (result) => items.removeWhere((p) => p.id == id),
  );
}
