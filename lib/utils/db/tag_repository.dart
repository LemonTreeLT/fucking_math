import 'package:drift/drift.dart';
import 'package:fucking_math/db/daos/tag.dart';
import 'package:fucking_math/utils/db/exceptions.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:fucking_math/db/app_database.dart' as db;

class TagRepository {
  final TagsDao _dao;
  const TagRepository(this._dao);

  /// Upsert 标签（接受 Tag 对象）
  /// 基于 tag.name 进行 upsert，如果名称存在则更新其他字段
  Future<Tag> upsertTag(Tag tag) async {
    return await _upsertAndRetrieve(
      db.TagsCompanion(
        id: tag.id > 0 ? Value(tag.id) : Value.absent(),
        tag: Value(tag.name),
        subject: Value(tag.subject),
        color: Value(tag.color),
        description: Value(tag.description),
      ),
    );
  }

  /// Upsert 标签（接受单独参数）
  /// 基于 name 进行 upsert，更新指定的字段
  Future<Tag> upsertTagByFields({
    required String name,
    String? description,
    Subject? subject,
    int? color,
  }) async {
    return await _upsertAndRetrieve(
      db.TagsCompanion.insert(
        tag: name,
        subject: Value(subject),
        color: Value(color),
        description: Value(description),
      ),
    );
  }

  /// 添加或更改 tag
  /// 注意：此方法是 upsertTagByFields 的语义别名，用于保持 API 兼容性
  Future<Tag> saveTag({
    required String name,
    String? description,
    Subject? subject,
    int? color,
  }) async {
    return await upsertTagByFields(
      name: name,
      description: description,
      subject: subject,
      color: color,
    );
  }

  /// 获取所有 tag
  Future<List<Tag>> getAllTags() async {
    final dbTags = await _dao.getAllTags();
    return dbTags.map((t) => t.toDomain()).toList();
  }

  /// 通过 id 删除 tag
  Future<void> deleteTag(int id) async => await _dao.deleteTag(id);

  // ------------ PRIVATE HELPERS ------------

  /// 执行 upsert 操作并获取完整的 Tag 对象
  ///
  /// 流程：
  /// 1. 执行 upsert（插入或更新）
  /// 2. 通过返回的 ID 获取完整记录
  /// 3. 验证记录存在性并转换为领域模型
  ///
  /// 抛出：
  /// - [TagNotFoundException] 当 upsert 后无法找到记录时（理论上不应发生）
  /// - [AppDatabaseException] 当数据库操作失败时
  Future<Tag> _upsertAndRetrieve(db.TagsCompanion companion) async {
    try {
      final tagId = await _dao.upsertTag(companion);
      final dbTag = await _dao.getTagById(tagId);

      if (dbTag == null) {
        throw TagNotFoundException(
          "Tag with id $tagId not found after upsert operation. "
          "This indicates a potential database consistency issue.",
        );
      }

      return dbTag.toDomain();
    } on TagNotFoundException {
      rethrow; // 保持原有的堆栈跟踪
    } catch (e, stackTrace) {
      throw AppDatabaseException(
        "Failed to upsert tag: ${e.toString()}",
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }
}

// ------------ PRIVATE EXTENSION (不导出) ------------

/// 数据库模型到领域模型的映射扩展
/// 仅在本文件内使用，不应被外部引用
extension _TagDomainMapper on db.Tag {
  /// 将数据库 Tag 转换为领域 Tag
  Tag toDomain() => Tag(
    id: id,
    name: tag,
    description: description,
    color: color,
    subject: subject,
  );
}
