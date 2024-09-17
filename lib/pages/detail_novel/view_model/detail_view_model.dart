import 'dart:convert';

import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/net/http_config.dart';
import 'package:novel_flutter_bit/net/net_state.dart';
import 'package:novel_flutter_bit/net/novel_http.dart';
import 'package:novel_flutter_bit/net/service_result.dart';
import 'package:novel_flutter_bit/pages/detail_novel/entry/detail_entry.dart';
import 'package:novel_flutter_bit/pages/detail_novel/state/detail_state.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:novel_flutter_bit/tools/shared_preferences_novle.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'detail_view_model.g.dart';

@riverpod
class DetailViewModel extends _$DetailViewModel {
  late String url;

  /// 创建state
  DetailState detailState = DetailState();

  /// 阅读索引
  late ListElement strUrl = ListElement();

  /// 排序顺序
  late bool reverse = false;

  late bool isInit = false;

  // DetailViewModel(this.url) {
  //   LoggerTools.looger.d("HomeViewModel init $url");
  //   // Obtain shared preferences.
  //   prefs = SharedPreferences.getInstance();
  //   prefs.then((value) {
  //     _init(value);
  //   });
  // }
  changeNovelDta(ListElement data) {
    setReadIndex(data);
  }

  @override
  Future<DetailState> build({required String urlBook}) async {
    LoggerTools.looger.d("DetailViewModel build Vlaue : $urlBook");
    url = urlBook;
    if (!isInit) {
      _init();
    }
    getData();
    return detailState;
  }

  /// 初始化 坐标
  _init() {
    String? str = SharedPreferencesNovle.prefs.getString(url);
    if (str case String st?) {
      var data = json.decode(st);
      strUrl = ListElement.fromJson(data);
    }
  }

  /// 排序
  onReverse() {
    var data = detailState.detailNovel?.data?.list?.reversed.toList();
    detailState.detailNovel?.data?.list = data;
    reverse = !reverse;
    state = AsyncData(detailState);
  }

  void getData() async {
    detailState.netState = NetState.loadingState;
    ServiceResultData resultData =
        await NovelHttp().request(url, method: HttpConfig.get);
    LoggerTools.looger.d(resultData.success);
    if (resultData.data case null) {
      /// 没有更多数据了
      detailState.netState = NetState.emptyDataState;
      state = AsyncData(detailState);
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
      LoggerTools.looger.i(detailState.detailNovel);
      state = AsyncData(detailState);
    }
  }

  /// 设置阅读索引
  setReadIndex(ListElement data) async {
    strUrl = data;
    LoggerTools.looger.d("setReadIndex : ${data.toJson().toString()}");
    await SharedPreferencesNovle.prefs
        .setString(url, json.encode(data)); //jsonEncode()
    state = AsyncData(detailState);
  }

  /// 获取阅读索引
  int getReadIndex() {
    for (var i = 0;
        i < (detailState.detailNovel?.data?.list?.length ?? 0);
        i++) {
      var element = detailState.detailNovel?.data?.list?[i].name;
      if (element == strUrl.name) {
        return i;
      }
    }
    return 0;
  }
}
