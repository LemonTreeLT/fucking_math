import 'package:fucking_math/db/app_database.dart' show AppDatabase;
import 'package:fucking_math/db/daos/mistake.dart';
import 'package:fucking_math/extensions/list.dart';
import 'package:fucking_math/providers/base_db_proivder.dart';
import 'package:fucking_math/utils/db/mistakes_repository.dart';
import 'package:fucking_math/utils/types.dart';

class MistakesProvider
    extends BaseRepositoryProvider<Mistake, MistakesRepository> {
  MistakesProvider(AppDatabase db) : super(MistakesRepository(MistakesDao(db)));

  Future<void> loadMistakes() async => justDoIt(
    action: () => rep.getAllMistakes(),
    onSucces: setItems,
    errMsg: "加载错题失败",
  );

  Future<void> createMistakes(
    Subject subject,
    String head,
    String body, {
    String? source,
    String? note,
    List<int> images = const [],
    List<int> tags = const [],
  }) async => justDoIt(
    action: () => rep.saveMistake(
      subject: subject,
      head: head,
      body: body,
      source: source,
      tags: tags,
      imageIds: images,
      note: note,
    ),
    onSucces: (save) =>
        setItems(items.withUpsert(save, (k) => k.id == save.id)),
    errMsg: "保存错题失败",
  );
}
