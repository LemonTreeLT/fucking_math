import 'package:fucking_math/extensions/list.dart';
import 'package:fucking_math/providers/base_db_provider.dart';
import 'package:fucking_math/utils/repository/questions.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:fuzzy/data/fuzzy_options.dart';

class QuestionsProvider
    extends BaseRepositoryProvider<Question, QuestionsRepository>
    with FuzzySearchMixin, SingleObjectSelectMixin<int> {
  QuestionsProvider(super.rep);

  @override
  List<WeightedKey<Question>> get fuzzyKeys => [
    WeightedKey(name: 'id', getter: (m) => m.id.toString(), weight: 1.2),
    WeightedKey(name: 'subject', getter: (m) => m.subject.name, weight: 0.5),
    WeightedKey(name: "head", getter: (m) => m.head, weight: 1.0),
    WeightedKey(name: "body", getter: (m) => m.body, weight: 1.0),
  ];

  Future<void> loadQuestions() async => justDoIt(
    action: () => rep.getAllQuestions(),
    onSuccess: setItems,
    errMsg: "加载题目失败",
  );

  Future<Question?> createQuestions(
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
    action: () => rep.saveQuestion(
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
    onSuccess: (save) =>
        setItems(items.withUpsert(save, (k) => k.id == save.id)),
    errMsg: "保存题目失败",
  );

  Future<Answer?> createAnswer(
    int questionId,
    String body, {
    int? id,
    String? head,
    String? note,
    String? source,
    List<int>? tags,
    List<int>? imageIds,
  }) async => justDoItNext(
    action: () => rep.saveAnswer(
      questionId: questionId,
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

  Future<List<Answer>?> getAnswerOfQuestions(int questionId) => justDoItNext(
    action: () => rep.getAnswersByQuestionId(questionId),
    errMsg: "查询 $questionId 号题目时发生错误",
  );

  Future<List<Knowledge>?> getQuestionKnowledge(int questionId) => justDoItNext(
    action: () => rep.getQuestionKnowledge(questionId),
    errMsg: "获取题目 $questionId 的知识点失败",
  );

  Future<int?> assignID() =>
      justDoItNext(action: rep.assignID, errMsg: "无法分配 ID");

  Future<void> removeQuestions(int id) => justDoItNext(
    action: () => rep.deleteQuestion(id),
    errMsg: "删除 $id 号题目失败",
    onSuccess: (_) => setItems(items.where((m) => m.id != id).toList()),
  );
}
