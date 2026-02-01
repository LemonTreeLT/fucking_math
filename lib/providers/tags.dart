// tag_provider.dart

import 'package:fucking_math/db/app_database.dart' show AppDatabase;
import 'package:fucking_math/db/daos/tag.dart';
import 'package:fucking_math/extensions/list.dart';
import 'package:fucking_math/providers/base_db_proivder.dart';
import 'package:fucking_math/utils/repository/tag.dart';
import 'package:fucking_math/utils/types.dart';

/// 标签管理 Provider
/// 
/// 提供标签的增删改查功能，维护标签列表的本地状态。
/// 所有操作通过 [TagRepository] 执行，并自动更新 UI 状态。
/// 
/// 使用示例：
/// ```dart
/// final provider = Provider.of<TagProvider>(context);
/// await provider.loadTags(); // 加载所有标签
/// await provider.saveTag('数学', subject: Subject.math); // 保存新标签
/// ```
class TagProvider extends BaseRepositoryProvider<Tag, TagRepository> {
  TagProvider(AppDatabase db) : super(TagRepository(TagsDao(db)));

  /// 加载所有标签
  /// 
  /// 从数据库获取所有标签并更新本地状态。
  /// 此方法会触发 UI 刷新。
  /// 
  /// 抛出：
  /// - 通过 [justDoIt] 处理的数据库异常将设置 [error] 状态
  Future<void> loadTags() async => justDoIt<List<Tag>>(
        action: () => rep.getAllTags(),
        onSucces: setItems,
        errMsg: "加载标签失败",
      );

  /// 保存标签（通过字段参数）
  /// 
  /// 根据 [name] 执行 upsert 操作：
  /// - 如果标签不存在，创建新标签
  /// - 如果标签已存在（按 name 匹配），更新其他字段
  /// 
  /// 参数：
  /// - [name]: 标签名称（必填，不能为空）
  /// - [description]: 标签描述
  /// - [subject]: 关联学科
  /// - [color]: 标签颜色（ARGB 格式）
  /// 
  /// 抛出：
  /// - [ArgumentError] 当 [name] 为空时
  /// - 其他数据库异常通过 [justDoIt] 处理
  Future<void> saveTag(
    String name, {
    String? description,
    Subject? subject,
    int? color,
  }) async {
    // 输入验证
    if (name.trim().isEmpty) {
      setError("标签名称不能为空");
      notifyListeners();
      return;
    }

    await justDoIt<Tag>(
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
  }

  /// 更新标签（通过 Tag 对象）
  /// 
  /// 直接使用 [Tag] 对象执行 upsert 操作。
  /// 适用于已有完整 Tag 对象的场景（如编辑现有标签）。
  /// 
  /// 参数：
  /// - [tag]: 要保存的标签对象
  /// 
  /// 抛出：
  /// - [ArgumentError] 当 [tag.name] 为空时
  /// - 其他数据库异常通过 [justDoIt] 处理
  Future<void> upsertTag(Tag tag) async {
    // 输入验证
    if (tag.name.trim().isEmpty) {
      setError("标签名称不能为空");
      notifyListeners();
      return;
    }

    await justDoIt<Tag>(
      action: () => rep.upsertTag(tag),
      onSucces: (savedTag) =>
          setItems(items.withUpsert(savedTag, (t) => t.id == savedTag.id)),
      errMsg: "更新标签失败",
    );
  }

  /// 删除标签
  /// 
  /// 根据 ID 删除指定标签，并从本地状态中移除。
  /// 
  /// 参数：
  /// - [tagID]: 要删除的标签 ID
  /// 
  /// 抛出：
  /// - 数据库异常通过 [justDoIt] 处理
  Future<void> deleteTag(int tagID) async => justDoIt<void>(
        action: () => rep.deleteTag(tagID),
        onSucces: (_) => setItems(items.where((tag) => tag.id != tagID).toList()),
        errMsg: "删除标签失败",
      );
}
