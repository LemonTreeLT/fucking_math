import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ConfigLoader {
  static final exeDir = File(Platform.resolvedExecutable).parent.path;

  static final isDesktop =
      Platform.isLinux || Platform.isWindows || Platform.isMacOS;

  /// 加载通用数据目录
  static Future<Directory> loadDefaultDateStorage(bool isPortable) async =>
      Directory(
        !isPortable
            ? join(
                (await getApplicationDocumentsDirectory()).path,
                "Fucking Math",
              )
            : join(exeDir, "Portable Files"),
      );

  /// 加载配置文件
  static Future<File> loadConfigFile(Directory defaultDataStorage) async {
    final defaultConfigFile = File(
      join(defaultDataStorage.path, "config.toml"),
    );

    if (!isDesktop) return defaultConfigFile;

    try {
      final configPointerFile = File(join(exeDir, "cfg.path"));
      if (await configPointerFile.exists()) {
        final customPath = (await configPointerFile.readAsString()).trim();

        if (customPath.isNotEmpty) {
          final configFile = File(customPath);
          if (await configFile.exists()) return configFile;
        }
      }
    } catch (e) {
      if (kDebugMode) print("加载自定义配置路径失败: $e");
    }

    return defaultConfigFile;
  }

  static String loadDatabaseName(Map<String, dynamic> config) {
    final configDbName = config['Database']?['name'] as String?;
    final dbName = configDbName ?? "i like math anyway.sqlite.db";
    return dbName;
  }

  static File loadDatabaseFile(
    Map<String, dynamic> config,
    Directory defaultDataStorage,
    String dbName,
  ) {
    final dbPath = config['Database']?['path'] as String?;
    if (dbPath != null) return File(join(dbPath, dbName));

    return File(join(defaultDataStorage.path, dbName));
  }

  static Directory loadImageDirectory(
    Map<String, dynamic> config,
    Directory defaultDataStorage,
  ) {
    final configImagePath = config['Image']?['path'] as String?;
    return configImagePath != null
        ? Directory(configImagePath)
        : Directory(join(defaultDataStorage.path, "images"));
  }
}
