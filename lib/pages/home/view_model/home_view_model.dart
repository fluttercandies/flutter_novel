import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/base/base_view_model.dart';
import 'package:novel_flutter_bit/net/http_config.dart';
import 'package:novel_flutter_bit/net/net_state.dart';
import 'package:novel_flutter_bit/net/novel_http.dart';
import 'package:novel_flutter_bit/net/service_result.dart';
import 'package:novel_flutter_bit/pages/home/entry/novel_hot_entry.dart';
import 'package:novel_flutter_bit/pages/home/state/home_state.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel implements BaseViewModelImplements {
  /// 创建state
  HomeState homeState = HomeState();

  bool _isInit = false;

  @override
  Future<bool> onRefresh() async {
    LoggerTools.looger.d("首页 onRefresh Vlaue : ${homeState.netState}");
    _initData();
    await Future.delayed(const Duration(seconds: 1));
    LoggerTools.looger.d("首页 onRefresh Vlaue : ${homeState.netState}");
    // bool value = homeState.netState == NetState.dataSuccessState;
    return true;
  }

  @override
  Future<HomeState> build() async {
    LoggerTools.looger.d("HomeViewModel init build");
    if (!_isInit) {
      _initData();
      _isInit = true;
    }
    return homeState;
  }

  void _initData() async {
    homeState.netState = NetState.loadingState;
    ServiceResultData resultData = await NovelHttp()
        .request('hot', params: {'category': '全部'}, method: HttpConfig.get);
    LoggerTools.looger.d(resultData.success);
    if (resultData.data case null) {
      /// 没有更多数据了
      homeState.netState = NetState.emptyDataState;
      state = AsyncData(homeState);
      return;
    }
    homeState.netState = NetStateTools.handle(resultData);
    if (homeState.netState == NetState.dataSuccessState) {
      NovelHot novelHot = NovelHot.fromJson(resultData.data);
      if (novelHot.data case null) {
        homeState.netState = NetState.emptyDataState;
      }

      /// 赋值
      homeState.novelHot = novelHot;
      LoggerTools.looger.i(homeState.netState);
      state = AsyncData(homeState);
    }
  }
}
