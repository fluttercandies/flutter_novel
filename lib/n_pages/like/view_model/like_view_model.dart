import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// 收藏
/// 时间 2024-10-18
/// 7-bit
@riverpod
class LikeViewModel extends _$LikeViewModel {
  @override
  Future<ReadState> build() async {
    LoggerTools.looger.d("LikeViewModel init build");
    _initListData();
    return readState;
  }
}
