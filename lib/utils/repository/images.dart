import 'dart:io';
import 'package:drift/drift.dart';
import 'package:fucking_math/db/daos/images.dart';
import 'package:fucking_math/utils/repository/helper/exceptions.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:fucking_math/utils/image.dart';

import 'package:fucking_math/db/app_database.dart' as db;

class ImagesRepository {
  final ImagesDao _dao;
  ImagesRepository(this._dao);

  // ==================== 核心 CRUD 操作 ====================

  /// 创建单个图片记录
  ///
  /// - [name] 图片名称(必填)
  /// - [path] 用户图片的存储路径(可选,null 表示资源图片)
  /// - [desc] 图片描述(可选)
  ///
  /// 抛出 [ImageValidationException] 当 path 不为 null 但文件不存在时
  Future<ImageStorage> createImage({
    required String name,
    String? path,
    String? desc,
  }) async {
    // 验证用户图片文件存在性
    if (path != null && !await File(path).exists()) {
      throw ImageValidationException(
        'Image file does not exist at path: $path',
        imagePath: path,
      );
    }

    final imageId = await _dao.createImage(
      db.ImagesCompanion.insert(
        name: name,
        path: Value(path),
        desc: Value(desc),
      ),
    );

    final newImage = await _dao.getImageById(imageId);
    if (newImage == null) {
      throw AppDatabaseException(
        'Database consistency error: Failed to retrieve image with id $imageId immediately after creation.',
      );
    }
    return _dbImageToImageStorage(newImage);
  }

  /// 批量创建图片记录(例如一次上传多张图片)
  ///
  /// 验证所有文件存在性后再批量插入
  /// 抛出 [ImageValidationException] 当任意 path 对应的文件不存在时
  Future<List<ImageStorage>> createImages(
    List<({String name, String? path, String? desc})> imageData,
  ) async {
    // 验证所有用户图片文件存在性
    for (final data in imageData) {
      if (data.path != null && !await File(data.path!).exists()) {
        throw ImageValidationException(
          'Image file does not exist at path: ${data.path}',
          imagePath: data.path,
        );
      }
    }

    final companions = imageData
        .map(
          (data) => db.ImagesCompanion.insert(
            name: data.name,
            path: Value(data.path),
            desc: Value(data.desc),
          ),
        )
        .toList();

    await _dao.createImages(companions);
    // 返回最近创建的图片(假设按创建时间倒序获取)

    return (await _dao.getRecentImages(
      imageData.length,
    )).map(_dbImageToImageStorage).toList();
  }

  /// 根据 ID 获取图片
  Future<ImageStorage?> getImageById(int id) async {
    final dbImage = await _dao.getImageById(id);
    return dbImage != null ? _dbImageToImageStorage(dbImage) : null;
  }

  /// 获取所有图片
  Future<List<ImageStorage>> getAllImages() async =>
      (await _dao.getAllImages()).map(_dbImageToImageStorage).toList();

  /// 更新图片信息
  ///
  /// - [id] 图片 ID
  /// - [name] 新名称(可选)
  /// - [desc] 新描述(可选)
  /// - [path] 新路径(可选,会验证文件存在性)
  ///
  /// 抛出 [ImageValidationException] 当更新的 path 对应的文件不存在时
  Future<ImageStorage> updateImage({
    required int id,
    String? name,
    String? desc,
    String? path,
  }) async {
    final existingImage = await _dao.getImageById(id);
    if (existingImage == null) {
      throw ImageNotFoundException('Image with id $id not found', imageId: id);
    }

    // 验证新路径的文件存在性
    if (path != null && !await File(path).exists()) {
      throw ImageValidationException(
        'Image file does not exist at path: $path',
        imagePath: path,
      );
    }

    final companion = db.ImagesCompanion(
      name: name != null ? Value(name) : Value.absent(),
      desc: desc != null ? Value(desc) : Value.absent(),
      path: path != null ? Value(path) : Value.absent(),
    );

    await _dao.updateImageWithCompanion(id, companion);
    final updatedImage = await _dao.getImageById(id);
    return _dbImageToImageStorage(updatedImage!);
  }

  /// 删除图片记录及对应的物理文件(如果是用户图片)
  ///
  /// 返回是否成功删除(false 表示图片不存在)
  Future<bool> deleteImage(int id) async {
    final image = await _dao.getImageById(id);
    if (image == null) return false;

    // 删除物理文件(仅用户图片)
    if (image.path != null) {
      final file = File(image.path!);
      if (await file.exists()) {
        await file.delete();
      }
    }

    final rowsDeleted = await _dao.deleteImage(id);
    return rowsDeleted > 0;
  }

