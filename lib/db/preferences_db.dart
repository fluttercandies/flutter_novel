import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:novel_flutter_bit/pages/home/entry/novle_history_entry.dart';
import 'package:novel_flutter_bit/pages/novel/enum/novel_read_font_weight_enum.dart';
import 'package:novel_flutter_bit/theme/app_theme.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';

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

  /// 阅读记录
  static const novleHistory = "novleHistory";

  static const senseLikeNovel = "setSenseLikeNovel";

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

  Future<List<NovleHistoryEntry>> getNovleHistoryList() async {
    List<NovleHistoryEntry> list = [];
    List<String> str = await sps.getStringList(novleHistory) ?? [];
    for (var element in str) {
      list.add(NovleHistoryEntry.fromJson(json.decode(element)));
    }
    return list;
  }

  Future<void> setNovleHistory(NovleHistoryEntry novleHistoryEntry) async {
    List<String> str = [];
    final data = await getNovleHistoryList();
    final exists =
        data.any((novle) => novle.readUrl == novleHistoryEntry.readUrl);
    if (exists) {
      // 如果用户存在，移除该用户
      data.removeWhere((user) => user.readUrl == novleHistoryEntry.readUrl);
    }
    data.insert(0, novleHistoryEntry);
    for (var element in data) {
      str.add(json.encode(element.toJson()));
    }
    await sps.setStringList(novleHistory, str);
  }

  ///  获取-是否喜欢
  Future<bool> getSenseLikeNovel(String key) async {
    LoggerTools.looger.d("获取是否收藏  getSenseLikeNovel key:$key");
    return await sps.getBool("${key}_SenseLike") ?? false;
  }

  /// 设置-是否喜欢
  Future<void> setSenseLikeNovel(String key, bool value) async {
    LoggerTools.looger.d("设置是否收藏 setSenseLikeNovel  key:$key  value:$value");
    // if (value) {
    //   await sps.setBool("${key}_SenseLike", value);
    // } else {
    //   await sps.remove(key);
    // }
    await sps.setBool("${key}_SenseLike", value);
    //sps.setStringList(senseLikeNovel, )
  }
}
