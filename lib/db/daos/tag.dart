import 'package:drift/drift.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:fucking_math/db/tables/tables_tags.dart';
import 'package:fucking_math/utils/types.dart' show Subject;

part 'tag.g.dart';

@DriftAccessor(tables: [Tags])
class TagsDao extends DatabaseAccessor<AppDatabase> with _$TagsDaoMixin {
  TagsDao(super.db);

  // 创建标签
  Future<int> createTag(TagsCompanion entry) => into(tags).insert(entry);

  // 通过名称获取tag
  Future<Tag?> getTag(String name) =>
      (select(tags)
            ..where((t) => t.tag.equals(name))
            ..limit(1))
          .getSingleOrNull();

  // 通过 companion 更新 tag
  Future<int> updateTagWithCompanion(int id, TagsCompanion companion) =>
      (update(tags)..where((t) => t.id.equals(id))).write(companion);

  // 获取所有标签
  Future<List<Tag>> getAllTags() => select(tags).get();

  // 根据学科获取标签
  Future<List<Tag>> getTagsBySubject(Subject? subject) =>
      (select(tags)..where((t) => t.subject.equalsValue(subject))).get();

  // 根据ID获取标签
  Future<Tag?> getTagById(int id) =>
      (select(tags)..where((t) => t.id.equals(id))).getSingleOrNull();

  // 更新标签
  Future<bool> updateTag(Tag tag) => update(tags).replace(tag);

  // 删除标签
  Future<int> deleteTag(int id) =>
      (delete(tags)..where((t) => t.id.equals(id))).go();

  /// Upsert 标签（基于 tag 名称的 unique 约束）
  /// 如果 tag 名称已存在则更新，否则插入
  /// 返回插入或更新的记录 ID
  Future<int> upsertTag(TagsCompanion entry) async =>
      await into(tags).insertOnConflictUpdate(entry);
}
