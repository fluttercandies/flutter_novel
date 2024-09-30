import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/entry/book_source_entry.dart';
import 'package:novel_flutter_bit/n_pages/search/entry/search_entry.dart';
import 'package:novel_flutter_bit/n_pages/search/state/search_state.dart';
import 'package:novel_flutter_bit/net/new_novel_http.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:novel_flutter_bit/tools/parse_source_rule.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'search_view_model.g.dart';

/// 搜索页
/// 时间 2024-9-29
/// 7-bit
@riverpod
class NewSearchViewModel extends _$NewSearchViewModel {
  SearchState searchState = SearchState();
  late BookSourceEntry _bookSourceEntry;
  @override
  Future<SearchState> build(
      {required String searchKey,
      required BookSourceEntry bookSourceEntry}) async {
    LoggerTools.looger.d("NEW HomeViewModel init build");
    _bookSourceEntry = bookSourceEntry;
    _initData(searchKey: searchKey, bookSourceEntry: bookSourceEntry);
    return searchState;
  }

  void _initData({
    required String searchKey,
    required BookSourceEntry bookSourceEntry,
  }) async {
    final resultData = await NewNovelHttp().request(ParseSourceRule.parseUrl(
        bookSourceUrl: "${bookSourceEntry.bookSourceUrl}",
        parseSearchUrl: ParseSourceRule.parseSearchUrl(
            searchKey: searchKey, searchUrl: bookSourceEntry.searchUrl ?? "")));
    final uint8List = resultData.data;
    resultData.data = ParseSourceRule.parseHtmlDecode(uint8List);
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
    var author = ParseSourceRule.parseAllMatches(
        rootSelector: _bookSourceEntry.ruleSearch!.bookList ?? "",
        rule: _bookSourceEntry.ruleSearch!.author ?? "",
        htmlData: htmlData);

    /// 书url
    var bookUrl = ParseSourceRule.parseAllMatches(
        rootSelector: _bookSourceEntry.ruleSearch!.bookList ?? "",
        rule: _bookSourceEntry.ruleSearch!.bookUrl ?? "",
        htmlData: htmlData);

    /// 所有信息
    var bookAll = ParseSourceRule.parseAllMatches(
        //rootSelector: _bookSourceEntry.ruleSearch!.bookList ?? "",
        rule: _bookSourceEntry.ruleSearch!.bookList ?? "",
        htmlData: htmlData);

    /// name 书名
    // final data3 = ParseSourceRule.parseAllMatches(
    //     rule: bookSourceEntry.ruleSearch!.coverUrl!, htmlData: htmlData);
    /// lastChapter 最新章节
    var lastChapter = ParseSourceRule.parseAllMatches(
        rootSelector: _bookSourceEntry.ruleSearch!.bookList ?? "",
        rule: _bookSourceEntry.ruleSearch!.lastChapter ?? "",
        htmlData: htmlData);

    /// name 书名
    var name = ParseSourceRule.parseAllMatches(
        rule: _bookSourceEntry.ruleSearch!.name ?? "", htmlData: htmlData);

    /// 图片
    var coverUrl = ParseSourceRule.parseAllMatches(
        rootSelector: _bookSourceEntry.ruleSearch!.bookList ?? "",
        rule: _bookSourceEntry.ruleSearch!.coverUrl ?? "",
        htmlData: htmlData);

    /// 类型
    var kind = ParseSourceRule.parseAllMatches(
        rootSelector: _bookSourceEntry.ruleSearch!.bookList ?? "",
        rule: _bookSourceEntry.ruleSearch!.kind ?? "",
        htmlData: htmlData);
    // 如果 bookUrl 不为空，检查其他列表并调整长度
    // 如果 bookUrl 不为空，检查其他列表并调整长度
    if (bookUrl.isNotEmpty && bookUrl.any((url) => url != null)) {
      final length = bookUrl.length;

      // 确保其他列表不为空，如果为空则初始化为空数组
      author = author.isEmpty ? [] : author;
      bookAll = bookAll.isEmpty ? [] : bookAll;
      lastChapter = lastChapter.isEmpty ? [] : lastChapter;
      name = name.isEmpty ? [] : name;
      coverUrl = coverUrl.isEmpty ? [] : coverUrl;
      kind = kind.isEmpty ? [] : kind;
      // 补充空列表的长度
      author.length = author.isEmpty ? length : author.length;
      bookAll.length = bookAll.isEmpty ? length : bookAll.length;
      lastChapter.length = lastChapter.isEmpty ? length : lastChapter.length;
      name.length = name.isEmpty ? length : name.length;
      coverUrl.length = coverUrl.isEmpty ? length : coverUrl.length;
      kind.length = kind.isEmpty ? length : kind.length;

      author = List.generate(
          length, (index) => author.length > index ? author[index] : null);
      bookAll = List.generate(
          length, (index) => bookAll.length > index ? bookAll[index] : null);
      lastChapter = List.generate(length,
          (index) => lastChapter.length > index ? lastChapter[index] : null);
      name = List.generate(
          length, (index) => name.length > index ? name[index] : null);
      coverUrl = List.generate(
          length, (index) => coverUrl.length > index ? coverUrl[index] : null);
      kind = List.generate(
          length, (index) => kind.length > index ? kind[index] : null);
    }
    for (var i = 0; i < bookUrl.length; i++) {
      final bookurl =
          bookUrl[i]?.startsWith("http") ?? bookUrl[i] != "" ? true : false;
      final coverUrl1 =
          coverUrl[i]?.startsWith("http") ?? (coverUrl[i] != "") ? true : false;
      final coverUrlData = ParseSourceRule.parseUrl(
          bookSourceUrl: "${_bookSourceEntry.bookSourceUrl}",
          parseSearchUrl: coverUrl[i] ?? "");
      final bookUrlData = ParseSourceRule.parseUrl(
          bookSourceUrl: "${_bookSourceEntry.bookSourceUrl}",
          parseSearchUrl: bookUrl[i] ?? "");
      final searchEntry = SearchEntry(
          author: author[i],
          url: bookurl ? bookUrl[i] : bookUrlData,
          name: name[i],
          lastChapter: lastChapter[i],
          bookAll: bookAll[i],
          kind: kind[i],
          coverUrl: coverUrl1 ? coverUrl[i] : coverUrlData);
      searchList.add(searchEntry);
    }
    return searchList;
  }
}
