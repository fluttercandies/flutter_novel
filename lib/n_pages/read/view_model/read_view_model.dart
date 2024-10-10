// ignore_for_file: control_flow_in_finally

import 'dart:convert';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/db/preferences_db.dart';
import 'package:novel_flutter_bit/entry/book_source_entry.dart';
import 'package:novel_flutter_bit/n_pages/detail/entry/detail_book_entry.dart';
import 'package:novel_flutter_bit/n_pages/detail/state/detail_state.dart';
import 'package:novel_flutter_bit/n_pages/read/state/read_state.dart';
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

  @override
  Future<ReadState> build({
    required Chapter chapter1,
    required BookSourceEntry bookSource,
  }) async {
    LoggerTools.looger.d("NEW NewDetailViewModel init build");
    chapter = chapter1;
    _bookSourceEntry = bookSource;
    _initData(detailUrl: chapter1.chapterUrl ?? "");
    return readState;
  }

  void _initData({
    required String detailUrl,
  }) async {
    try {
      final data = await _initDataAll(detailUrl: detailUrl, str: "");
      if (data == "") {
        readState.netState = NetState.emptyDataState;
        state = AsyncData(readState);
        return;
      }
      readState.netState = NetState.dataSuccessState;
      readState.content = data;
      state = AsyncData(readState);
      // LoggerTools.looger.d(data);
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
      LoggerTools.looger.d(str);
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
}
