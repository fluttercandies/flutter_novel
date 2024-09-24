import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/db/preferences_db.dart';
import 'package:novel_flutter_bit/pages/collect_novle/state/collect_state.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'collect_view_model.g.dart';

@riverpod
class CollectViewModel extends _$CollectViewModel {
  /// 创建state
  CollectState collectState = CollectState();

  @override
  Future<CollectState> build() async {
    LoggerTools.looger.d("CollectViewModel build");
    getData();
    return collectState;
  }

  void getData() async {
    collectState.netState = NetState.loadingState;

    final data = await PreferencesDB.instance.getCollectNovelList();
    if (data.isEmpty) {
      /// 没有更多数据了
      collectState.netState = NetState.emptyDataState;
      state = AsyncData(collectState);
      return;
    }

    /// 赋值
    collectState.collectNovelList = data;
    LoggerTools.looger.i(collectState.collectNovelList);
    state = AsyncData(collectState);
  }
}
