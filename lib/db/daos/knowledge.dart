import 'package:drift/drift.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:fucking_math/db/tables/tables_knowledge.dart';
import 'package:fucking_math/db/tables/tables_tags.dart';
import 'package:fucking_math/utils/types.dart' show Subject;

part 'knowledge.g.dart';

@DriftAccessor(tables: [Knowledge, KnowledgeLogs, KnowledgeTagLink, Tags])
class KnowledgeDao extends DatabaseAccessor<AppDatabase>
    with _$KnowledgeDaoMixin {
  KnowledgeDao(super.db);

  // 创建知识点
  Future<int> createKnowledge(KnowledgeCompanion entry) =>
      into(knowledge).insert(entry);

  // 获取所有知识点
  Future<List<KnowledgeData>> getAllKnowledge() => select(knowledge).get();

  // 根据学科获取知识点
  Future<List<KnowledgeData>> getKnowledgeBySubject(Subject subject) {
    return (select(
      knowledge,
    )..where((k) => k.subject.equalsValue(subject))).get();
  }

  // 根据ID获取知识点
  Future<KnowledgeData?> getKnowledgeById(int id) {
    return (select(knowledge)..where((k) => k.id.equals(id))).getSingleOrNull();
  }

  // 搜索知识点(根据标题和内容)
  Future<List<KnowledgeData>> searchKnowledge(String query) {
    return (select(
      knowledge,
    )..where((k) => k.head.like('%$query%') | k.body.like('%$query%'))).get();
  }

  // 更新知识点
  Future<bool> updateKnowledge(KnowledgeData newKnowledge) =>
      update(knowledge).replace(newKnowledge);

  // 删除知识点
  Future<int> deleteKnowledge(int id) {
    return (delete(knowledge)..where((k) => k.id.equals(id))).go();
  }

  // 添加知识点日志
  Future<int> addKnowledgeLog(KnowledgeLogsCompanion entry) =>
      into(knowledgeLogs).insert(entry);

  // 获取知识点的所有日志
  Future<List<KnowledgeLog>> getKnowledgeLogs(int knowledgeId) {
    return (select(
      knowledgeLogs,
    )..where((l) => l.knowledgeID.equals(knowledgeId))).get();
  }

  // 为知识点添加标签
  Future<int> addTagToKnowledge(int knowledgeId, int tagId) {
    return into(knowledgeTagLink).insert(
      KnowledgeTagLinkCompanion(
        knowledgeID: Value(knowledgeId),
        tagID: Value(tagId),
      ),
    );
  }

  // 移除知识点的标签
  Future<int> removeTagFromKnowledge(int knowledgeId, int tagId) {
    return (delete(knowledgeTagLink)..where(
          (link) =>
              link.knowledgeID.equals(knowledgeId) & link.tagID.equals(tagId),
        ))
        .go();
  }

  // 获取知识点的所有标签
  Future<List<Tag>> getKnowledgeTags(int knowledgeId) {
    final query = select(tags).join([
      innerJoin(knowledgeTagLink, knowledgeTagLink.tagID.equalsExp(tags.id)),
    ])..where(knowledgeTagLink.knowledgeID.equals(knowledgeId));

    return query.map((row) => row.readTable(tags)).get();
  }

  // 获取带有特定标签的所有知识点
  Future<List<KnowledgeData>> getKnowledgeByTag(int tagId) {
    final query = select(knowledge).join([
      innerJoin(
        knowledgeTagLink,
        knowledgeTagLink.knowledgeID.equalsExp(knowledge.id),
      ),
    ])..where(knowledgeTagLink.tagID.equals(tagId));

    return query.map((row) => row.readTable(knowledge)).get();
  }
}
