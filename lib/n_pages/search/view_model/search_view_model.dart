import 'dart:convert';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/entry/book_source_entry.dart';
import 'package:novel_flutter_bit/n_pages/search/entry/search_entry.dart';
import 'package:novel_flutter_bit/n_pages/search/state/search_state.dart';
import 'package:novel_flutter_bit/net/new_novel_http.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:novel_flutter_bit/tools/parse_source_rule.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_gbk2utf8/flutter_gbk2utf8.dart';
part 'search_view_model.g.dart';

/// 搜索页
/// 时间 2024-9-29
/// 7-bit
@riverpod
class NewSearchViewModel extends _$NewSearchViewModel {
  SearchState searchState = SearchState();
  @override
  Future<SearchState> build(
      {required String searchKey,
      required BookSourceEntry bookSourceEntry}) async {
    LoggerTools.looger.d("NEW HomeViewModel init build");
    _initData(searchKey: searchKey, bookSourceEntry: bookSourceEntry);
    return searchState;
  }

  void _initData({
    required String searchKey,
    required BookSourceEntry bookSourceEntry,
  }) async {
    final resultData = await NewNovelHttp().request(
        "${bookSourceEntry.bookSourceUrl}${ParseSourceRule.parseSearchUrl(searchKey: searchKey, searchUrl: bookSourceEntry.searchUrl ?? "")}");
    resultData.data = gbk.decode(resultData.data);
    final searchLis = _getSearchList(resultData.data);
    if (searchLis.isEmpty) {
      searchState.netState = NetState.emptyDataState;
      return;
    }
    searchState.searchList = searchLis;
    searchState.netState = NetState.dataSuccessState;
    state = AsyncData(searchState);
  }

  /// 搜索列表
  /// 搜索结果 解析后i获取
  List<SearchEntry> _getSearchList(String htmlData) {
    List<SearchEntry> searchList = [];

    /// 作者
    final author = ParseSourceRule.parseAllMatches(
        rule: bookSourceEntry.ruleSearch!.author!, htmlData: htmlData);

    /// 书url
    final bookUrl = ParseSourceRule.parseAllMatches(
        rule: bookSourceEntry.ruleSearch!.bookUrl!, htmlData: htmlData);

    /// 所有信息
    final bookAll = ParseSourceRule.parseAllMatches(
        rule: bookSourceEntry.ruleSearch!.bookList!, htmlData: htmlData);

    /// name 书名
    // final data3 = ParseSourceRule.parseAllMatches(
    //     rule: bookSourceEntry.ruleSearch!.coverUrl!, htmlData: htmlData);
    /// lastChapter 最新章节
    final lastChapter = ParseSourceRule.parseAllMatches(
        rule: bookSourceEntry.ruleSearch!.lastChapter!, htmlData: htmlData);

    /// name 书名
    final name = ParseSourceRule.parseAllMatches(
        rule: bookSourceEntry.ruleSearch!.name!, htmlData: htmlData);

    for (var i = 0; i < bookUrl.length; i++) {
      final searchEntry = SearchEntry(
        author: author[i],
        url: bookUrl[i],
        name: name[i],
        lastChapter: lastChapter[i],
        bookAll: bookAll[i],
      );
      searchList.add(searchEntry);
    }
    return searchList;
  }
}
