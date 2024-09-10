// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/style/theme.dart';

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
    final MyColorsTheme colors = Theme.of(context).extension<MyColorsTheme>()!;
    return Container(
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.borderRadius),
            topRight: Radius.circular(widget.borderRadius),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: 10,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.borderRadius),
            topRight: Radius.circular(widget.borderRadius),
          ),
          child: BottomAppBar(
              color: Colors.white,
              child: SizedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(widget.borderRadius),
                    topRight: Radius.circular(widget.borderRadius),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: widget.items.asMap().entries.map((value) {
                        bool isSelected = value.key == widget.currentIndex;
                        Icon icon = value.value;
                        icon = Icon(icon.icon,
                            color:
                                isSelected ? Colors.white : colors.brandColor);
                        return _buildItem(value, isSelected, icon, colors);
                      }).toList()),
                ),
              )),
        ));
  }

  /// 单个item
  Widget _buildItem(MapEntry<int, Icon> value, bool isSelected, Icon icon,
      MyColorsTheme colors) {
    return GestureDetector(
      onTap: () => widget.onTap(value.key),
      child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 11),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isSelected ? colors.brandColor : Colors.transparent),
          duration: Durations.short4,
          child: icon),
    );
  }
}

/// 底部导航栏
class CustomBottomNavigationBar1 extends StatelessWidget {
  /// 当前选中的索引
  final int currentIndex;

  /// 点击回调
  final ValueChanged<int> onTap;

  /// 底部导航栏的item
  final List<BottomNavigationBarItem> items;

  /// 底部导航栏高度
  late double height = 60;
  CustomBottomNavigationBar1({
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
