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
    required this.lineHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 将角度转换为弧度
    double leftAngleInRadians = leftAngle * pi / 180;
    double rightAngleInRadians = rightAngle * pi / 180;

    // 根据角度和高度计算斜线的两个点
    double startY = lineHeight * size.height; // 左侧的起始高度
    double endY = lineHeight * size.height; // 右侧的起始高度

    Offset startPoint =
        Offset(0, startY - size.width * tan(leftAngleInRadians)); // 左侧点
    Offset endPoint =
        Offset(size.width, endY - size.width * tan(rightAngleInRadians)); // 右侧点

    // 上部分的路径
    Path topPath = Path()
      ..moveTo(0, 0) // 左上角
      ..lineTo(startPoint.dx, startPoint.dy) // 左侧斜线起点
      ..lineTo(endPoint.dx, endPoint.dy) // 右侧斜线终点
      ..lineTo(size.width, 0) // 右上角
      ..close(); // 形成封闭的区域

    // 下部分的路径
    Path bottomPath = Path()
      ..moveTo(startPoint.dx, startPoint.dy) // 左侧斜线起点
      ..lineTo(endPoint.dx, endPoint.dy) // 右侧斜线终点
      ..lineTo(size.width, size.height) // 右下角
      ..lineTo(0, size.height) // 左下角
      ..close(); // 形成封闭的区域

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
      required this.lineHeight,
      this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: CustomBackgroundPainter(
        color1: color1,
        color2: color2,
        leftAngle: leftAngle,
        rightAngle: rightAngle,
        lineHeight: lineHeight,
      ),
      child: child,
    );
  }
}
