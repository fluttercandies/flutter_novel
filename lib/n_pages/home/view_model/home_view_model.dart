import 'dart:convert';

import 'package:flutter/services.dart';
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
    state = AsyncData(homeState);
  }

  /// 加载书籍源
  Future<BookSourceEntry> loadBookSourceEntry() async {
    final String jsonString =
        await rootBundle.loadString('assets/json/source.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return BookSourceEntry.fromJson(jsonMap);
  }
}
