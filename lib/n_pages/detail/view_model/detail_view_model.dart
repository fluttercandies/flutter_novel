import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:novel_flutter_bit/entry/book_source_entry.dart';
import 'package:novel_flutter_bit/n_pages/home/view_model/home_view_model.dart';
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
  late BookSourceEntry _bookSourceEntry;
  @override
  Future<void> build({
    required String detailUrl,
    required BookSourceEntry bookSource,
  }) async {
    LoggerTools.looger.d("NEW NewDetailViewModel init build");
    _bookSourceEntry = bookSource;
    _initData(detailUrl: detailUrl);
    // _bookSourceEntry = bookSourceEntry;
    // _initData(searchKey: searchKey, bookSourceEntry: bookSourceEntry);
  }

  void _initData({
    required String detailUrl,
  }) async {
    try {
      final resultData = await NewNovelHttp().request(detailUrl);
      final uint8List = resultData.data;
      resultData.data = ParseSourceRule.parseHtmlDecode(uint8List);
      final searchLis = _getSearchList(resultData.data);
      // if (searchLis.isEmpty) {
      //   searchState.netState = NetState.emptyDataState;
      //   state = AsyncData(searchState);
      //   return;
      // }
      // searchState.searchList = searchLis;
      // searchState.netState = NetState.dataSuccessState;
      // state = AsyncData(searchState);
      LoggerTools.looger.d(searchLis.toString());
    } catch (e) {
      LoggerTools.looger.e("NewSearchViewModel _initData error:$e");
      // searchState.netState = NetState.error403State;
      // state = AsyncData(searchState);
      SmartDialog.showToast(e.toString());
    }
  }

  /// 搜索列表
  /// 搜索结果 解析后i获取
  String _getSearchList(String htmlData) {
    /// 作者
    var author = ParseSourceRule.parseAllMatches(
        rule: _bookSourceEntry.ruleBookInfo!.author ?? "", htmlData: htmlData);

    /// url
    var coverUrl = ParseSourceRule.parseAllMatches(
        rule: _bookSourceEntry.ruleBookInfo!.coverUrl ?? "",
        htmlData: htmlData);

    /// 介绍
    var intro = ParseSourceRule.parseAllMatches(
        rule: _bookSourceEntry.ruleBookInfo!.intro ?? "", htmlData: htmlData);

    /// 最新章节
    var lastChapter = ParseSourceRule.parseAllMatches(
        rule: _bookSourceEntry.ruleBookInfo!.lastChapter ?? "",
        htmlData: htmlData);

    /// 书名
    var name = ParseSourceRule.parseAllMatches(
        rule: _bookSourceEntry.ruleBookInfo!.name ?? "", htmlData: htmlData);

    /// 章节列表
    var chapterList = ParseSourceRule.parseAllMatches(
        rootSelector: _bookSourceEntry.ruleToc!.chapterList ?? "",
        rule: _bookSourceEntry.ruleToc!.chapterUrl ?? "",
        htmlData: htmlData);

    chapterList =
        _getChapterList(detailUrl, bookSource.bookSourceUrl ?? "", chapterList);

    /// 章节列表
    var chapterName = ParseSourceRule.parseAllMatches(
        rootSelector: _bookSourceEntry.ruleToc!.chapterList ?? "",
        rule: _bookSourceEntry.ruleToc!.chapterName ?? "",
        htmlData: htmlData);
    return author.toString();
  }

  List<String> _getChapterList(String url, String url1, List<String?> list) {
    List<String> resultList = [];
    for (var i = 0; i < list.length; i++) {
      if (!list[i]!.startsWith("/")) {
        // 去除baseUrl末尾的斜杠（如果有）
        if (url.endsWith('/')) {
          url = url.substring(0, url.length - 1);
        }
        // 如果relativeUrl以斜杠开头，则去除
        if (list[i]!.startsWith('/')) {
          list[i] = list[i]!.substring(1);
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
    return resultList;
  }
}
