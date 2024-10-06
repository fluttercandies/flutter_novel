import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/entry/book_source_entry.dart';
import 'package:novel_flutter_bit/pages/collect_novel/enrty/collect_entry.dart';
import 'package:novel_flutter_bit/pages/home/entry/novel_history_entry.dart';
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
  static const novelHistory = "novelHistory";

  static const senseLikeNovel = "setSenseLikeNovel";

  static const novelSource = "novelSource";

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
  Future<void> setNovelFontWeight(NovelReadFontWeightEnum value) async {
    await sps.setString(fontWeight, value.id);
  }

  /// 获取-多主题模式
  Future<String> getNovelFontWeight() async {
    return await sps.getString(fontWeight) ?? 'w300';
  }

  Future<List<NovelHistoryEntry>> getNovelHistoryList() async {
    List<NovelHistoryEntry> list = [];
    List<String> str = await sps.getStringList(novelHistory) ?? [];
    for (var element in str) {
      list.add(NovelHistoryEntry.fromJson(json.decode(element)));
    }
    return list;
  }

  Future<void> setNovelHistory(NovelHistoryEntry novelHistoryEntry) async {
    List<String> str = [];
    final data = await getNovelHistoryList();
    final exists =
        data.any((novel) => novel.readUrl == novelHistoryEntry.readUrl);
    if (exists) {
      // 如果用户存在，移除该用户
      data.removeWhere((user) => user.readUrl == novelHistoryEntry.readUrl);
    }
    data.insert(0, novelHistoryEntry);
    for (var element in data) {
      str.add(json.encode(element.toJson()));
    }
    updateCollect(novelHistoryEntry);
    await sps.setStringList(novelHistory, str);
  }

  /// 更新收藏阅读记录
  Future<void> updateCollect(NovelHistoryEntry novelHistoryEntry) async {
    if (await getSenseLikeNovel(novelHistoryEntry.readUrl ?? "")) {
      CollectNovelEntry collectNovelEntry = CollectNovelEntry(
        name: novelHistoryEntry.name,
        imageUrl: novelHistoryEntry.imageUrl,
        readUrl: novelHistoryEntry.readUrl,
        readChapter: novelHistoryEntry.readChapter,
        datumNew: novelHistoryEntry.datumNew,
      );
      setSenseLikeNovel(
          novelHistoryEntry.readUrl ?? "", true, collectNovelEntry,
          firstAdd: false);
    }
  }

  ///  获取-是否喜欢
  Future<bool> getSenseLikeNovel(String key) async {
    LoggerTools.looger.d("获取是否收藏  getSenseLikeNovel key:$key");
    return await sps.getBool("${key}_SenseLike") ?? false;
  }

  /// 设置-是否喜欢
  Future<void> setSenseLikeNovel(
      String key, bool value, CollectNovelEntry? entry,
      {bool firstAdd = true}) async {
    LoggerTools.looger.d("设置是否收藏 setSenseLikeNovel  key:$key  value:$value");
    await sps.setBool("${key}_SenseLike", value);
    if (value && entry != null) {
      List<String> str = [];
      final data = await getCollectNovelList();
      final exists = data.any((novel) => novel.readUrl == entry.readUrl);
      if (exists) {
        // 如果用户存在，移除该用户
        if (firstAdd) {
          data.removeWhere((user) => user.readUrl == entry.readUrl);
          data.insert(0, entry);
        } else {
          int index = data.indexWhere((user) => user.readUrl == entry.readUrl);
          data[index] = entry;
        }
      } else {
        data.insert(0, entry);
      }

      for (var element in data) {
        str.add(json.encode(element.toJson()));
      }
      await sps.setStringList(senseLikeNovel, str);
    }
  }

  /// 获取-收藏列表
  Future<List<CollectNovelEntry>> getCollectNovelList() async {
    List<CollectNovelEntry> list = [];
    List<String> str = await sps.getStringList(senseLikeNovel) ?? [];
    for (var element in str) {
      list.add(CollectNovelEntry.fromJson(json.decode(element)));
    }
    LoggerTools.looger.d("获取收藏列表  getCollectNovelList  list:$list");
    return list;
  }

  /// 获取-书籍源
  Future<List<BookSourceEntry>> getNovelSourceList() async {
    List<BookSourceEntry> list = [];
    List<String> data = await sps.getStringList(novelSource) ?? [];

    /// List<String> str = await sps.getStringList(senseLikeNovel) ?? [];
    for (var element in data) {
      list.add(BookSourceEntry.fromJson(json.decode(element)));
    }
    LoggerTools.looger.d("获取-书籍源  getNovelSourceList  list:$list");
    return list;
  }

  Future<void> setNovelSourceList(BookSourceEntry bookSource) async {
    List<BookSourceEntry> list = await getNovelSourceList();
    list.add(bookSource);
    LoggerTools.looger.d("设置-书籍源  setNovelSourceList  list:$list");
    List<String> str = [];
    for (var element in list) {
      str.add(json.encode(element));
    }
    await sps.setStringList(novelSource, str);
  }
}
