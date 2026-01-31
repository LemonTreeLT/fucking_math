import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

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
  static final dbFileName = "i like math anyway.sqlite.db";
  static late final Directory defaultDataStorage;
  static late final File dbFile;
  static late final File configFile;
  static late final bool isDesktop;
  static late final Directory imagesStorage;

  static Future<void> initialize() async {
    isDesktop = Platform.isLinux || Platform.isWindows || Platform.isMacOS;
    bool portable = false;

    if (isDesktop) {
      final portableFile = File(join(Directory.current.path, "portable"));
      if (await portableFile.exists()) portable = true;
    }

    defaultDataStorage = Directory(
      !portable
          ? join(
              (await getApplicationDocumentsDirectory()).path,
              "Fucking Math",
            )
          : join(Directory.current.path, "Portable Files"),
    );

    dbFile = File(join(defaultDataStorage.path, dbFileName));
    configFile = File(join(defaultDataStorage.path, "config.toml"));
    imagesStorage = Directory(join(defaultDataStorage.path, "images"));

    await defaultDataStorage.createIfNotExists();
    await imagesStorage.createIfNotExists();
  }
}

extension CreateDirIfNotExists on Directory {
  Future<void> createIfNotExists() async {
    if (!await exists()) {
      await create(recursive: true);
    }
  }
}
