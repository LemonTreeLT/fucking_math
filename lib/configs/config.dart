import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fucking_math/configs/config_loader.dart';
import 'package:fucking_math/utils/file.dart';
import 'package:path/path.dart';
import 'package:toml/toml.dart';

class Config {
  static final String fontFamily = 'Noto Sans SC';
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: fontFamily,
    primarySwatch: Colors.blue,
  );
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: fontFamily,
    primarySwatch: Colors.yellow,
  );
  static late final String dbFileName;
  static late final Directory defaultDataStorage;
  static late final File dbFile;
  static late final File configFile;
  static late final bool isDesktop;
  static late final Directory imagesStorage;

  // =============== LOADER CODES ABOVE ===============
  static Future<void> initialize() async {
  // 1. 基础环境判断
  isDesktop = Platform.isLinux || Platform.isWindows || Platform.isMacOS;
  
  // 2. 确定是否便携模式
  bool portable = false;
  if (isDesktop) {
    portable = await File(join(ConfigLoader.exeDir, "portable")).exists();
  }

  // 3. 算出默认存储位置
  defaultDataStorage = await ConfigLoader.loadDefaultDateStorage(portable);
  // 确保默认存储目录存在 (哪怕后面不用它存数据库，也可能存日志等)
  await defaultDataStorage.create(recursive: true);

  // 4. 定位配置文件 (这里会处理 cfg.path 逻辑)
  configFile = await ConfigLoader.loadConfigFile(defaultDataStorage);

  // 5. 加载配置内容
  Map<String, dynamic> config = {};
  if (await configFile.exists()) {
    try {
      final content = await configFile.readAsString();
      config = TomlDocument.parse(content).toMap();
    } catch (e) {
      debugPrint("配置文件格式错误，将使用默认配置: $e");
    }
  } else {
    // 配置文件不存在：初始化它
    try {
      ByteData data = await rootBundle.load("assets/config.toml");
      await configFile.parent.create(recursive: true); // 记得 recursive
      await configFile.writeAsBytes(data.buffer.asUint8List());
      // 刚写进去的文件全是注释，config 保持 {} 是对的
    } catch (e) {
      debugPrint("无法创建配置文件: $e");
    }
  }

  // 6. 最终路径计算 (依赖刚才确定的 config 和 defaultDataStorage)
  dbFileName = ConfigLoader.loadDatabaseName(config);
  dbFile = ConfigLoader.loadDatabaseFile(config, defaultDataStorage, dbFileName);
  imagesStorage = ConfigLoader.loadImageDirectory(config, defaultDataStorage);

  // 7. 确保最终文件夹存在
  await imagesStorage.create(recursive: true);
  
  // 数据库文件所在的目录也得确保存在，否则后面 sqlite 会报错
  await dbFile.parent.create(recursive: true);
}

  static Future<void> saveDbPathConfig(String newValue) async =>
      await TomlEditor.updateValue(
        file: configFile,
        section: "Database",
        key: "path",
        newValue: newValue,
      );

  static Future<void> saveDbNameConfig(String newValue) async =>
      await TomlEditor.updateValue(
        file: configFile,
        section: "Database",
        key: "name",
        newValue: newValue,
      );

  static Future<void> saveGlobalResPath(String newValue) async =>
      await TomlEditor.updateValue(
        file: configFile,
        section: "Data",
        key: "path",
        newValue: newValue,
      );
}

extension CreateDirIfNotExists on Directory {
  Future<void> createIfNotExists() async {
    if (!await exists()) {
      await create(recursive: true);
    }
  }
}
