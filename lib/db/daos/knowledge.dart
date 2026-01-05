import 'package:drift/drift.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:fucking_math/db/tables/tables_knowledge.dart';
import 'package:fucking_math/db/tables/tables_tags.dart';
import 'package:fucking_math/utils/types.dart' show Subject;

part 'knowledge.g.dart';

@DriftAccessor(
  tables: [KnowledgeTable, KnowledgeLogTable, KnowledgeTagLink, Tags],
)
class KnowledgeDao extends DatabaseAccessor<AppDatabase>
    with _$KnowledgeDaoMixin {
  KnowledgeDao(super.db);

  // 创建知识点
  Future<int> createKnowledge(KnowledgeTableCompanion entry) =>
      into(knowledgeTable).insert(entry);

  // 获取所有知识点
  Future<List<KnowledgeTableData>> getAllKnowledge() =>
      select(knowledgeTable).get();

  // 根据学科获取知识点
  Future<List<KnowledgeTableData>> getKnowledgeBySubject(Subject subject) {
    return (select(
      knowledgeTable,
    )..where((k) => k.subject.equalsValue(subject))).get();
  }

  // 根据ID获取知识点
  Future<KnowledgeTableData?> getKnowledgeById(int id) {
    return (select(
      knowledgeTable,
    )..where((k) => k.id.equals(id))).getSingleOrNull();
  }

  // 搜索知识点(根据标题和内容)
  Future<List<KnowledgeTableData>> searchKnowledge(String query) {
    return (select(
      knowledgeTable,
    )..where((k) => k.head.like('%$query%') | k.body.like('%$query%'))).get();
  }

  // 更新知识点
  Future<bool> updateKnowledge(KnowledgeTableData knowledge) =>
      update(knowledgeTable).replace(knowledge);

  // 删除知识点
  Future<int> deleteKnowledge(int id) {
    return (delete(knowledgeTable)..where((k) => k.id.equals(id))).go();
  }

  // 添加知识点日志
  Future<int> addKnowledgeLog(KnowledgeLogTableCompanion entry) =>
      into(knowledgeLogTable).insert(entry);

  // 获取知识点的所有日志
  Future<List<KnowledgeLogTableData>> getKnowledgeLogs(int knowledgeId) {
    return (select(
      knowledgeLogTable,
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
  Future<List<KnowledgeTableData>> getKnowledgeByTag(int tagId) {
    final query = select(knowledgeTable).join([
      innerJoin(
        knowledgeTagLink,
        knowledgeTagLink.knowledgeID.equalsExp(knowledgeTable.id),
      ),
    ])..where(knowledgeTagLink.tagID.equals(tagId));

    return query.map((row) => row.readTable(knowledgeTable)).get();
  }
}
