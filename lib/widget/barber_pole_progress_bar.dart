// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class BarberPoleProgressBar extends StatefulWidget {
  final double progress; // 进度
  /// 默认高度
  final double height;

  /// 进度条颜色
  final Color color;

  /// 动画开关
  final bool animationEnabled;
  const BarberPoleProgressBar(
      {super.key,
      required this.progress,
      this.height = 15,
      this.animationEnabled = true,
      this.color = const Color(0xfff87038)});

  @override
  _BarberPoleProgressBarState createState() => _BarberPoleProgressBarState();
}

class _BarberPoleProgressBarState extends State<BarberPoleProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    if (widget.animationEnabled) {
      _controller.repeat(); // 无限循环动画
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0), // 圆角
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: widget.height,
            color: Colors.grey.shade300,
          ),
          // 背景条 (未填充部分)
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final width = constraints.biggest.width * widget.progress;
              return Container(
                width: width,
                height: widget.height,
                color: widget.color,
              );
            },
          ),
          // 进度条 (填充部分)
          SizedBox(
            width: MediaQuery.of(context).size.width * widget.progress,
            height: widget.height,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: BarberPolePainter(_controller.value),
                  child:
                      SizedBox(width: double.infinity, height: widget.height),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BarberPolePainter extends CustomPainter {
  final double animationValue;

  BarberPolePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    const barWidth = 20.0; // 间距为30的白色斜条

    // 计算斜条的移动偏移
    final offsetX = animationValue * barWidth * 2;

    for (double i = -barWidth; i < size.width; i += barWidth * 2) {
      // 斜着绘制白色条纹
      final path = Path();
      path.moveTo(i + offsetX, 0);
      path.lineTo(i + barWidth + offsetX, 0);
      path.lineTo(i + barWidth / 2 + offsetX, size.height);
      path.lineTo(i - barWidth / 2 + offsetX, size.height);
      path.close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // 每次动画更新时重新绘制
  }
}
