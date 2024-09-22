import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/widget/403_state.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/loading.dart';

///  网络状态工具
class NetStateTools {
  static Widget? getWidget(NetState netState) {
    switch (netState) {
      case NetState.loadingState:
        return const LoadingBuild();
      case NetState.error404State:
        return const EmptyBuild();
      case NetState.error403State:
        return const Build403();
      case NetState.errorShowRefresh:
        return const EmptyBuild();
      case NetState.emptyDataState:
        return const EmptyBuild();
      case NetState.timeOutState:
        return const EmptyBuild();
      case NetState.unknown:
        return const EmptyBuild();
      default:
        return null;
    }
  }
}
