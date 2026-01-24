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
  static late final Directory defaultDataStorage;

  static Future<void> initialize() async {
    defaultDataStorage = Directory(
      join(
        (await getApplicationDocumentsDirectory()).path,
        ".lemontree",
        "Fucking Math",
      ),
    );
    await defaultDataStorage.createIfNotExists();
  }
}

extension CreateDirIfNotExists on Directory {
  Future<void> createIfNotExists() async {
    if (!await exists()) {
      await create(recursive: true);
    }
  }
}
