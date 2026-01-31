import 'dart:io';

import 'package:fucking_math/configs/config.dart';
import 'package:path/path.dart';

class ImageHelper {
  static String buildPathString(String name) =>
      join(Config.defaultDataStorage.path, name);

  static File buildImageFile(String name) => File(buildPathString(name));
}
