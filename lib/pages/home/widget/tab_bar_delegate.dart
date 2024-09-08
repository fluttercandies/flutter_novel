import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/style/theme.dart';

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  /// 标签
  final List<Widget> _tabs;

  /// 控制器
  final TabController? controller;

  /// 主题
  final MyColorsTheme myColors;
  TabBarDelegate(List<Widget> tabs,
      {required this.controller, required this.myColors})
      : _tabs = tabs;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xfffafafa),
        gradient: LinearGradient(
          colors: [
            Colors.white, // 渐变的起始颜色
            Theme.of(context).scaffoldBackgroundColor, // 渐变的结束颜色
          ],
          begin: Alignment.topCenter, // 渐变的起始位置
          end: Alignment.bottomCenter, // 渐变的结束位置
        ),
      ),
      child: TabBar(
        indicatorColor: Colors.transparent,
        controller: controller,
        dividerColor:
            Colors.transparent, //myColors.brandColor?.withOpacity(.2),
        labelColor: myColors.brandColor, // 设置选中标签的文本颜色
        labelStyle: const TextStyle(fontSize: 16),
        unselectedLabelColor: Colors.grey, // 设置未选中标签的文本颜色
        unselectedLabelStyle: TextStyle(color: myColors.brandColor),
        tabs: _tabs,
      ),
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
