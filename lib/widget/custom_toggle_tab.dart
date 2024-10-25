// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';

class CustomToggleTab extends StatefulWidget {
  const CustomToggleTab(
      {super.key,
      this.height = 34,
      this.tabs = const ['背景', '字体', '“字体”'],
      this.onTap,
      this.padding = 15});
  final double height;
  final List<String> tabs;
  final void Function(int index)? onTap;
  final double padding;
  @override
  _CustomToggleTabState createState() => _CustomToggleTabState();
}

class _CustomToggleTabState extends State<CustomToggleTab> {
  int _selectedIndex = 0;

  /// 获取选中的tab的left位置
  double _getLeft(double maxWidth) {
    var data = _selectedIndex * maxWidth / 3;
    if (_selectedIndex != 0) {
      data -= 2 * _selectedIndex;
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: widget.padding, right: widget.padding, top: widget.padding),
      child: Column(
        children: [
          Container(
            height: widget.height,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child:
                LayoutBuilder(builder: (context, BoxConstraints constraints) {
              return Stack(
                children: [
                  AnimatedPositioned(
                    height: widget.height,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    left: _getLeft(constraints.maxWidth),
                    child: Container(
                      width: constraints.maxWidth / 3, // 减去左右边距
                      margin: 2.padding,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26.withOpacity(0.2),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(widget.tabs.length, (index) {
                      return Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            widget.onTap?.call(index);
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          child: Center(
                            child: Text(
                              widget.tabs[index],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
