import 'package:flutter/material.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

/// 下拉刷新
class PullToRefresh extends StatefulWidget {
  const PullToRefresh(
      {super.key, required this.backgroundColor, required this.textColor});

  /// 背景颜色
  final Color backgroundColor;

  /// 文字颜色
  final Color textColor;
  @override
  State<PullToRefresh> createState() => _PullToRefreshState();
}

class _PullToRefreshState extends State<PullToRefresh> {
  @override
  Widget build(BuildContext context) {
    return PullToRefreshContainer(buildPulltoRefreshHeader);
  }

  Widget buildPulltoRefreshHeader(PullToRefreshScrollNotificationInfo? info) {
    var offset = info?.dragOffset ?? 0.0;
    var mode = info?.mode;
    Widget refreshWidget = Container();
    //it should more than 18, so that RefreshProgressIndicator can be shown fully
    if (info?.refreshWidget != null &&
        offset > 50.0 &&
        mode != PullToRefreshIndicatorMode.error) {
      refreshWidget = info?.refreshWidget ??
          Container(
            width: 20,
            height: 20,
            color: Colors.red,
          );
    }

    Widget child = const SizedBox();
    if (mode == PullToRefreshIndicatorMode.error) {
      child = GestureDetector(
          // onTap: () {
          //   // refreshNotification;
          //   info?.pullToRefreshNotificationState.show();
          // },
          child: _buildItem(
              offset: offset, refreshWidget: refreshWidget, text: "网络异常请稍后重试"));
    } else if (mode == PullToRefreshIndicatorMode.drag) {
      child = _buildItem(
          offset: offset, refreshWidget: refreshWidget, text: "下拉刷新");
    } else if (mode == PullToRefreshIndicatorMode.armed) {
      child = _buildItem(
          offset: offset, refreshWidget: refreshWidget, text: "释放刷新");
    } else if (mode == PullToRefreshIndicatorMode.refresh) {
      child =
          _buildItem(offset: offset, refreshWidget: refreshWidget, text: "刷新中");
    } else if (mode == PullToRefreshIndicatorMode.done) {
      child = _buildItem(
          offset: offset, refreshWidget: refreshWidget, text: "刷新完成");
    } else if (mode == PullToRefreshIndicatorMode.canceled) {
      child = _buildItem(
          offset: offset, refreshWidget: refreshWidget, text: "刷新取消");
    } else {
      child = _buildItem(
          offset: offset, refreshWidget: refreshWidget, text: "开始刷新");
    }

    return SliverToBoxAdapter(
      child: child,
    );
  }

  _buildItem(
      {required double offset,
      required Widget refreshWidget,
      required String text}) {
    return Container(
      color: widget.backgroundColor,
      alignment: Alignment.bottomCenter,
      height: offset,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          refreshWidget,
          Container(
            padding: const EdgeInsets.only(left: 5.0),
            alignment: Alignment.center,
            child: Text(text,
                style: TextStyle(color: widget.textColor, fontSize: 16)),
          )
        ],
      ),
    );
  }
}
