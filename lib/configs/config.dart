import 'package:flutter/material.dart';

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
}

