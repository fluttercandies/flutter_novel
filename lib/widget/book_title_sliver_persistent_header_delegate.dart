import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';

class BookTitleSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 50.0;
  @override
  double get maxExtent => 50.0;

  /// 颜色
  final Color myColors;

  final Color brandColor;

  /// 排序
  final bool reverse;

  final int count;
  final void Function()? onPressed;
  BookTitleSliverPersistentHeaderDelegate(
      {required this.count,
      required this.myColors,
      required this.reverse,
      required this.brandColor,
      this.onPressed});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: 10.horizontal,
      // color: myColors.containerColor,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.5],
              colors: [myColors, Theme.of(context).scaffoldBackgroundColor])),
      height: maxExtent,
      child: Row(
        children: [
          Text(
            '章节目录',
            style: TextStyle(fontSize: 20, color: brandColor),
          ),
          Text(" ($count) ", style: TextStyle(fontSize: 14, color: brandColor)),
          const Spacer(),
          Text(reverse ? "正序" : "倒叙"),
          IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.change_circle_sharp,
                color: brandColor,
              ))
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class TitleSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 50.0;
  @override
  double get maxExtent => 50.0;

  /// 颜色
  final Color myColors;

  final Color brandColor;

  final String title;

  final String? subTitle;

  final IconData? iconData;
  final void Function()? onPressed;
  TitleSliverPersistentHeaderDelegate(
      {required this.title,
      required this.myColors,
      required this.brandColor,
      this.iconData,
      this.subTitle,
      this.onPressed});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SafeArea(
      child: Container(
        padding: 10.horizontal,
        // color: myColors.containerColor,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.5],
                colors: [myColors, Theme.of(context).scaffoldBackgroundColor])),
        height: maxExtent,
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, color: brandColor),
            ),
            const Spacer(),
            Text(subTitle ?? ""),
            IconButton(
                onPressed: onPressed,
                icon: Icon(
                  iconData ?? Icons.chevron_right,
                  color: brandColor,
                ))
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
