import 'package:drift/drift.dart';
import 'package:fucking_math/db/app_database.dart';
import 'package:fucking_math/db/tables/tables_ai.dart';
import 'package:fucking_math/db/tables/tables_images.dart';

part 'ai_history_images_link.g.dart';

@DriftAccessor(tables: [AiHistoryImagesLink, Images])
class AiHistoryImagesLinkDao extends DatabaseAccessor<AppDatabase>
    with _$AiHistoryImagesLinkDaoMixin {
  AiHistoryImagesLinkDao(super.db);

  // ==================== 单条关联操作 ====================

  /// 将单张图片关联到消息
  Future<int> linkImageToHistory(int historyId, int imageId) =>
      into(aiHistoryImagesLink).insert(
        AiHistoryImagesLinkCompanion.insert(
          historyId: historyId,
          imageId: imageId,
        ),
      );

  /// 删除单条关联
  Future<int> deleteImageLink(int historyId, int imageId) =>
      (delete(aiHistoryImagesLink)
            ..where((l) =>
                l.historyId.equals(historyId) & l.imageId.equals(imageId)))
          .go();

  // ==================== 批量关联操作 ====================

  /// 批量关联多张图片到消息
  Future<void> linkImagesToHistory(int historyId, List<int> imageIds) =>
      batch((batch) {
        final companions = imageIds
            .map((imageId) => AiHistoryImagesLinkCompanion.insert(
                  historyId: historyId,
                  imageId: imageId,
                ))
            .toList();
        batch.insertAll(aiHistoryImagesLink, companions);
      });

  /// 删除消息的所有关联图片
  Future<int> deleteAllLinksForHistory(int historyId) =>
      (delete(aiHistoryImagesLink)..where((l) => l.historyId.equals(historyId)))
          .go();

  /// 删除图片在所有消息中的关联
  Future<int> deleteAllLinksForImage(int imageId) =>
      (delete(aiHistoryImagesLink)..where((l) => l.imageId.equals(imageId)))
          .go();

  // ==================== 查询操作 ====================

  /// 获取消息关联的所有图片
  /// 返回 Drift Image 对象列表，供 Repository 层转换
  Future<List<Image>> getImagesByHistoryId(int historyId) =>
      (select(images).join([
        leftOuterJoin(
          aiHistoryImagesLink,
          aiHistoryImagesLink.imageId.equalsExp(images.id),
          useColumns: false,
        )
      ])
            ..where(aiHistoryImagesLink.historyId.equals(historyId))
            ..orderBy([
              OrderingTerm.asc(aiHistoryImagesLink.createdAt)
            ]))
          .map((row) => row.readTable(images))
          .get();

  /// 查询哪些消息包含该图片
  Future<List<int>> getHistoriesForImage(int imageId) =>
      (selectOnly(aiHistoryImagesLink)
            ..addColumns([aiHistoryImagesLink.historyId])
            ..where(aiHistoryImagesLink.imageId.equals(imageId)))
          .map((row) => row.read(aiHistoryImagesLink.historyId)!)
          .get();

  /// 获取消息关联的图片数量
  Future<int> getImageCountForHistory(int historyId) async {
    final countExp = aiHistoryImagesLink.id.count();
    final query = selectOnly(aiHistoryImagesLink)
      ..addColumns([countExp])
      ..where(aiHistoryImagesLink.historyId.equals(historyId));
    return query.map((row) => row.read(countExp) ?? 0).getSingle();
  }
}
