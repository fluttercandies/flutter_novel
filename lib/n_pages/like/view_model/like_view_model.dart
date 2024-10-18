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

    return readState;
  }

  /// 初始化数据
  _initData() {}
}
