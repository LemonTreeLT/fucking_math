// tag_provider.dart

import 'package:fucking_math/db/app_database.dart' show AppDatabase;
import 'package:fucking_math/db/app_dao.dart';
import 'package:fucking_math/extensions/list.dart';
import 'package:fucking_math/providers/base_proivder.dart';
import 'package:fucking_math/utils/db/tag_repository.dart';

import 'package:fucking_math/utils/types.dart';

class TagProvider extends BaseRepositoryProvider<Tag, TagRepository> {
  TagProvider(AppDatabase db) : super(TagRepository(TagsDao(db)));

  // --- 查询：加载所有标签 ---
  Future<void> loadTags() async => justDoIt<List<Tag>>(
    action: () => rep.getAllTags(),
    onSucces: setItems,
    errMsg: "加载标签失败",
  );

  // --- 操作：添加或更新标签 ---
  Future<void> saveTag(
    String name, {
    String? description,
    Subject? subject,
    int? color,
  }) async => justDoIt<Tag>(
    action: () => rep.saveTag(
      name: name,
      description: description,
      subject: subject,
      color: color,
    ),
    onSucces: (savedTag) =>
        setItems(items.withUpsert(savedTag, (t) => t.id == savedTag.id)),
    errMsg: "保存标签失败",
  );
  
  // --- 操作：更新标签 ---
  Future<void> changeTag(Tag tag) async => justDoIt<void>(
    action: () => rep.changeTagById(tag),
    onSucces: (_) => setItems(items.withUpsert(tag, (t) => t.id == tag.id)),
    errMsg: "更新标签失败",
  );

  // --- 操作：删除标签 ---
  Future<void> deleteTag(int tagID) async => justDoIt<void>(
    action: () => rep.deleteTag(tagID),
    onSucces: (_) => setItems(items.where((tag) => tag.id != tagID).toList()),
    errMsg: "删除标签失败",
  );
}
