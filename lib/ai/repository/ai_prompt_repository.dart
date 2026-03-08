import 'package:drift/drift.dart';
import 'package:fucking_math/db/daos/ai_prompt.dart';
import 'package:fucking_math/db/app_database.dart' as db;
import 'package:fucking_math/ai/types.dart';
import 'package:fucking_math/utils/repository/helper/exceptions.dart';

/// Prompt 模板管理仓库层
/// 负责 Prompt 的 CRUD 操作和搜索功能
class PromptRepository {
  final PromptDao _dao;

  PromptRepository(this._dao);

  // ============ 基本 CRUD 操作 ============

  /// 创建新 Prompt
  Future<int> createPrompt({
    required String content,
    String? name,
    String? desc,
  }) async {
    try {
      final companion = db.PromptsCompanion.insert(
        content: content,
        name: name != null ? Value(name) : const Value(null),
        desc: desc != null ? Value(desc) : const Value(null),
      );
      return await _dao.createPrompt(companion);
    } catch (e) {
      throw AiHistoryException('Failed to create prompt: $e');
    }
  }

  /// 按 ID 获取 Prompt
  Future<Prompt?> getPromptById(int id) async {
    try {
      final dbPrompt = await _dao.getPromptById(id);
      if (dbPrompt == null) return null;
      return _dbPromptToPrompt(dbPrompt);
    } catch (e) {
      throw AiHistoryException('Failed to get prompt by ID: $e');
    }
  }

  /// 按名称查询 Prompt
  Future<Prompt?> getPromptByName(String name) async {
    try {
      final dbPrompt = await _dao.getPromptByName(name);
      if (dbPrompt == null) return null;
      return _dbPromptToPrompt(dbPrompt);
    } catch (e) {
      throw AiHistoryException('Failed to get prompt by name: $e');
    }
  }

  /// 获取全部 Prompt
  Future<List<Prompt>> getAllPrompts() async {
    try {
      final dbPrompts = await _dao.getAllPrompts();
      return dbPrompts.map(_dbPromptToPrompt).toList();
    } catch (e) {
      throw AiHistoryException('Failed to get all prompts: $e');
    }
  }

  /// 更新 Prompt
  Future<int> updatePrompt(
    int id, {
    String? name,
    String? desc,
    String? content,
  }) async {
    try {
      final companion = db.PromptsCompanion(
        name: name != null ? Value(name) : const Value.absent(),
        desc: desc != null ? Value(desc) : const Value.absent(),
        content: content != null ? Value(content) : const Value.absent(),
      );
      return await _dao.updatePrompt(companion, id);
    } catch (e) {
      throw AiHistoryException('Failed to update prompt: $e');
    }
  }

  /// 删除 Prompt
  Future<int> deletePrompt(int id) async {
    try {
      return await _dao.deletePrompt(id);
    } catch (e) {
      throw AiHistoryException('Failed to delete prompt: $e');
    }
  }

  // ============ 搜索功能 ============

  /// 按名称或描述模糊搜索 Prompt
  Future<List<Prompt>> searchPrompts(String query) async {
    try {
      final dbPrompts = await _dao.searchPrompts(query);
      return dbPrompts.map(_dbPromptToPrompt).toList();
    } catch (e) {
      throw AiHistoryException('Failed to search prompts: $e');
    }
  }

  // ============ 数据类型转换 Helper 方法 ============

  /// 将数据库 Prompt 转换为 types.Prompt
  Prompt _dbPromptToPrompt(db.Prompt dbPrompt) => Prompt(
        id: dbPrompt.id,
        name: dbPrompt.name,
        desc: dbPrompt.desc,
        content: dbPrompt.content,
      );
}
