import 'package:drift/drift.dart';
import 'package:fucking_math/db/daos/ai_history.dart';
import 'package:fucking_math/db/daos/ai_history_images_link.dart';
import 'package:fucking_math/db/app_database.dart' as db;
import 'package:fucking_math/ai/types.dart';
import 'package:fucking_math/utils/repository/helper/exceptions.dart';
import 'package:fucking_math/utils/types.dart' show ImageStorage;

/// AI 对话历史管理仓库层
/// 负责消息历史和会话的 CRUD 操作，并提供数据转换功能
class AiHistoryRepository {
  final AiHistoryDao _dao;
  final AiHistoryImagesLinkDao _imageLinkDao;

  AiHistoryRepository(this._dao, this._imageLinkDao);

  // ============ 历史消息 CRUD 操作 ============

  /// 添加新消息到历史
  Future<int> addMessage({
    required int providerId,
    required Roles role,
    required String content,
    int? sessionId,
    String? toolCalls,
    String? toolId,
    int? tokens,
    List<int>? imageIds,
  }) async {
    try {
      final companion = db.AiHistoriesCompanion.insert(
        providerId: providerId,
        role: role,
        sessionId: sessionId ?? 0,
        content: content,
        toolCalls: toolCalls != null ? Value(toolCalls) : const Value(null),
        toolCallId: toolId != null ? Value(toolId) : const Value(null),
        tokens: tokens != null ? Value(tokens) : const Value(null),
      );
      final messageId = await _dao.addMessage(companion);
      if (imageIds != null && imageIds.isNotEmpty) {
        await _imageLinkDao.linkImagesToHistory(messageId, imageIds);
      }
      return messageId;
    } catch (e) {
      throw AiHistoryException('Failed to add message: $e');
    }
  }

  /// 获取特定提供商的所有历史消息
  Future<List<Message>> getHistoryByProviderId(int providerId) async {
    try {
      final dbMessages = await _dao.getHistoryByProviderId(providerId);
      return Future.wait(dbMessages.map(_dbHistoryToMessage));
    } catch (e) {
      throw AiHistoryException('Failed to get history by provider ID: $e');
    }
  }

  /// 获取特定提供商最近的 N 条消息
  Future<List<Message>> getRecentHistoryByProviderId(
    int providerId,
    int limit,
  ) async {
    try {
      final dbMessages = await _dao.getRecentHistoryByProviderId(providerId, limit);
      return Future.wait(dbMessages.map(_dbHistoryToMessage));
    } catch (e) {
      throw AiHistoryException('Failed to get recent history: $e');
    }
  }

