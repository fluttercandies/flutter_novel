// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

/// 底部导航栏
class CustomBottomNavigationBar extends StatelessWidget {
  /// 当前选中的索引
  final int currentIndex;

  /// 点击回调
  final ValueChanged<int> onTap;

  /// 底部导航栏的item
  final List<BottomNavigationBarItem> items;

  /// 底部导航栏高度
  late double height = 60;
  CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -5),
            blurRadius: 10,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: BottomNavigationBar(
          items: items,
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
