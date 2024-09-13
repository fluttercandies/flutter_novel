import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/net/http_config.dart';
import 'package:novel_flutter_bit/net/net_state.dart';
import 'package:novel_flutter_bit/net/novel_http.dart';
import 'package:novel_flutter_bit/net/service_result.dart';
import 'package:novel_flutter_bit/pages/novel/entry/novel.dart';
import 'package:novel_flutter_bit/pages/novel/state/novel_state.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'novel_view_model.g.dart';

@riverpod
class NovelViewModel extends _$NovelViewModel {
  /// 创建state
  NovelState novelState = NovelState();

  /// url
  late String url;

  @override
  Future<NovelState> build({required String urlNovel}) async {
    LoggerTools.looger.d("novel阅读 build Vlaue : $urlNovel");
    url = urlNovel;
    getData();
    return novelState;
  }

  void getData() async {
    novelState.netState = NetState.loadingState;
    ServiceResultData resultData =
        await NovelHttp().request(url, params: {}, method: HttpConfig.get);
    LoggerTools.looger.d(resultData.success);
    if (resultData.data case null) {
      /// 没有更多数据了
      novelState.netState = NetState.emptyDataState;
      state = AsyncData(novelState);
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
      LoggerTools.looger.i(novelState.novelEntry);
      state = AsyncData(novelState);
    }
  }
}
