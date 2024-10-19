import 'dart:convert';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/db/preferences_db.dart';
import 'package:novel_flutter_bit/entry/book_source_entry.dart';
import 'package:novel_flutter_bit/n_pages/detail/entry/detail_book_entry.dart';
import 'package:novel_flutter_bit/n_pages/detail/state/detail_state.dart';
import 'package:novel_flutter_bit/net/new_novel_http.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:novel_flutter_bit/tools/parse_source_rule.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'detail_view_model.g.dart';

/// 详情搜索
/// 时间 2024-10-1
/// 7-bit
@riverpod
class NewDetailViewModel extends _$NewDetailViewModel {
  /// 书源
  late BookSourceEntry bookSourceEntry;

  final DetailState detailState = DetailState();

  /// 排序顺序
  late bool reverse = false;

  /// 阅读索引
  late Chapter chapter = Chapter();
  late String _url;
  @override
  Future<DetailState> build({
    required String detailUrl,
    required BookSourceEntry bookSource,
  }) async {
    LoggerTools.looger.d("NEW NewDetailViewModel init build");
    _url = detailUrl;
    init();
    bookSourceEntry = bookSource;
    _initData(detailUrl: detailUrl);

    return detailState;
  }

  void _initData({
    required String detailUrl,
  }) async {
    try {
      final resultData = await NewNovelHttp().request(detailUrl);
      final uint8List = resultData.data;
      resultData.data = ParseSourceRule.parseHtmlDecode(uint8List);
      final detailBook = _getSearchList(resultData.data);
      if (detailBook == null) {
        detailState.netState = NetState.emptyDataState;
        state = AsyncData(detailState);
        return;
      }
      detailState.detailBookEntry = detailBook;
      detailState.netState = NetState.dataSuccessState;
      initReverse();
      LoggerTools.looger.d(detailBook.toString());
    } catch (e) {
      LoggerTools.looger.e("NewSearchViewModel _initData error:$e");
      detailState.netState = NetState.error403State;
      // state = AsyncData(searchState);
      SmartDialog.showToast(e.toString());
    } finally {
      state = AsyncData(detailState);
    }
  }

  /// 搜索列表
  /// 搜索结果 解析后i获取
  DetailBookEntry? _getSearchList(String htmlData) {
    try {
      /// 作者
      var author = ParseSourceRule.parseAllMatches(
          rule: bookSourceEntry.ruleBookInfo!.author ?? "", htmlData: htmlData);

      /// url
      var coverUrl = ParseSourceRule.parseAllMatches(
          rule: bookSourceEntry.ruleBookInfo!.coverUrl ?? "",
          htmlData: htmlData);
      final url =
          _getChapterList(detailUrl, bookSource.bookSourceUrl ?? "", coverUrl);
      coverUrl = url;

      /// 介绍
      var intro = ParseSourceRule.parseAllMatches(
          rule: bookSourceEntry.ruleBookInfo!.intro ?? "", htmlData: htmlData);

      /// 最新章节
      var lastChapter = ParseSourceRule.parseAllMatches(
          rule: bookSourceEntry.ruleBookInfo!.lastChapter ?? "",
          htmlData: htmlData);

      /// 书名
      var name = ParseSourceRule.parseAllMatches(
          rule: bookSourceEntry.ruleBookInfo!.name ?? "", htmlData: htmlData);

      /// 章节列表
      var chapterList = ParseSourceRule.parseAllMatches(
          rootSelector: bookSourceEntry.ruleToc!.chapterList ?? "",
          rule: bookSourceEntry.ruleToc!.chapterUrl ?? "",
          htmlData: htmlData);

      chapterList = _getChapterList(
          detailUrl, bookSource.bookSourceUrl ?? "", chapterList);

      /// 章节列表
      var chapterName = ParseSourceRule.parseAllMatches(
          rootSelector: bookSourceEntry.ruleToc!.chapterList ?? "",
          rule: bookSourceEntry.ruleToc!.chapterName ?? "",
          htmlData: htmlData);

      List<Chapter> chapter = [];
      for (var i = 0; i < chapterList.length - chapterName.length; i++) {
        chapterName.insert(0, "开始阅读");
      }
      for (var i = 0; i < chapterList.length; i++) {
        final name = chapterName[i]?.replaceAll("\n", " ");
        chapter.add(Chapter(chapterUrl: chapterList[i], chapterName: name));
      }
      final detailAuthor = author.isNotEmpty ? author[0] : "";

      List<Chapter> uniqueList = [];
      Set<String> seenUrls = {}; // 用于记录已经出现过的 chapterUrl

      for (int i = chapter.length - 1; i >= 0; i--) {
        Chapter item = chapter[i];
        // 如果 seenUrls 中不包含当前的 chapterUrl，说明是第一次遇到该 url
        if (!seenUrls.contains(item.chapterUrl?.trim().toLowerCase())) {
          seenUrls.add(item.chapterUrl!.trim().toLowerCase());
          uniqueList.add(item);
        }
      }

      // 由于是从后往前添加的，需要再反转一次列表
      uniqueList = uniqueList.reversed.toList();

      DetailBookEntry detailBookEntry = DetailBookEntry(
        author: detailAuthor?.replaceAll("\n", " "),
        coverUrl: coverUrl.isNotEmpty ? coverUrl[0] : "暂无",
        intro: intro.isNotEmpty ? intro[0] : "暂无",
        lastChapter: lastChapter.isNotEmpty ? lastChapter[0] : "暂无",
        name: name.isNotEmpty ? name[0] : "暂无",
        chapter: uniqueList,
      );
      return detailBookEntry;
    } catch (e) {
      LoggerTools.looger.e("NewDetailViewModel _getSearchList error:$e");
      return null;
    }
  }

