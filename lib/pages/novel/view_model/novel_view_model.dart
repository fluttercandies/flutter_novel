import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/base/base_view_model.dart';
import 'package:novel_flutter_bit/net/http_config.dart';
import 'package:novel_flutter_bit/net/net_state.dart';
import 'package:novel_flutter_bit/net/novel_http.dart';
import 'package:novel_flutter_bit/net/service_result.dart';
import 'package:novel_flutter_bit/pages/novel/entry/novel.dart';
import 'package:novel_flutter_bit/pages/novel/state/novel_state.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';

class NovelViewModel extends BaseViewModel {
  /// 创建state
  NovelState novelState = NovelState();

  /// url
  final String url;
  NovelViewModel(this.url);
  void getData() async {
    novelState.netState = NetState.loadingState;
    ServiceResultData resultData =
        await NovelHttp().request(url, params: {}, method: HttpConfig.get);
    LoggerTools.looger.d(resultData.success);
    if (resultData.data case null) {
      /// 没有更多数据了
      novelState.netState = NetState.emptyDataState;
      notifyListeners();
      return;
    }
    novelState.netState = NetStateTools.handle(resultData);
    if (novelState.netState == NetState.dataSuccessState) {
      Novel novelHot = Novel.fromJson(resultData.data);
      if (novelHot.data case null) {
        novelState.netState = NetState.emptyDataState;
      }

      /// 赋值
      novelState.novelEntry = novelHot;
      LoggerTools.looger.d(novelState.novelEntry);
      notifyListeners();
    }
  }
}
