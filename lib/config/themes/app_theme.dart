import 'package:flutter/material.dart';
import 'package:tab5ah/config/themes/text_theme.dart';

class AppTheme {
  static ThemeData getApplicationLightTheme() {
    return ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        textTheme: AppTextTheme.lightTextTheme,
    );
  }

  static ThemeData getApplicationDarkTheme() {
    return ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        textTheme: AppTextTheme.darkTextTheme,
    );
  }
}
