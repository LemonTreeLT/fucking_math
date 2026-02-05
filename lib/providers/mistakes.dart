import 'package:fucking_math/db/app_database.dart' show AppDatabase;
import 'package:fucking_math/db/daos/mistake.dart';
import 'package:fucking_math/extensions/list.dart';
import 'package:fucking_math/providers/base_db_proivder.dart';
import 'package:fucking_math/utils/repository/mistakes.dart';
import 'package:fucking_math/utils/types.dart';

class MistakesProvider
    extends BaseRepositoryProvider<Mistake, MistakesRepository> {
  MistakesProvider(AppDatabase db)
    : super(MistakesRepository(MistakesDao(db))) {
    loadMistakes();
  }

  Future<void> loadMistakes() async => justDoIt(
    action: () => rep.getAllMistakes(),
    onSucces: setItems,
    errMsg: "加载错题失败",
  );

  Future<Mistake?> createMistakes(
    Subject subject,
    String head,
    String body, {
    String? source,
    String? note,
    List<int> images = const [],
    List<int>? tags = const [],
  }) async => justDoItNext(
    action:() => rep.saveMistake(
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

  Future<Answer?> createAnswer(
    int mistakeId,
    String body, {
    int? id,
    String? head,
    String? note,
    String? source,
    List<int>? tags,
    List<int>? imageIds,
  }) async => justDoItNext(
    action: () => rep.saveAnswer(
      mistakeId: mistakeId,
      body: body,
      id: id,
      head: head,
      note: note,
      source: source,
      tags: tags,
      imageIds: imageIds,
    ),
    errMsg: "保存答案失败",
  );

  Future<List<Answer>?> getAnswerOfMistakes(int mistakeId) => justDoItNext(
    action: () => rep.getAnswersByMistakeId(mistakeId),
    errMsg: "查询 $mistakeId 号错题时发生错误",
  );
}
