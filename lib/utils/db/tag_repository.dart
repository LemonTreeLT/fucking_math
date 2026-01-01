import 'package:drift/drift.dart';
import 'package:fucking_math/db/app_dao.dart';
import 'package:fucking_math/utils/db/exceptions.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:fucking_math/db/app_database.dart' as db;

class TagRepository {
  final TagsDao _dao;
  const TagRepository(this._dao);

  // 添加或者更改tag
  Future<Tag> saveTag({
    required String name,
    String? description,
    Subject? subject,
    int? color,
  }) async {
    final dbTag = await _findOrCreateTag(name, description, subject, color);
    await _updateDescription(dbTag, description, color);
    return _dbTagToTag(dbTag);
  }

  // 获取所有tag
  Future<List<Tag>> getAllTags() async =>
      (await _dao.getAllTags()).map((t) => _dbTagToTag(t)).toList();

  // 通过 id 删除 tag
  Future<void> deleteTag(int id) async => await _dao.deleteTag(id);

  // 通过 tag对象 更新 tag
  Future<void> changeTagById(Tag tag) async =>
      await _dao.updateTagWithCompanion(
        tag.id,
        db.TagsCompanion(
          tag: Value(tag.name),
          subject: Value(tag.subject),
          color: Value(tag.color),
          description: Value(tag.description),
        ),
      );

  // ------------ PUBLIC FUNCTIONS ABOVE ------------

  // 辅助函数: 更新备注&颜色
  Future<void> _updateDescription(
    db.Tag dbTag,
    String? description,
    int? color,
  ) async {
    if (description == null && color == null) return;
    await _dao.updateTagWithCompanion(
      dbTag.id,
      db.TagsCompanion(
        description: description != null ? Value(description) : Value.absent(),
        color: color != null ? Value(color) : Value.absent(),
      ),
    );
  }

  Future<db.Tag> _findOrCreateTag(
    String name,
    String? description,
    Subject? subject,
    int? color,
  ) async {
    final eTag = await _dao.getTag(name);
    if (eTag != null) return eTag;

    final tagID = await _dao.createTag(
      db.TagsCompanion.insert(
        tag: name,
        description: Value(description),
        color: Value(color),
        subject: Value(subject),
      ),
    );

    final newTag = await _dao.getTagById(tagID);
    if (newTag == null) {
      throw AppDatabaseException("Failed to get a tag which is just created");
    }

    return newTag;
  }

  Tag _dbTagToTag(db.Tag dbTag) => Tag(
    id: dbTag.id,
    name: dbTag.tag,
    description: dbTag.description,
    color: dbTag.color,
    subject: dbTag.subject,
  );
}
