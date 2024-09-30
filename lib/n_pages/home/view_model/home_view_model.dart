import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/entry/book_source_entry.dart';
import 'package:novel_flutter_bit/n_pages/home/state/home_state.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  /// 创建state
  HomeState homeState = HomeState();

  @override
  Future<HomeState> build() async {
    LoggerTools.looger.d("NEW HomeViewModel init build");
    _initData();
    return homeState;
  }

  void _initData() async {
    homeState.netState = NetState.loadingState;
    homeState.sourceEntry = await loadBookSourceEntry();
    homeState.netState = NetState.dataSuccessState;
    state = AsyncData(homeState);
  }

  /// 加载书籍源
  Future<List<BookSourceEntry>> loadBookSourceEntry() async {
    List<BookSourceEntry> bookList = [];
    final String jsonString =
        await rootBundle.loadString('assets/json/source.json');
    final List jsonList = json.decode(jsonString);
    for (var i = 0; i < jsonList.length; i++) {
      bookList.add(BookSourceEntry.fromJson(jsonList[i]));
    }
    return bookList;
  }

  void switchSource() {
    if (homeState.currentIndex + 1 >= (homeState.sourceEntry?.length ?? 0)) {
      homeState.currentIndex = 0;
    } else {
      homeState.currentIndex++;
    }

    //state = AsyncData(homeState);

    SmartDialog.showToast(
        "切换成功${homeState.sourceEntry?[homeState.currentIndex].bookSourceName}");
    LoggerTools.looger.d(
        "切换成功${homeState.sourceEntry?[homeState.currentIndex].bookSourceName}");
  }
}
