import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BaseViewModel extends ChangeNotifier {
  /// 列表控制器
  final ScrollController scrollController = ScrollController();

  /// 刷新组建控制器
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
}
