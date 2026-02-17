import 'package:fucking_math/db/app_database.dart' show AppDatabase;
import 'package:fucking_math/db/daos/mistake.dart';
import 'package:fucking_math/extensions/list.dart';
import 'package:fucking_math/providers/base_db_proivder.dart';
import 'package:fucking_math/utils/repository/mistakes.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:fuzzy/data/fuzzy_options.dart';

class MistakesProvider
    extends BaseRepositoryProvider<Mistake, MistakesRepository>
    with FuzzySearchMixin, SingleObjectSelectMixin<int> {
  MistakesProvider(AppDatabase db)
    : super(MistakesRepository(MistakesDao(db))) {
    loadMistakes();
  }

  @override
  List<WeightedKey<Mistake>> get fuzzyKeys => [
    WeightedKey(name: 'id', getter: (m) => m.id.toString(), weight: 1.2),
    WeightedKey(name: 'subject', getter: (m) => m.subject.name, weight: 0.5),
    WeightedKey(name: "head", getter: (m) => m.head, weight: 1.0),
    WeightedKey(name: "body", getter: (m) => m.body, weight: 1.0),
  ];

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
    List<int>? knowledgeIds,
    int? id,
  }) async => justDoItNext(
    action: () => rep.saveMistake(
      subject: subject,
      head: head,
      body: body,
      source: source,
      tags: tags,
      imageIds: images,
      knowledgeIds: knowledgeIds,
      note: note,
      id: id,
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

  Future<List<Knowledge>?> getMistakeKnowledge(int mistakeId) => justDoItNext(
    action: () => rep.getMistakeKnowledge(mistakeId),
    errMsg: "获取错题 $mistakeId 的知识点失败",
  );

  Future<int?> assignID() =>
      justDoItNext(action: rep.assignID, errMsg: "无法分配 ID");
}
