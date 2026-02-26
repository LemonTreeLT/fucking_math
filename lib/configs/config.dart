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
  static late final dbFileName;
  static late final Directory defaultDataStorage;
  static late final File dbFile;
  static late final File configFile;
  static late final bool isDesktop;
  static late final Directory imagesStorage;

  // =============== LOADER CODES ABOVE ===============
  static Future<void> initialize() async {
    isDesktop = Platform.isLinux || Platform.isWindows || Platform.isMacOS;
    bool portable = false;

    if (isDesktop) {
      final portableFile = File(join(Directory.current.path, "portable"));
      if (await portableFile.exists()) portable = true;
    }

    defaultDataStorage = await ConfigLoader.loadDefaultDateStorage(portable);

    configFile = await ConfigLoader.loadConfigFile(defaultDataStorage);

    Map<String, dynamic> config = {};

    try {
      final content = await configFile.readAsString();
      config = TomlDocument.parse(content).toMap();
    } on PathNotFoundException catch (e) {
      ByteData data = await rootBundle.load("assets/config.toml");
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );
      await configFile.writeAsBytes(bytes);
    } catch (e) {
      if (kDebugMode) print("加载配置文件失败: $e");
    }

    dbFileName = ConfigLoader.loadDatabaseName(config);
    dbFile = ConfigLoader.loadDatabaseFile(
      config,
      defaultDataStorage,
      dbFileName,
    );
    imagesStorage = ConfigLoader.loadImageDirectory(config, defaultDataStorage);

    await defaultDataStorage.createIfNotExists();
    await imagesStorage.createIfNotExists();
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
}

extension CreateDirIfNotExists on Directory {
  Future<void> createIfNotExists() async {
    if (!await exists()) {
      await create(recursive: true);
    }
  }
}
