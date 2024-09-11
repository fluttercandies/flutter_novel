import 'dart:convert';

import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/base/base_view_model.dart';
import 'package:novel_flutter_bit/net/http_config.dart';
import 'package:novel_flutter_bit/net/net_state.dart';
import 'package:novel_flutter_bit/net/novel_http.dart';
import 'package:novel_flutter_bit/net/service_result.dart';
import 'package:novel_flutter_bit/pages/detail_novel/entry/detail_entry.dart';
import 'package:novel_flutter_bit/pages/detail_novel/state/detail_state.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailViewModel extends BaseViewModel {
  final String url;

  /// 创建state
  DetailState detailState = DetailState();

  /// 阅读索引
  late ListElement strUrl = ListElement();

  /// 排序顺序
  late bool reverse = false;

  /// 存储实例
  late Future<SharedPreferences> prefs;

  DetailViewModel(this.url) {
    LoggerTools.looger.d("HomeViewModel init $url");
    // Obtain shared preferences.
    prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      _init(value);
    });
  }

  /// 初始化 坐标
  _init(SharedPreferences value) {
    String? str = value.getString(url);
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
    notifyListeners();
  }

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

  /// 设置阅读索引
  setReadIndex(ListElement data) async {
    strUrl = data;
    LoggerTools.looger.d("setReadIndex : ${data.toJson().toString()}");
    await prefs.then((value) async {
      await value.setString(url, json.encode(data)); //jsonEncode()
    });
    notifyListeners();
  }

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
