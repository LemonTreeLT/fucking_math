import 'package:fucking_math/db/app_database.dart';
import 'package:fucking_math/db/daos/images.dart';
import 'package:fucking_math/providers/base_db_proivder.dart';
import 'package:fucking_math/utils/image.dart';
import 'package:fucking_math/utils/repository/images.dart';
import 'package:fucking_math/utils/types.dart';
import 'package:fucking_math/utils/uuid.dart';

class ImagesProvider
    extends BaseRepositoryProvider<ImageStorage, ImagesRepository> {
  ImagesProvider(AppDatabase db) : super(ImagesRepository(ImagesDao(db)));

  Future<ImageStorage?> createImage(String? path, String? desc, String name) =>
      justDoItNext(
        action: () => rep.createImage(name: name, desc: desc, path: path),
      );

  Future<List<ImageStorage>?> createImages(
    List<({String name, String? path, String? desc})> imageData,
  ) => justDoItNext(action: () => rep.createImages(imageData));

  Future<List<int>?> uploadImages(
    List<({String path, String name})> images,
  ) async => justDoItNext(
    action: () async {
      final namedImages = images
          .map((f) => (name: getUuidV1(), desc: f.name, path: f.path))
          .toList();

      await Future.wait(
        namedImages.map((e) => ImageHelper.copyFileToDataDir(e.path, e.name)),
      );

      return (await rep.createImages(
        namedImages
            .map((f) => (name: f.name, desc: f.desc, path: null))
            .toList(),
      )).map((f) => f.id).toList();
    },
  );
}
