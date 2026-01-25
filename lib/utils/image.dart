import 'package:fucking_math/configs/config.dart';
import 'package:path/path.dart';

class ImageHelper {
  static String buildPath(String name) =>
      join(Config.defaultDataStorage.path, name);
}
