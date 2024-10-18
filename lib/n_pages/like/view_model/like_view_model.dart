import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/db/preferences_db.dart';
import 'package:novel_flutter_bit/n_pages/like/state/like_state.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'like_view_model.g.dart';

/// 收藏
/// 时间 2024-10-18
/// 7-bit
@riverpod
class LikeViewModel extends _$LikeViewModel {
  LikeState readState = LikeState();
  @override
  Future<LikeState> build() async {
    LoggerTools.looger.d("LikeViewModel init build");
    _initData();
    return readState;
  }

  /// 初始化数据
  _initData() async {
    try {
      final data = await PreferencesDB.instance.getLikeList();
      if (data.isEmpty) {
        readState.netState = NetState.emptyDataState;
        return;
      }
      readState.likeList = data;
      readState.netState = NetState.dataSuccessState;
    } catch (e) {
      LoggerTools.looger.e("LikeViewModel _initData error: $e");
      readState.netState = NetState.error504State;
    } finally {
      state = AsyncData(readState);
    }
  }
}
