import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/base/base_view_model.dart';
import 'package:novel_flutter_bit/net/http_config.dart';
import 'package:novel_flutter_bit/net/novel_http.dart';
import 'package:novel_flutter_bit/net/service_result.dart';
import 'package:novel_flutter_bit/pages/home/entry/novel_hot_entry.dart';
import 'package:novel_flutter_bit/pages/home/state/home_state.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';

class HomeViewModel extends BaseViewModel {
  /// 创建state
  HomeState homeState = HomeState();
  void getData() async {
    ServiceResultData resultData = await NovelHttp()
        .request('hot', params: {'category': '全部'}, method: HttpConfig.get);
    LoggerTools.looger.d(resultData.success);
    if (resultData.data case null) {
      /// 没有更多数据了
      refreshController.refreshCompleted();
      refreshController.loadComplete();
      refreshController.loadNoData();
      homeState.netState = NetState.emptyDataState;
      notifyListeners();
      return;
    }
    if (!resultData.success) {
      homeState.netState = NetState.error404State;
    }
    NovelHot novelHot = NovelHot.fromJson(resultData.data);
    LoggerTools.looger.d(novelHot);
  }
}
