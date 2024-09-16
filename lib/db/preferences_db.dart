import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/theme/app_theme.dart';

import 'package:shared_preferences/shared_preferences.dart';

/// shared_preferences
class PreferencesDB {
  PreferencesDB._();
  static final PreferencesDB instance = PreferencesDB._();
  SharedPreferencesAsync? _instance;
  SharedPreferencesAsync get sps => _instance ??= SharedPreferencesAsync();

  /*** APP相关 ***/

  /// 打开APP次数
  static const openAPPCount = 'openAPPCount';

  /// 主题外观模式
  ///
  /// system(默认)：跟随系统 light：普通 dark：深色
  static const appThemeDarkMode = 'appThemeDarkMode';

  /// 多主题模式
  ///
  /// default(默认)
  static const appMultipleThemesMode = 'appMultipleThemesMode';

  /*** shared_preferences ***/

  /// 设置-主题外观模式
  Future<void> setAppThemeDarkMode(ThemeMode themeMode) async {
    await sps.setString(appThemeDarkMode, themeMode.name);
  }

  /// 获取-主题外观模式
  Future<ThemeMode> getAppThemeDarkMode() async {
    final String themeDarkMode =
        await sps.getString(appThemeDarkMode) ?? 'system';
    return darkThemeMode(themeDarkMode);
  }

  /// 设置-多主题模式
  Future<void> setMultipleThemesMode(String value) async {
    await sps.setString(appMultipleThemesMode, value);
  }

  /// 获取-多主题模式
  Future<String> getMultipleThemesMode() async {
    return await sps.getString(appMultipleThemesMode) ?? 'default';
  }
}
