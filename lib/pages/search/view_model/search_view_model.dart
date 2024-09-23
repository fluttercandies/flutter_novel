import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/net/http_config.dart';
import 'package:novel_flutter_bit/net/net_state.dart';
import 'package:novel_flutter_bit/net/novel_http.dart';
import 'package:novel_flutter_bit/net/service_result.dart';
import 'package:novel_flutter_bit/pages/search/entry/search_entry.dart';
import 'package:novel_flutter_bit/pages/search/state/search_state.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'search_view_model.g.dart';

@riverpod
class SearchViewModel extends _$SearchViewModel {
  /// 创建state
  SearchState homeState = SearchState();

  @override
  Future<SearchState> build({required String bookName}) async {
    LoggerTools.looger.d("SearchViewModel init build  搜索的书名：$bookName");
    _initData(name: bookName);
    return homeState;
  }

  void _initData({required String name}) async {
    homeState.netState = NetState.loadingState;
    ServiceResultData resultData = await NovelHttp()
        .request('search', params: {'keyword': name}, method: HttpConfig.get);
    LoggerTools.looger.d(resultData.success);
    if (resultData.data == null || resultData.data['data'] == null) {
      /// 没有更多数据了
      homeState.netState = NetState.emptyDataState;
      state = AsyncData(homeState);
      return;
    }
    homeState.netState = NetStateTools.handle(resultData);
    if (homeState.netState == NetState.dataSuccessState) {
      SearchEntry searchEntry = SearchEntry.fromJson(resultData.data);
      if (searchEntry.data case null) {
        homeState.netState = NetState.emptyDataState;
      }

      /// 赋值
      homeState.searchEntry = searchEntry;
      LoggerTools.looger.i(homeState.netState);
      state = AsyncData(homeState);
    }
  }
}
