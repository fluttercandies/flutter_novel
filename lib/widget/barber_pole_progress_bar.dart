// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class BarberPoleProgressBar extends StatefulWidget {
  /// 进度
  final double progress;

  /// 默认高度
  final double height;

  /// 进度条颜色
  final Color? color;

  /// 动画开关
  final bool animationEnabled;

  /// 动画开关
  final bool notArriveProgressAnimation;

  /// 圆角
  final BorderRadius? borderRadius;

  const BarberPoleProgressBar({
    super.key,
    required this.progress,
    this.borderRadius,
    this.height = 15,
    this.animationEnabled = false,
    this.notArriveProgressAnimation = false,
    this.color = const Color(0xfff87038),
  });

  @override
  _BarberPoleProgressBarState createState() => _BarberPoleProgressBarState();
}

class _BarberPoleProgressBarState extends State<BarberPoleProgressBar>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  double _previousProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();

    if (widget.animationEnabled) {
      _controller.repeat(); // 无限循环动画
    }

    _setupProgressAnimation();
  }

  @override
  void didUpdateWidget(covariant BarberPoleProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _previousProgress = oldWidget.progress;
      _setupProgressAnimation();
      _progressController.forward(from: 0.0); // 重启进度动画
    }
  }

  void _setupProgressAnimation() {
    _progressAnimation = Tween<double>(
      begin: _previousProgress,
      end: widget.progress,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(20.0), // 圆角
      child: AnimatedBuilder(
        animation: _progressAnimation,
        builder: (context, child) {
          return Stack(
            children: [
              // 整个背景条
              Container(
                width: MediaQuery.of(context).size.width,
                height: widget.height,
                color: Colors.grey.shade300, // 未填充部分的背景色
              ),
              // 已填充部分的背景颜色
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final width =
                      constraints.biggest.width * _progressAnimation.value;
                  return Container(
                    width: width,
                    height: widget.height,
                    color: widget.color, // 填充部分的背景色
                  );
                },
              ),
              // 进度条 (限制斜条动画显示区域)
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  late double width;
                  width = constraints.biggest.width * _progressAnimation.value;
                  if (widget.notArriveProgressAnimation) {
                    width = MediaQuery.of(context).size.width * widget.progress;
                  }
                  return ClipRect(
                    // 限制动画绘制区域
                    child: SizedBox(
                      width: width, // 只绘制进度范围内的斜条
                      height: widget.height,
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return CustomPaint(
                            painter: BarberPolePainter(_controller.value,
                                widget.notArriveProgressAnimation),
                            child: SizedBox(
                                width: double.infinity, height: widget.height),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class BarberPolePainter extends CustomPainter {
  final double animationValue;
  final bool notArriveProgressAnimation;
  BarberPolePainter(this.animationValue, this.notArriveProgressAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    const barWidth = 20.0; // 斜条宽度

    // 计算斜条的移动偏移
    final offsetX = animationValue * barWidth * 2;
    double width = size.width + barWidth;
    if (notArriveProgressAnimation) {
      width = size.width;
    }
    for (double i = -barWidth; i < width; i += barWidth * 2) {
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
