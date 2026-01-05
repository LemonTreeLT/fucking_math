import 'package:fucking_math/db/app_database.dart' show AppDatabase;
import 'package:fucking_math/db/daos/word.dart';
import 'package:fucking_math/extensions/list.dart';
import 'package:fucking_math/providers/base_proivder.dart';
import 'package:fucking_math/utils/db/english_repository.dart';

import 'package:fucking_math/utils/types.dart';

class WordsProvider extends BaseRepositoryProvider<Word, WordsRepository> {
  WordsProvider(AppDatabase database)
    : super(WordsRepository(WordsDao(database)));

  // --- 操作：添加单词  ---
  Future<void> addWord(
    String word, {
    String? definition,
    String? definitionPre,
    List<int>? tags,
    String? note,
  }) async => justDoIt<Word>(
    action: () => rep.saveWord(
      word,
      definition: definition,
      definitionPreview: definitionPre,
      tags: tags,
      note: note,
    ),
    onSucces: (newWord) =>
        setItems(items.withUpsert(newWord, (t) => t.id == newWord.id)),
    errMsg: "添加单词失败",
  );

  // --- 查询：加载所有单词  ---
  Future<void> loadWords() async => justDoIt<List<Word>>(
    action: () => rep.getAllWords(),
    onSucces: setItems,
    errMsg: "加载单词失败",
  );

  // --- 操作：删除单词  ---
  Future<void> deleteWord(int wordID) async => justDoIt<void>(
    action: () => rep.deleteWord(wordID),
    onSucces: (_) =>
        setItems(items.where((wrod) => wrod.id != wordID).toList()),
    errMsg: "删除单词失败",
  );
}
