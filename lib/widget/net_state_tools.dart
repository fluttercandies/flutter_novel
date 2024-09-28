import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/widget/403_state.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/loading.dart';

///  网络状态工具
class NetStateTools {
  static Widget? getWidget(NetState netState, {String? msg}) {
    switch (netState) {
      case NetState.loadingState:
        return const LoadingBuild();
      case NetState.error404State:
        return EmptyBuild(text: msg);
      case NetState.error403State:
        return const Build403();
      case NetState.error504State:
        return const Build403();
      case NetState.errorShowRefresh:
        return EmptyBuild(text: msg);
      case NetState.emptyDataState:
        return EmptyBuild(text: msg);
      case NetState.timeOutState:
        return EmptyBuild(text: msg);
      case NetState.unknown:
        return EmptyBuild(text: msg);
      default:
        return null;
    }
  }
}
