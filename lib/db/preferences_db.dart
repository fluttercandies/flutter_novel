import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/pages/novel/enum/novel_read_font_weight_enum.dart';
import 'package:novel_flutter_bit/theme/app_theme.dart';

import 'package:shared_preferences/shared_preferences.dart';

/// shared_preferences
class PreferencesDB {
  PreferencesDB._();
  static final PreferencesDB instance = PreferencesDB._();
  SharedPreferencesAsync? _instance;
  SharedPreferencesAsync get sps => _instance ??= SharedPreferencesAsync();

  /*** APP相关 ***/

  /// 主题外观模式
  ///
  /// system(默认)：跟随系统 light：普通 dark：深色
  static const appThemeDarkMode = 'appThemeDarkMode';

  /// 多主题模式
  ///
  /// default(默认)
  static const appMultipleThemesMode = 'appMultipleThemesMode';

  /// 字体大小
  ///
  ///
  static const fontSize = 'fontSize';

  /// 字体粗细
  static const fontWeight = 'fontWeight';

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

  /// 获取-fontsize 大小 默认18
  Future<double> getNovelFontSize() async {
    return await sps.getDouble(fontSize) ?? 18;
  }

  /// 设置 -fontsize 大小
  Future<void> setNovelFontSize(double size) async {
    await sps.setDouble(fontSize, size);
  }

  /// 设置-多主题模式
  Future<void> setNovleFontWeight(NovelReadFontWeightEnum value) async {
    await sps.setString(fontWeight, value.id);
  }

  /// 获取-多主题模式
  Future<String> getNovleFontWeight() async {
    return await sps.getString(fontWeight) ?? 'w300';
  }
}
