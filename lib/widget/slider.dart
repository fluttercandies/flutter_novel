// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final double defaultValue;
  final Color progressBarColor;
  final Color progressBarBackgroundColor;
  final double height;
  final ValueChanged<double> onChanged;

  CustomSlider({
    required this.minValue,
    required this.maxValue,
    this.defaultValue = 0,
    this.progressBarColor = Colors.blue,
    this.progressBarBackgroundColor = Colors.grey,
    this.height = 8.0,
    required this.onChanged,
  });

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _progress = 0.0;
  double _currentValue = 0.0;
  late Tooltip _tooltip;

  @override
  void initState() {
    super.initState();
    // 初始化进度值为默认值
    _progress = (widget.defaultValue - widget.minValue) /
        (widget.maxValue - widget.minValue);
    _currentValue = widget.defaultValue;
    _tooltip = Tooltip(
      message: _currentValue.toStringAsFixed(1),
      child: Container(), // Placeholder for Tooltip
    );
  }

  void _updateTooltip(double value, Offset position) {
    setState(() {
      _currentValue = value;
      _tooltip = Tooltip(
        message: _currentValue.toStringAsFixed(1),
        child: Container(), // Placeholder for Tooltip
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          // 计算新的进度值
          _progress =
              (details.localPosition.dx / context.size!.width).clamp(0.0, 1.0);

          // 映射到 minValue 和 maxValue
          _currentValue =
              widget.minValue + _progress * (widget.maxValue - widget.minValue);

          // 回调返回当前值
          widget.onChanged(_currentValue);

          // 更新 Tooltip
          _updateTooltip(_currentValue, details.globalPosition);
        });
      },
      onHorizontalDragEnd: (details) {
        // Tooltip 会自动消失，无需手动移除
      },
      child: Stack(
        children: [
          Container(
            width: 300,
            height: widget.height,
            color: Colors.red,
            child: CustomPaint(
              painter: SliderPainter(
                progress: _progress,
                progressBarColor: widget.progressBarColor,
                progressBarBackgroundColor: widget.progressBarBackgroundColor,
                height: widget.height,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: _progress * 300 - 25, // Tooltip 显示在滑块上方
            child: _tooltip,
          ),
        ],
      ),
    );
  }
}

class SliderPainter extends CustomPainter {
  final double progress;
  final Color progressBarColor;
  final Color progressBarBackgroundColor;
  final double height;

  SliderPainter({
    required this.progress,
    required this.progressBarColor,
    required this.progressBarBackgroundColor,
    required this.height,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 画笔
    Paint trackPaint = Paint()
      ..color = progressBarBackgroundColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = height;

    Paint progressPaint = Paint()
      ..color = progressBarColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = height;

    Paint thumbPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    // 绘制背景轨道
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(size.width, size.height / 2), trackPaint);

    // 绘制进度条
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(progress * size.width, size.height / 2), progressPaint);

    // 绘制滑块手柄
    canvas.drawCircle(
        Offset(progress * size.width, size.height / 2), 10.0, thumbPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