  /// 获取时间范围内的历史消息
  Future<List<Message>> getHistoryByProviderIdSinceHours(
    int providerId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final dbMessages = await _dao.getHistoryByProviderIdSinceHours(
        providerId,
        startDate,
        endDate,
      );
      return Future.wait(dbMessages.map(_dbHistoryToMessage));
    } catch (e) {
      throw AiHistoryException('Failed to get history by date range: $e');
    }
  }

  /// 删除单条历史记录
  Future<int> deleteHistoryById(int id) async {
    try {
      return await _dao.deleteHistoryById(id);
    } catch (e) {
      throw AiHistoryException('Failed to delete history by ID: $e');
    }
  }

  /// 清空特定提供商的全部历史
  Future<int> clearHistoryByProviderId(int providerId) async {
    try {
      return await _dao.clearHistoryByProviderId(providerId);
    } catch (e) {
      throw AiHistoryException('Failed to clear history for provider: $e');
    }
  }

  /// 删除超过指定天数的历史记录
  Future<int> deleteHistoryOlderThan(int days) async {
    try {
      return await _dao.deleteHistoryOlderThan(days);
    } catch (e) {
      throw AiHistoryException('Failed to delete old history: $e');
    }
  }

  /// 获取全部记录总数
  Future<int> getHistoryCount() async {
    try {
      return await _dao.getHistoryCount();
    } catch (e) {
      throw AiHistoryException('Failed to get history count: $e');
    }
  }

  /// 获取指定提供商的记录数
  Future<int> getHistoryCountByProviderId(int providerId) async {
    try {
      return await _dao.getHistoryCountByProviderId(providerId);
    } catch (e) {
      throw AiHistoryException('Failed to get history count by provider: $e');
    }
  }

  // ============ 会话 (Session) 管理 ============

  /// 创建新会话
  Future<int> createSession({String? title}) async {
    try {
      final companion = db.SessionCompanion.insert(
        title: title != null ? Value(title) : const Value(null),
      );
      return await _dao.createSession(companion);
    } catch (e) {
      throw AiHistoryException('Failed to create session: $e');
    }
  }

  /// 获取会话详情
  Future<Session?> getSessionById(int sessionId) async {
    try {
      final dbSession = await _dao.getSessionById(sessionId);
      if (dbSession == null) return null;
      return _dbSessionToSession(dbSession);
    } catch (e) {
      throw AiHistoryException('Failed to get session by ID: $e');
    }
  }

  /// 按标题查询会话
  Future<Session?> getSessionByTitle(String title) async {
    try {
      final dbSession = await _dao.getSessionByTitle(title);
      if (dbSession == null) return null;
      return _dbSessionToSession(dbSession);
    } catch (e) {
      throw AiHistoryException('Failed to get session by title: $e');
    }
  }

  /// 获取全部会话
  Future<List<Session>> getAllSessions() async {
    try {
      final dbSessions = await _dao.getAllSessions();
      return dbSessions.map(_dbSessionToSession).toList();
    } catch (e) {
      throw AiHistoryException('Failed to get all sessions: $e');
    }
  }

  /// 更新会话标题
  Future<int> updateSessionTitle(int sessionId, String newTitle) async {
    try {
      return await _dao.updateSessionTitle(sessionId, newTitle);
    } catch (e) {
      throw AiHistoryException('Failed to update session title: $e');
    }
  }

  /// 删除会话（级联删除关联历史）
  Future<int> deleteSession(int sessionId) async {
    try {
      return await _dao.deleteSession(sessionId);
    } catch (e) {
      throw AiHistoryException('Failed to delete session: $e');
    }
  }

  // ============ 对话 (Conversation) 查询 ============

  /// 获取完整对话（包括会话和所有消息）
  Future<Conversation> getConversation(int sessionId, int providerId) async {
    try {
      // 获取 Session
      final dbSession = await _dao.getSessionById(sessionId);
      if (dbSession == null) {
        throw AiSessionNotFoundException('Session not found',
            sessionId: sessionId);
      }

      // 获取该会话中该提供商的所有历史消息
      final dbMessages =
          await _dao.getHistoryBySessionAndProvider(sessionId, providerId);
      final messages = await Future.wait(dbMessages.map(_dbHistoryToMessage));

      return Conversation(
        session: _dbSessionToSession(dbSession),
        messages: messages,
      );
    } on AiSessionNotFoundException {
      rethrow;
    } catch (e) {
      throw AiHistoryException('Failed to get conversation: $e');
    }
  }

  // ============ 数据类型转换 Helper 方法 ============

  /// 将数据库 AiHistory 转换为 Message (async 用于加载关联的图片)
  Future<Message> _dbHistoryToMessage(db.AiHistory history) async {
    final dbImages = await _imageLinkDao.getImagesByHistoryId(history.id);
    final images = dbImages.isNotEmpty
        ? dbImages.map(_dbImageToImageStorage).toList()
        : null;

    return Message(
      id: history.id,
      providerId: history.providerId,
      role: history.role,
      session: history.sessionId != 0
          ? Session(id: history.sessionId)
          : null,
      content: history.content,
      toolCalls: history.toolCalls,
      toolId: history.toolCallId,
      token: history.tokens,
      createdAt: history.createdAt,
      images: images,
    );
  }

  /// 将数据库 Image 转换为 ImageStorage
  ImageStorage _dbImageToImageStorage(db.Image dbImage) => ImageStorage(
    id: dbImage.id,
    name: dbImage.name,
    desc: dbImage.desc,
    path: dbImage.path,
    imagePath: dbImage.path ?? '',
  );

  /// 将数据库 SessionData 转换为 types.Session
  Session _dbSessionToSession(db.SessionData dbSession) => Session(
        id: dbSession.id,
        title: dbSession.title,
        createdAt: dbSession.createdAt,
      );

  // ============ 图片关联管理操作 ============

  /// 向现有消息添加图片
  Future<void> addImagesToMessage(int messageId, List<int> imageIds) async {
    try {
      if (imageIds.isEmpty) return;
      await _imageLinkDao.linkImagesToHistory(messageId, imageIds);
    } catch (e) {
      throw AiHistoryException('Failed to add images to message: $e');
    }
  }

  /// 从消息中移除特定图片
  Future<void> removeImageFromMessage(int messageId, int imageId) async {
    try {
      await _imageLinkDao.deleteImageLink(messageId, imageId);
    } catch (e) {
      throw AiHistoryException('Failed to remove image from message: $e');
    }
  }

  /// 清空消息的所有图片
  Future<void> clearMessageImages(int messageId) async {
    try {
      await _imageLinkDao.deleteAllLinksForHistory(messageId);
    } catch (e) {
      throw AiHistoryException('Failed to clear message images: $e');
    }
  }

  /// 获取消息关联的所有图片
  Future<List<ImageStorage>> getMessageImages(int messageId) async {
    try {
      final dbImages = await _imageLinkDao.getImagesByHistoryId(messageId);
      return dbImages.map(_dbImageToImageStorage).toList();
    } catch (e) {
      throw AiHistoryException('Failed to get message images: $e');
    }
  }
}
