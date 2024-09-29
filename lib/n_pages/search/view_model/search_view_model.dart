import 'dart:convert';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:novel_flutter_bit/entry/book_source_entry.dart';
import 'package:novel_flutter_bit/net/new_novel_http.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:novel_flutter_bit/tools/parse_source_rule.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_gbk2utf8/flutter_gbk2utf8.dart';
part 'search_view_model.g.dart';

@riverpod
class NewSearchViewModel extends _$NewSearchViewModel {
  @override
  Future<void> build(
      {required String searchKey,
      required BookSourceEntry bookSourceEntry}) async {
    LoggerTools.looger.d("NEW HomeViewModel init build");
    _initData(searchKey: searchKey, bookSourceEntry: bookSourceEntry);
  }

  void _initData({
    required String searchKey,
    required BookSourceEntry bookSourceEntry,
  }) async {
    final resultData = await NewNovelHttp().request(
        "${bookSourceEntry.bookSourceUrl}${ParseSourceRule.parseSearchUrl(searchKey: searchKey, searchUrl: bookSourceEntry.searchUrl ?? "")}");
    resultData.data = gbk.decode(resultData.data);
    final data = ParseSourceRule.parseAllMatches(
        rule: bookSourceEntry.ruleSearch!.author!, htmlData: resultData.data);
    final data1 = ParseSourceRule.parseAllMatches(
        rule: bookSourceEntry.ruleSearch!.bookUrl!, htmlData: resultData.data);
    final data2 = ParseSourceRule.parseAllMatches(
        rule: bookSourceEntry.ruleSearch!.bookList!, htmlData: resultData.data);
    final data3 = ParseSourceRule.parseAllMatches(
        rule: bookSourceEntry.ruleSearch!.coverUrl!, htmlData: resultData.data);
    final data4 = ParseSourceRule.parseAllMatches(
        rule: bookSourceEntry.ruleSearch!.lastChapter!,
        htmlData: resultData.data);
    final data5 = ParseSourceRule.parseAllMatches(
        rule: bookSourceEntry.ruleSearch!.name!, htmlData: resultData.data);
    LoggerTools.looger.d(data.toString());
    LoggerTools.looger.d(data1.toString());
    LoggerTools.looger.d(data2.toString());
    LoggerTools.looger.d(data3.toString());
    LoggerTools.looger.d(data4.toString());
    LoggerTools.looger.d(data5.toString());
  }
}