  List<String?> _getChapterList(String url, String url1, List<String?> list) {
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

          if (list[i]!.contains("javascript:Chapter")) {
            final map = extractChapterInfo(list[i]!);
            url = "${map['chapterId']}/${map['htmlFileName']}";
            if (list.length > i) {
              final uri = list[i - 1] ?? "";
              final split = uri.split("/");
              url = "${split[0]}/$url";
              resultList.add("$url1/$url");
              continue;
            }
          }
          resultList.add("$url/${list[i] ?? ""}");
        } else {
          // 去除baseUrl末尾的斜杠（如果有）
          if (url1.endsWith('/')) {
            url1 = url1.substring(0, url1.length - 1);
          }
          // 如果relativeUrl以斜杠开头，则去除
          if (list[i]!.startsWith('/')) {
            list[i] = list[i]!.substring(1);
          }

          resultList.add("$url1/${list[i] ?? ""}");
        }
      }
    }
    return resultList;
  }

  /// 排序
  initReverse() {
    var data = detailState.detailBookEntry?.chapter?.reversed.toList();
    detailState.detailBookEntry?.resetChapter = data;
    //state = AsyncData(detailState);
  }

  onReverse() {
    reverse = !reverse;
  }

  Map<String, String> extractChapterInfo(String input) {
    // 定义正则表达式
    var regex =
        RegExp("Chapter\\(\\'(\\d+)\\',\\'(.+?)\\'\\)", caseSensitive: false);
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
  setReadIndex(Chapter data) async {
    chapter = data;
    LoggerTools.looger.d("setReadIndex : ${data.toJson().toString()}");
    await PreferencesDB.instance.sps
        .setString(_url, json.encode(data)); //jsonEncode()
    state = AsyncData(detailState);
  }

  /// 获取阅读索引
  int getReadIndex() {
    for (var i = 0;
        i < (detailState.detailBookEntry?.chapter?.length ?? 0);
        i++) {
      var element = detailState.detailBookEntry?.chapter?[i].chapterName;
      if (element == chapter.chapterName) {
        return i;
      }
    }
    return 0;
  }

  /// 初始化 坐标
  Future<Chapter?> init() async {
    String? str = await PreferencesDB.instance.sps.getString(_url);
    if (str case String st?) {
      var data = json.decode(st);
      chapter = Chapter.fromJson(data);
      return chapter;
    }
    return null;
  }
}
