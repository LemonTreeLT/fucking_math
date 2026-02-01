import 'package:drift/drift.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:fucking_math/db/tables/tables_images.dart';

part 'images.g.dart';

@DriftAccessor(tables: [Images])
class ImagesDao extends DatabaseAccessor<AppDatabase> with _$ImagesDaoMixin {
  ImagesDao(super.db);

  // ==================== 基础 CRUD ====================

  /// 创建图片记录
  Future<int> createImage(ImagesCompanion entry) => into(images).insert(entry);

  /// 批量创建图片记录
  Future<void> createImages(List<ImagesCompanion> entries) =>
      batch((batch) => batch.insertAll(images, entries));

  /// 通过 ID 获取图片
  Future<Image?> getImageById(int id) =>
      (select(images)..where((i) => i.id.equals(id))).getSingleOrNull();

  /// 获取所有图片
  Future<List<Image>> getAllImages() => select(images).get();

  /// 更新图片
  Future<bool> updateImage(Image image) => update(images).replace(image);

  /// 通过 Companion 更新图片
  Future<int> updateImageWithCompanion(int id, ImagesCompanion companion) =>
      (update(images)..where((i) => i.id.equals(id))).write(companion);

  /// 批量更新图片(例如批量修改描述)
  Future<void> updateImages(List<Image> imageList) =>
      batch((batch) => batch.replaceAll(images, imageList));

  /// 删除图片
  Future<int> deleteImage(int id) =>
      (delete(images)..where((i) => i.id.equals(id))).go();

  /// 批量删除图片
  Future<int> deleteImages(List<int> ids) =>
      (delete(images)..where((i) => i.id.isIn(ids))).go();

  // ==================== 条件查询 ====================

  /// 按名称精确查询图片
  Future<Image?> getImageByName(String name) =>
      (select(images)..where((i) => i.name.equals(name))).getSingleOrNull();

  /// 按名称或描述模糊搜索图片
  Future<List<Image>> searchImages(String keyword) => (select(
    images,
  )..where((i) => i.name.like('%$keyword%') | i.desc.like('%$keyword%'))).get();

  /// 获取所有资源图片(path 为 null)
  Future<List<Image>> getResourceImages() =>
      (select(images)..where((i) => i.path.isNull())).get();

  /// 获取所有用户图片(path 不为 null)
  Future<List<Image>> getUserImages() =>
      (select(images)..where((i) => i.path.isNotNull())).get();

  /// 根据时间范围查询图片
  Future<List<Image>> getImagesByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) =>
      (select(images)
            ..where(
              (i) =>
                  i.createAt.isBiggerOrEqualValue(startDate) &
                  i.createAt.isSmallerOrEqualValue(endDate),
            )
            ..orderBy([(i) => OrderingTerm.desc(i.createAt)]))
          .get();

  /// 分页查询图片
  Future<List<Image>> getImagesPaginated(int limit, int offset) =>
      (select(images)
            ..orderBy([(i) => OrderingTerm.desc(i.createAt)])
            ..limit(limit, offset: offset))
          .get();

  // ==================== 统计功能 ====================

  /// 获取图片总数
  Future<int> getImageCount() {
    final countExp = images.id.count();
    final query = selectOnly(images)..addColumns([countExp]);
    return query.map((row) => row.read(countExp) ?? 0).getSingle();
  }

  /// 获取资源图片数量
  Future<int> getResourceImageCount() {
    final countExp = images.id.count();
    final query = selectOnly(images)
      ..addColumns([countExp])
      ..where(images.path.isNull());
    return query.map((row) => row.read(countExp) ?? 0).getSingle();
  }

  /// 获取用户图片数量
  Future<int> getUserImageCount() {
    final countExp = images.id.count();
    final query = selectOnly(images)
      ..addColumns([countExp])
      ..where(images.path.isNotNull());
    return query.map((row) => row.read(countExp) ?? 0).getSingle();
  }

  /// 按月统计图片数量
  /// 返回 Map: {year-month: count}
  /// 例如: {"2024-01": 15, "2024-02": 23}
  Future<Map<String, int>> getImageCountByMonth() async {
    final results =
        await (selectOnly(images)
              ..addColumns([images.id.count()])
              ..groupBy([images.createAt.year, images.createAt.month])
              ..orderBy([
                OrderingTerm.desc(images.createAt.year),
                OrderingTerm.desc(images.createAt.month),
              ]))
            .get();

    final Map<String, int> monthlyCount = {};
    for (final row in results) {
      final year = row.read(images.createAt.year);
      final month = row.read(images.createAt.month);
      final count = row.read(images.id.count()) ?? 0;
      if (year != null && month != null) {
        final key = '$year-${month.toString().padLeft(2, '0')}';
        monthlyCount[key] = count;
      }
    }
    return monthlyCount;
  }

  /// 获取最近创建的 N 张图片
  Future<List<Image>> getRecentImages(int limit) =>
      (select(images)
            ..orderBy([(i) => OrderingTerm.desc(i.createAt)])
            ..limit(limit))
          .get();
}
