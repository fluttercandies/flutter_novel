import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/base/base_view_model.dart';
import 'package:novel_flutter_bit/net/http_config.dart';
import 'package:novel_flutter_bit/net/net_state.dart';
import 'package:novel_flutter_bit/net/novel_http.dart';
import 'package:novel_flutter_bit/net/service_result.dart';
import 'package:novel_flutter_bit/pages/detail_novel/entry/detail_entry.dart';
import 'package:novel_flutter_bit/pages/detail_novel/state/detail_state.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';

class DetailViewModel extends BaseViewModel {
  final String url;
  DetailViewModel(this.url);

  /// 创建state
  DetailState detailState = DetailState();
  late int readIndex = 0;
  @override
  Future<bool> onRefresh() async {
    LoggerTools.looger.d("首页 onRefresh Vlaue : ${detailState.netState}");
    getData();
    await Future.delayed(const Duration(seconds: 1));
    LoggerTools.looger.d("首页 onRefresh Vlaue : ${detailState.netState}");
    bool value = detailState.netState == NetState.dataSuccessState;
    return true;
  }

  void getData() async {
    detailState.netState = NetState.loadingState;
    ServiceResultData resultData =
        await NovelHttp().request(url, method: HttpConfig.get);
    LoggerTools.looger.d(resultData.success);
    if (resultData.data case null) {
      /// 没有更多数据了
      detailState.netState = NetState.emptyDataState;
      notifyListeners();
      return;
    }
    detailState.netState = NetStateTools.handle(resultData);
    if (detailState.netState == NetState.dataSuccessState) {
      DetailNovel novelHot = DetailNovel.fromJson(resultData.data);
      if (novelHot.data case null) {
        detailState.netState = NetState.emptyDataState;
      }

      /// 赋值
      detailState.detailNovel = novelHot;
      LoggerTools.looger.d(detailState.detailNovel);

      notifyListeners();
    }
  }
}
