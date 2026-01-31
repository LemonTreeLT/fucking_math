import 'package:fucking_math/db/daos/knowledge.dart';
import 'package:fucking_math/providers/base_db_proivder.dart';
import 'package:fucking_math/utils/db/knowledge_repository.dart';

import 'package:fucking_math/db/app_database.dart' show AppDatabase;
import 'package:fucking_math/extensions/list.dart';
import 'package:fucking_math/utils/types.dart';

class KnowledgeProvider
    extends BaseRepositoryProvider<Knowledge, KnowledgeRepository> {
  KnowledgeProvider(AppDatabase db)
    : super(KnowledgeRepository(KnowledgeDao(db)));

  // --- 查询：加载所有知识点 ---
  Future<void> loadKnowledge() async => justDoIt<List<Knowledge>>(
    action: () => rep.getAllKnowledge(),
    onSucces: setItems,
    errMsg: "加载知识点失败",
  );

  // --- 查询：根据学科加载知识点 ---
  Future<void> loadKnowledgeBySubject(Subject subject) async =>
      justDoIt<List<Knowledge>>(
        action: () => rep.getKnowledgeBySubject(subject),
        onSucces: setItems,
        errMsg: "加载学科知识点失败",
      );

  // --- 查询：搜索知识点 ---
  Future<void> searchKnowledge(String query) async => justDoIt<List<Knowledge>>(
    action: () => rep.searchKnowledge(query),
    onSucces: setItems,
    errMsg: "搜索知识点失败",
  );

  // --- 查询：根据标签获取知识点 ---
  Future<void> loadKnowledgeByTag(int tagId) async => justDoIt<List<Knowledge>>(
    action: () => rep.getKnowledgeByTag(tagId),
    onSucces: setItems,
    errMsg: "加载标签知识点失败",
  );

  // --- 操作：添加或更新知识点 ---
  Future<void> saveKnowledge(
    Subject subject,
    String head,
    String body, {
    List<int>? tags,
    String? note,
  }) async => justDoIt<Knowledge>(
    action: () =>
        rep.saveKnowledge(subject, head, body, tags: tags, note: note),
    onSucces: (savedKnowledge) => setItems(
      items.withUpsert(savedKnowledge, (k) => k.id == savedKnowledge.id),
    ),
    errMsg: "保存知识点失败",
  );

  // --- 操作：标记编辑 ---
  Future<void> markEdit(int knowledgeId, {String? note}) async =>
      justDoIt<void>(
        action: () => rep.markKnowledgeEdit(knowledgeId, note: note),
        errMsg: "标记编辑失败",
      );

  // --- 操作：标记重复 ---
  Future<void> markRetry(int knowledgeId, {String? note}) async =>
      justDoIt<void>(
        action: () => rep.markKnowledgeRetry(knowledgeId, note: note),
        errMsg: "标记重复失败",
      );

  // --- 操作：删除知识点 ---
  Future<void> deleteKnowledge(int knowledgeId) async => justDoIt<void>(
    action: () => rep.deleteKnowledge(knowledgeId),
    onSucces: (_) => setItems(items.where((k) => k.id != knowledgeId).toList()),
    errMsg: "删除知识点失败",
  );
}
