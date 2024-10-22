import 'dart:math';

import 'package:flutter/material.dart';

/// 自定义背景
class CustomBackgroundPainter extends CustomPainter {
  final Color color1; // 上部分颜色
  final Color color2; // 下部分颜色
  final double leftAngle; // 左边的斜线角度
  final double rightAngle; // 右边的斜线角度
  final double lineHeight; // 斜线的起始高度

  CustomBackgroundPainter({
    required this.color1,
    required this.color2,
    required this.leftAngle,
    required this.rightAngle,
    this.lineHeight = .8,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double rightAngleInRadians = rightAngle * pi / 180;
// 创建画笔，设置填充颜色为黑色
    Paint paint = Paint()..color = Colors.black;

    // 根据角度和高度计算斜线的两个点
    double endY = lineHeight * size.height; // 右侧的起始高度

    Offset endPoint =
        Offset(size.width, endY - size.width * tan(rightAngleInRadians)); // 右侧点

    // 上部分的路径
    Path topPath = Path()
      ..moveTo(0, 0) // 左上角
      ..quadraticBezierTo(-400, endPoint.dy + 500, endPoint.dx + 700, 0)
      // ..lineTo(startPoint.dx, startPoint.dy) // 左侧斜线起点
      // ..lineTo(endPoint.dx, endPoint.dy) // 右侧斜线终点
      // ..lineTo(size.width, 0) // 右上角
      ..close(); // 形成封闭的区域

    // 下部分的路径
    Path bottomPath = Path()
      ..moveTo(-200, size.height + (endPoint.dy / 5))
      ..quadraticBezierTo(0, 200, 1500, size.height + (endPoint.dy / 10))
      // ..moveTo(startPoint.dx, startPoint.dy) // 左侧斜线起点
      // ..lineTo(endPoint.dx, endPoint.dy) // 右侧斜线终点
      // ..lineTo(size.width, size.height) // 右下角
      // ..lineTo(0, size.height) // 左下角
      ..close(); // 形成封闭的区域
// 绘制一个矩形，覆盖整个画布
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    // 绘制上部分颜色 (颜色1)
    Paint topPaint = Paint()..color = color1;
    canvas.drawPath(topPath, topPaint);

    // 绘制下部分颜色 (颜色2)
    Paint bottomPaint = Paint()..color = color2;
    canvas.drawPath(bottomPath, bottomPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// ignore: must_be_immutable
class CustomBackground extends StatelessWidget {
  final Color color1;
  final Color color2;
  final double leftAngle;
  final double rightAngle;
  final double lineHeight;
  final Widget? child;
  const CustomBackground(
      {super.key,
      required this.color1,
      required this.color2,
      required this.leftAngle,
      required this.rightAngle,
      this.lineHeight = .8,
      this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: CustomPaint(
        size: Size.infinite,
        painter: CustomBackgroundPainter(
          color1: color1,
          color2: color2,
          leftAngle: leftAngle,
          rightAngle: rightAngle,
          lineHeight: lineHeight,
        ),
        child: child,
      ),
    );
  }
}