  /// 批量删除图片及对应的物理文件
  Future<int> deleteImages(List<int> ids) async {
    final images = await Future.wait(ids.map(_dao.getImageById));

    // 删除物理文件
    for (final image in images) {
      if (image?.path != null) {
        final file = File(image!.path!);
        if (await file.exists()) {
          await file.delete();
        }
      }
    }

    return await _dao.deleteImages(ids);
  }

  // ==================== 条件查询 ====================

  /// 按名称精确查询图片
  Future<ImageStorage?> getImageByName(String name) async {
    final dbImage = await _dao.getImageByName(name);
    return dbImage != null ? _dbImageToImageStorage(dbImage) : null;
  }

  /// 按名称或描述模糊搜索图片
  Future<List<ImageStorage>> searchImages(String keyword) async =>
      (await _dao.searchImages(keyword)).map(_dbImageToImageStorage).toList();

  /// 获取所有资源图片(path 为 null)
  Future<List<ImageStorage>> getResourceImages() async =>
      (await _dao.getResourceImages()).map(_dbImageToImageStorage).toList();

  /// 获取所有用户图片(path 不为 null)
  Future<List<ImageStorage>> getUserImages() async =>
      (await _dao.getUserImages()).map(_dbImageToImageStorage).toList();

  /// 根据时间范围查询图片
  Future<List<ImageStorage>> getImagesByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async => (await _dao.getImagesByDateRange(
    startDate,
    endDate,
  )).map(_dbImageToImageStorage).toList();

  /// 分页查询图片
  Future<List<ImageStorage>> getImagesPaginated(int limit, int offset) async =>
      (await _dao.getImagesPaginated(
        limit,
        offset,
      )).map(_dbImageToImageStorage).toList();

  // ==================== 统计功能 ====================

  /// 获取图片总数
  Future<int> getImageCount() => _dao.getImageCount();

  /// 获取资源图片数量
  Future<int> getResourceImageCount() => _dao.getResourceImageCount();

  /// 获取用户图片数量
  Future<int> getUserImageCount() => _dao.getUserImageCount();

  /// 按月统计图片数量
  Future<Map<String, int>> getImageCountByMonth() =>
      _dao.getImageCountByMonth();

  /// 获取最近创建的 N 张图片
  Future<List<ImageStorage>> getRecentImages(int limit) async =>
      (await _dao.getRecentImages(limit)).map(_dbImageToImageStorage).toList();

  // ==================== 图片验证功能 ====================

  /// 验证单个图片是否失效
  ///
  /// 失效定义:数据库记录存在,但对应的物理文件不存在
  /// - 资源图片:检查 `ImageHelper.buildImageFile(name)` 是否存在
  /// - 用户图片:检查 `path` 对应的文件是否存在
  ///
  /// 返回 true 表示图片失效
  Future<bool> isImageInvalid(int id) async {
    final image = await _dao.getImageById(id);
    if (image == null) return false; // 记录不存在,不算失效

    final filePath = image.path ?? ImageHelper.buildPathString(image.name);
    return !await File(filePath).exists();
  }

  /// 获取所有失效的图片记录
  ///
  /// 返回 ID 列表,可用于批量清理
  Future<List<int>> getInvalidImageIds() async {
    final allImages = await _dao.getAllImages();
    final invalidIds = <int>[];

    for (final image in allImages) {
      final filePath = image.path ?? ImageHelper.buildPathString(image.name);
      if (!await File(filePath).exists()) {
        invalidIds.add(image.id);
      }
    }

    return invalidIds;
  }

  /// 删除所有失效的图片记录
  ///
  /// 返回删除的记录数
  Future<int> cleanupInvalidImages() async {
    final invalidIds = await getInvalidImageIds();
    if (invalidIds.isEmpty) return 0;

    // 注意:这里只删除数据库记录,因为物理文件本就不存在
    return await _dao.deleteImages(invalidIds);
  }

  // ==================== 私有辅助方法 ====================

  /// 数据库 Image 转换为应用 ImageStorage
  ImageStorage _dbImageToImageStorage(db.Image dbImage) => ImageStorage(
    id: dbImage.id,
    name: dbImage.name,
    desc: dbImage.desc,
    path: dbImage.path,
    imagePath: dbImage.path ?? ImageHelper.buildPathString(dbImage.name),
  );
}
