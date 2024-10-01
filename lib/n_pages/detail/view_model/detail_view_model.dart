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
  }) async {
    LoggerTools.looger.d("NEW NewDetailViewModel init build");
    _initBookSourceEntry();
    _initData(detailUrl: detailUrl);
    // _bookSourceEntry = bookSourceEntry;
    // _initData(searchKey: searchKey, bookSourceEntry: bookSourceEntry);
  }

  /// 初始化书源
  _initBookSourceEntry() async {
    final homeViewModel = ref.read(homeViewModelProvider.notifier);
    _bookSourceEntry = homeViewModel
        .homeState.sourceEntry![homeViewModel.homeState.currentIndex];
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
    }
  }

  /// 搜索列表
  /// 搜索结果 解析后i获取
  String _getSearchList(String htmlData) {
    /// 作者
    var lastChapter = ParseSourceRule.parseAllMatches(
        rule: _bookSourceEntry.ruleBookInfo!.kind ?? "", htmlData: htmlData);

    return lastChapter.toString();
  }
}
