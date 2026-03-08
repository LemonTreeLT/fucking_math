import 'package:drift/drift.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:fucking_math/db/tables/tables_ai.dart';

part 'ai_history.g.dart';

@DriftAccessor(tables: [AiHistories, Session])
class AiHistoryDao extends DatabaseAccessor<AppDatabase>
    with _$AiHistoryDaoMixin {
  AiHistoryDao(super.db);

  // 添加消息到历史
  Future<int> addMessage(AiHistoriesCompanion entry) =>
      into(aiHistories).insert(entry);

  // 获取特定提供商的所有历史记录
  Future<List<AiHistory>> getHistoryByProviderId(int providerId) =>
      (select(aiHistories)
            ..where((h) => h.providerId.equals(providerId))
            ..orderBy([(h) => OrderingTerm.asc(h.createdAt)]))
          .get();

  // 获取特定提供商的最近 N 条记录
  Future<List<AiHistory>> getRecentHistoryByProviderId(
    int providerId,
    int limit,
  ) =>
      (select(aiHistories)
            ..where((h) => h.providerId.equals(providerId))
            ..orderBy([(h) => OrderingTerm.desc(h.createdAt)])
            ..limit(limit))
          .get();

  // 获取特定提供商特定时间段内的历史记录
  Future<List<AiHistory>> getHistoryByProviderIdSinceHours(
    int providerId,
    DateTime startDate,
    DateTime endDate,
  ) async =>
      (select(aiHistories)
            ..where(
              (h) =>
                  h.providerId.equals(providerId) &
                  h.createdAt.isBiggerOrEqualValue(startDate) &
                  h.createdAt.isSmallerOrEqualValue(endDate),
            )
            ..orderBy([(h) => OrderingTerm.asc(h.createdAt)]))
          .get();

  // 清空特定提供商的历史记录
  Future<int> clearHistoryByProviderId(int providerId) =>
      (delete(aiHistories)..where((h) => h.providerId.equals(providerId))).go();

  // 删除超过 N 天的历史记录
  Future<int> deleteHistoryOlderThan(int days) async {
    final cutoffTime = DateTime.now().subtract(Duration(days: days));
    return (delete(
      aiHistories,
    )..where((h) => h.createdAt.isSmallerOrEqualValue(cutoffTime))).go();
  }

  // 通过 ID 删除历史记录
  Future<int> deleteHistoryById(int id) =>
      (delete(aiHistories)..where((h) => h.id.equals(id))).go();

  // 获取所有历史记录的总数
  Future<int> getHistoryCount() async {
    final query = selectOnly(aiHistories);
    query.addColumns([aiHistories.id.count()]);
    final result = await query
        .map((row) => row.read(aiHistories.id.count()))
        .getSingle();
    return result ?? 0;
  }

  // 获取特定提供商的历史记录总数
  Future<int> getHistoryCountByProviderId(int providerId) async {
    final query = selectOnly(aiHistories);
    query.addColumns([aiHistories.id.count()]);
    query.where(aiHistories.providerId.equals(providerId));
    final result = await query
        .map((row) => row.read(aiHistories.id.count()))
        .getSingle();
    return result ?? 0;
  }

  // ============ Session CRUD 操作 ============

  /// 创建新会话
  Future<int> createSession(SessionCompanion sessionCompanion) =>
      into(session).insert(sessionCompanion);

  /// 按 ID 获取会话
  Future<SessionData?> getSessionById(int id) =>
      (select(session)..where((s) => s.id.equals(id))).getSingleOrNull();

  /// 按标题查询会话
  Future<SessionData?> getSessionByTitle(String title) =>
      (select(session)..where((s) => s.title.equals(title)))
          .getSingleOrNull();

  /// 获取全部会话（按创建时间倒序）
  Future<List<SessionData>> getAllSessions() =>
      (select(session)..orderBy([(s) => OrderingTerm.desc(s.createdAt)]))
          .get();

  /// 更新会话标题
  Future<int> updateSessionTitle(int sessionId, String newTitle) =>
      (update(session)..where((s) => s.id.equals(sessionId)))
          .write(SessionCompanion(title: Value(newTitle)));

  /// 删除会话（级联删除关联历史）
  Future<int> deleteSession(int sessionId) async {
    // 先删除关联的历史记录
    await (delete(aiHistories)..where((h) => h.sessionId.equals(sessionId)))
        .go();
    // 再删除会话本身
    return (delete(session)..where((s) => s.id.equals(sessionId))).go();
  }

  /// 获取特定会话中的所有历史消息
  Future<List<AiHistory>> getHistoryBySessionAndProvider(
    int sessionId,
    int providerId,
  ) =>
      (select(aiHistories)
            ..where(
              (h) =>
                  h.sessionId.equals(sessionId) &
                  h.providerId.equals(providerId),
            )
            ..orderBy([(h) => OrderingTerm.asc(h.createdAt)]))
          .get();
}
