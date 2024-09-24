// ignore_for_file: library_private_types_in_public_api

import 'dart:math';
import 'package:flutter/material.dart';

class FabMenuFloatingActionButton extends StatefulWidget {
  final Alignment alignment; // 控制主按钮的位置

  const FabMenuFloatingActionButton(
      {super.key, this.alignment = const Alignment(1, .8)}); // 默认右下角

  @override
  _FabMenuFloatingActionButtonState createState() =>
      _FabMenuFloatingActionButtonState();
}

class _FabMenuFloatingActionButtonState
    extends State<FabMenuFloatingActionButton>
    with SingleTickerProviderStateMixin {
  bool isMenuOpen = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  // 点击空白处关闭菜单
  void _closeMenu() {
    if (isMenuOpen) {
      setState(() {
        isMenuOpen = false;
      });
      _animationController.reverse();
    }
  }

  // 切换菜单的展开与关闭状态
  void _toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
      if (isMenuOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isMenuOpen) {
          _closeMenu();
        }
      }, // 点击空白处时关闭菜单
      child: Stack(
        children: [
          Align(
            alignment: widget.alignment, // 控制主按钮的位置
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _buildOption(Icons.camera_alt, 0),
                _buildOption(Icons.card_giftcard, 45),
                _buildOption(Icons.ac_unit, 90),
                // 主按钮
                FloatingActionButton(
                  onPressed: (isMenuOpen)
                      ? null
                      : () {
                          _toggleMenu(); // 点击主按钮时切换菜单状态
                        },
                  heroTag: "mainButton",
                  child: Icon(isMenuOpen ? Icons.close : Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 构建单个选项按钮
  Widget _buildOption(IconData icon, double angle) {
    final double radian = angle * (pi / 180); // 将角度转换为弧度

    bool isLeftSide = widget.alignment.x < 0; // 判断按钮是否在左侧
    bool isTopSide = widget.alignment.y < 0; // 判断按钮是否在顶部

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        // 根据动画进度计算位移
        final double offsetX = cos(radian) *
            (_animationController.value * 80) *
            (isLeftSide ? 1 : -1); // 在左边时向右展开，右边向左展开
        final double offsetY = sin(radian) *
            (_animationController.value * 80) *
            (isTopSide ? 1 : -1); // 在顶部时向下展开，底部向上展开

        return Transform.translate(
          offset: Offset(offsetX, offsetY), // 根据x和y轴调整位移效果
          child: Opacity(
            opacity: _animationController.value, // 透明度渐变效果
            child: FloatingActionButton(
              heroTag: icon,
              onPressed: () {},
              mini: true,
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
