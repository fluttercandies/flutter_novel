import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/base/base_view_model.dart';
import 'package:novel_flutter_bit/db/preferences_db.dart';
import 'package:novel_flutter_bit/n_pages/history/state/history_state.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'history_view_model.g.dart';

/// 收藏
/// 时间 2024-10-18
/// 7-bit
@riverpod
class HistoryViewModel extends _$HistoryViewModel
    implements BaseViewModelImplements {
  HistoryState historyState = HistoryState();
  @override
  Future<HistoryState> build() async {
    LoggerTools.looger.d("LikeViewModel init build");
    _initData();
    return historyState;
  }

  /// 初始化数据
  _initData() async {
    try {
      final data = await PreferencesDB.instance.getHistoryList();
      if (data.isEmpty) {
        historyState.netState = NetState.emptyDataState;
        return;
      }
      historyState.historyList = data;
      historyState.netState = NetState.dataSuccessState;
    } catch (e) {
      LoggerTools.looger.e("LikeViewModel _initData error: $e");
      historyState.netState = NetState.error504State;
    } finally {
      state = AsyncData(historyState);
    }
  }

  @override
  Future<bool> onRefresh() async {
    _initData();
    await Future.delayed(Durations.extralong4);
    return true;
  }
}
