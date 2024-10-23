// ignore_for_file: control_flow_in_finally

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/db/preferences_db.dart';
import 'package:novel_flutter_bit/entry/book_source_entry.dart';
import 'package:novel_flutter_bit/n_pages/detail/entry/detail_book_entry.dart';
import 'package:novel_flutter_bit/n_pages/detail/view_model/detail_view_model.dart';
import 'package:novel_flutter_bit/n_pages/history/entry/history_entry.dart';
import 'package:novel_flutter_bit/n_pages/read/state/read_state.dart';
import 'package:novel_flutter_bit/n_pages/search/entry/search_entry.dart';
import 'package:novel_flutter_bit/net/new_novel_http.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:novel_flutter_bit/tools/parse_source_rule.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'read_view_model.g.dart';

/// 阅读页面
/// 时间 2024-10-10
/// 7-bit
@riverpod
class ReadViewModel extends _$ReadViewModel {
  /// 创建state
  ReadState readState = ReadState();

  /// url
  late Chapter chapter;

  late BookSourceEntry _bookSourceEntry;

  /// 所有章节
  late NewDetailViewModel? detailViewModel;

  late SearchEntry _searchEntry;
  @override
  Future<ReadState> build(
      {required Chapter chapter1,
      required BookSourceEntry bookSource,
      required SearchEntry searchEntry,
      NewDetailViewModel? detailView,
      List<Chapter>? chapterList}) async {
    LoggerTools.looger.d("NEW NewDetailViewModel init build");
    chapter = chapter1;
    _bookSourceEntry = bookSource;
    _searchEntry = searchEntry;
    detailViewModel = detailView;
    readState.chapterList = chapterList;
    buildBackgroundImage();
    //_initData(detailUrl: chapter1.chapterUrl ?? "");
    _initListData(chapterList: chapterList);
    return readState;
  }

  /// 获取阅读索引
  int getReadIndex(Chapter chapter1) {
    final l =
        (detailViewModel?.detailState.detailBookEntry?.chapter?.length ?? 0);
    for (var i = 0; i < l; i++) {
      var element =
          detailViewModel?.detailState.detailBookEntry?.chapter?[i].chapterName;
      if (element == chapter1.chapterName) {
        return i;
      }
    }
    return 0;
  }

  Future<String?> _initData({
    required String detailUrl,
  }) async {
    try {
      final data = await _initDataAll(detailUrl: detailUrl, str: "");
      if (data == "") {
        return null;
      }
      return data;
      // LoggerTools.looger.d(data);
    } catch (e) {
      LoggerTools.looger.e("NewSearchViewModel _initData error:$e");
      // searchState.netState = NetState.error403State;
      // state = AsyncData(searchState);
      SmartDialog.showToast(e.toString());
      return null;
    }
  }

  Future<bool> refreshDataNext({
    required int index,
  }) async {
    try {
      final length =
          detailViewModel?.detailState.detailBookEntry?.chapter?.length ?? 0;
      if (index >= length - 2) {
        if (readState.chapterList![1].chapterUrl !=
            detailViewModel
                ?.detailState.detailBookEntry?.chapter?[2].chapterUrl) {
          readState.chapterList![0] = readState.chapterList![1];
          readState.chapterList![0] = readState.chapterList![1];
          readState.chapterList![1] = readState.chapterList![2];
          readState.listContent![1] = readState.listContent![2];
          setReadIndex(readState.chapterList![1]);
        }
        return true;
      }
      final chanper =
          detailViewModel?.detailState.detailBookEntry?.chapter?[index + 2];
      final data = await _initData(detailUrl: chanper?.chapterUrl ?? "");
      if (data != null) {
        readState.chapterList?.removeAt(0);
        readState.chapterList?.add(chanper ?? Chapter());
        readState.listContent?.removeAt(0);
        readState.listContent?.add(data);
        LoggerTools.looger.i("===================");
        //state = AsyncData(readState);
        setReadIndex(readState.chapterList![1]);
      }
      return false;
    } catch (e) {
      LoggerTools.looger.e("NewSearchViewModel _initData error:$e");
      return false;
    }
  }

  Future<bool> refreshDataBack({
    required int index,
  }) async {
    try {
      if (index <= 1) {
        if (readState.chapterList![1].chapterUrl !=
            detailViewModel
                ?.detailState.detailBookEntry?.chapter?[0].chapterUrl) {
          readState.chapterList![2] = readState.chapterList![1];
          readState.chapterList![2] = readState.chapterList![1];
          readState.chapterList![1] = readState.chapterList![0];
          readState.listContent![1] = readState.listContent![0];
          setReadIndex(readState.chapterList![0]);
        }
        return true;
      }
      final chanper = detailViewModel?.detailState.detailBookEntry
          ?.chapter?[getReadIndex(readState.chapterList![0]) - 1];
      final data = await _initData(detailUrl: chanper?.chapterUrl ?? "");
      if (data != null) {
        readState.chapterList?.removeAt(2);
        readState.chapterList?.insert(0, chanper ?? Chapter());
        readState.listContent?.removeAt(2);
        readState.listContent?.insert(0, data);
        LoggerTools.looger.i("===================");
        //state = AsyncData(readState);
        setReadIndex(readState.chapterList![1]);
      }
      return false;
    } catch (e) {
      LoggerTools.looger.e("NewSearchViewModel _initData error:$e");
      return false;
    }
  }

