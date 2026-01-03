// tag_provider.dart

import 'package:flutter/foundation.dart';
import 'package:fucking_math/db/app_database.dart' as db;
import 'package:fucking_math/db/app_dao.dart';
import 'package:fucking_math/extensions/list.dart';
import 'package:fucking_math/utils/db/tag_repository.dart';

import 'package:fucking_math/providers/utils.dart';
import 'package:fucking_math/utils/types.dart';

class TagProvider extends ChangeNotifier {
  final TagRepository _rep;

  List<Tag> _tags = [];
  bool _isLoading = false;
  String? _error;

  List<Tag> get tags => _tags;
  bool get isLoading => _isLoading;
  String? get error => _error;

  TagProvider(db.AppDatabase db) : _rep = TagRepository(TagsDao(db));

  // --- 状态管理的私有辅助方法 ---
  void _onLoading() => _isLoading = true;
  void _onStopLoading() => _isLoading = false;
  void _clearError() => _error = null;
  void _setError(String errMsg) => _error = errMsg;
  void _setTags(List<Tag> tags) => _tags = tags;

  // --- 粘合剂：将通用工具与当前 Provider 绑定 ---
  Future<void> _justDoIt<T>({
    required Future<T> Function() action,
    String? errMsg,
    void Function(T result)? onSuccess,
  }) => justDoIt<T>(
    action,
    errMsg: errMsg,
    onLoading: _onLoading,
    onStopLoading: _onStopLoading,
    clearError: _clearError,
    setError: _setError,
    notifyListeners: notifyListeners,
    onSuccess: onSuccess,
  );

  // --- 查询：加载所有标签 ---
  Future<void> loadTags() async => _justDoIt<List<Tag>>(
    action: () => _rep.getAllTags(),
    onSuccess: _setTags,
    errMsg: "加载标签失败",
  );

  // --- 操作：添加或更新标签 ---
  Future<void> saveTag(
    String name, {
    String? description,
    Subject? subject,
    int? color,
  }) async => _justDoIt<Tag>(
    action: () => _rep.saveTag(
      name: name,
      description: description,
      subject: subject,
      color: color,
    ),
    onSuccess: (savedTag) =>
        _setTags(_tags.withUpsert(savedTag, (t) => t.id == savedTag.id)),
    errMsg: "保存标签失败",
  );
  
  // --- 操作：更新标签 ---
  Future<void> changeTag(Tag tag) async => _justDoIt<void>(
    action: () => _rep.changeTagById(tag),
    onSuccess: (_) => _setTags(_tags.withUpsert(tag, (t) => t.id == tag.id)),
    errMsg: "更新标签失败",
  );

  // --- 操作：删除标签 ---
  Future<void> deleteTag(int tagID) async => _justDoIt<void>(
    action: () => _rep.deleteTag(tagID),
    onSuccess: (_) => _setTags(_tags.where((tag) => tag.id != tagID).toList()),
    errMsg: "删除标签失败",
  );
}
