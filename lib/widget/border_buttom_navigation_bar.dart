// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/style/theme_style.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  /// 当前选中的索引
  final int currentIndex;

  /// 点击回调
  final ValueChanged<int> onTap;

  /// 底部导航栏的item
  final List<Icon> items;

  /// 底部导航栏高度
  late double height = 60;

  /// 底部导航栏圆角
  late double borderRadius;
  CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.height = 70,
    this.borderRadius = 10,
  }) {
    assert(
        items.length > 1, "items.length must be greater than 1 or equal to 2.");
  }
  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.height,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.borderRadius),
            topRight: Radius.circular(widget.borderRadius),
          ),
          child: BottomAppBar(
              color: Colors.white,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: widget.items.asMap().entries.map((value) {
                    bool isSelected = value.key == widget.currentIndex;
                    Icon icon = value.value;
                    icon = Icon(
                      icon.icon,
                      color: isSelected ? Colors.white : ThemeStyle.color,
                    );
                    return GestureDetector(
                      onTap: () => widget.onTap(value.key),
                      child: AnimatedContainer(
                          padding: const EdgeInsets.symmetric(horizontal: 11),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: isSelected
                                  ? ThemeStyle.color
                                  : Colors.transparent),
                          duration: Durations.short4,
                          child: icon),
                    );
                  }).toList())),
        ));
  }
}