  void _initListData({
    required List<Chapter>? chapterList,
  }) async {
    try {
      if (chapterList == null) {
        LoggerTools.looger.d("chapterList 空的哇 就不执行后面的代码了");
        return;
      }
      final List<String> strList = [];
      for (var i = 0; i < chapterList.length; i++) {
        await Future.delayed(Durations.long3);
        final data = await _initDataAll(
            detailUrl: chapterList[i].chapterUrl ?? "", str: "");
        strList.add(data);
      }
      if (strList.isEmpty) {
        // readState.netState = NetState.emptyDataState;
        // state = AsyncData(readState);
        LoggerTools.looger.d("空的哇");
        return;
      }
      readState.netState = NetState.dataSuccessState;
      readState.listContent = strList;
      state = AsyncData(readState);
      LoggerTools.looger.d(strList.toString());
      final time = DateTime.now();
      String dateTime = "${time.month}-${time.day} ${time.hour}:${time.minute}";

      /// 存储历史记录
      await PreferencesDB.instance.setHistory(HistoryEntry(
          searchEntry: _searchEntry,
          chapter: chapter,
          dateTime: dateTime)); //jsonEncode()
    } catch (e) {
      LoggerTools.looger.e("NewSearchViewModel _initData error:$e");
      // searchState.netState = NetState.error403State;
      // state = AsyncData(searchState);
      SmartDialog.showToast(e.toString());
    }
  }

  Future<String> _initDataAll({
    required String detailUrl,
    required String str,
  }) async {
    try {
      final resultData = await NewNovelHttp().request(detailUrl);
      final uint8List = resultData.data;
      resultData.data = ParseSourceRule.parseHtmlDecode(uint8List);
      final detailBook = ParseSourceRule.parseAllMatches(
          rule: _bookSourceEntry.ruleContent?.content ?? "",
          htmlData: resultData.data);
      final detailNextBook = ParseSourceRule.parseAllMatches(
          rule: _bookSourceEntry.ruleContent?.nextContentUrl ?? "",
          htmlData: resultData.data);

      final url =
          _getChapterList(_bookSourceEntry.bookSourceUrl ?? "", detailNextBook);

      str += detailBook[0] ?? "";
      //LoggerTools.looger.d(str);
      if (url.isEmpty) {
        return str;
      }
      if (detailNextBook.isEmpty || detailNextBook.length > 2) {
        return str;
      }
      return await _initDataAll(detailUrl: url[0] ?? "", str: str);
    } catch (e) {
      LoggerTools.looger.e("NewSearchViewModel _initData error:$e");
      // searchState.netState = NetState.error403State;
      // state = AsyncData(searchState);
      SmartDialog.showToast(e.toString());
      return "error";
    }
  }

  List<String?> _getChapterList(String url, List<String?> list) {
    List<String> resultList = [];
    for (var i = 0; i < list.length; i++) {
      if (list[i]!.startsWith("https://") || list[i]!.startsWith("http://")) {
        return list;
      } else {
        if (!list[i]!.startsWith("/")) {
          // 去除baseUrl末尾的斜杠（如果有）
          if (url.endsWith('/')) {
            url = url.substring(0, url.length - 1);
          }
          // 如果relativeUrl以斜杠开头，则去除
          if (list[i]!.startsWith('/')) {
            list[i] = list[i]!.substring(1);
          }

          if (list[i]!.contains("javascript:Next")) {
            final map = extractChapterInfo(list[i]!);
            final url1 = "${map['chapterId']}/${map['htmlFileName']}";
            if (list.length > i) {
              url = "$url/read/$url1";
              resultList.add(url);
              continue;
            }
          }
          resultList.add("$url/${list[i] ?? ""}");
        } else {
          // 去除baseUrl末尾的斜杠（如果有）
          if (url.endsWith('/')) {
            url = url.substring(0, url.length - 1);
          }
          // 如果relativeUrl以斜杠开头，则去除
          if (list[i]!.startsWith('/')) {
            list[i] = list[i]!.substring(1);
          }

          resultList.add("$url/${list[i] ?? ""}");
        }
      }
    }
    return resultList;
  }

  Map<String, String> extractChapterInfo(String input) {
    // 定义正则表达式
    var regex =
        RegExp("Next\\(\\'(\\d+)\\',\\'(.+?)\\'\\)", caseSensitive: false);
    // 使用正则表达式匹配输入字符串
    final Match? match = regex.firstMatch(input);

    if (match != null && match.groupCount == 2) {
      // 如果匹配成功，提取章节编号和HTML文件名
      return {'chapterId': match.group(1)!, 'htmlFileName': match.group(2)!};
    } else {
      // 如果没有匹配到，返回空的Map
      return {};
    }
  }

  /// 设置阅读索引
  setReadIndex(Chapter data, {bool isToReadPage = false}) async {
    chapter = data;
    LoggerTools.looger.d("setReadIndex : ${data.toJson().toString()}");

    /// 保存阅读记录
    await PreferencesDB.instance.sps.setString(
        detailViewModel?.detailUrl ?? "", json.encode(data)); //jsonEncode()
    if (isToReadPage) {
      return;
    }
    final time = DateTime.now();
    String dateTime = "${time.month}-${time.day} ${time.hour}:${time.minute}";

    /// 存储历史记录
    await PreferencesDB.instance.setHistory(HistoryEntry(
        searchEntry: _searchEntry, chapter: chapter, dateTime: dateTime));
  }

  void buildBackgroundImage({bool isSh = false}) async {
    if (isSh ||
        await PreferencesDB.instance.getBackgroundImageState() &&
            readState.backgroundImage == null) {
      final data = await PreferencesDB.instance.getBackgroundImage();
      if (data != null) {
        readState.backgroundImage = data;
        if (isSh) {
          state = AsyncData(readState);
        }
      }
    }
  }

  void deleteBackgroundImage() {
    readState.backgroundImage = null;
    PreferencesDB.instance.setBackgroundImageState(false);
    state = AsyncData(readState);
  }
}
