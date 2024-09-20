import 'package:flutter/material.dart';

class DetailDescText extends StatefulWidget {
  const DetailDescText({
    super.key,
    required this.text,
    this.minLines = 3,
    required this.brandColor,
  });

  /// 文本
  final String text;

  /// 最小行数
  final int minLines;

  final Color brandColor;

  @override
  State<DetailDescText> createState() => _DetailDescTextState();
}

class _DetailDescTextState extends State<DetailDescText> {
  bool _isExpanded = false;
  double _collapsedHeight = 0.0;
  double _fullHeight = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateHeights();
    });
  }

  // 计算文本的高度
  void _calculateHeights() {
    setState(() {
      _collapsedHeight = _getHeightForMaxLines(widget.minLines);
      _fullHeight = _getHeightForMax();
    });
  }

  // 根据最大行数计算折叠状态下的高度
  double _getHeightForMaxLines(int maxLines) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: widget.text,
        style: const TextStyle(
          fontSize: 16,
          height: 1.5,
          color: Colors.black54,
        ),
      ),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: context.size?.width ?? double.infinity);
    return textPainter.size.height;
  }

  double _getHeightForMax() {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: widget.text,
        style: const TextStyle(
          fontSize: 16,
          height: 1.5,
          color: Colors.black54,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: context.size?.width ?? double.infinity);
    return textPainter.size.height;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _isExpanded ? _fullHeight : _collapsedHeight,
          curve: Curves.easeInOut,
          child: Text(
            widget.text,
            style: const TextStyle(
                fontSize: 16, height: 1.5, color: Colors.black54),
            overflow: TextOverflow.fade,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: _buildMore(
            _isExpanded ? "收起介绍" : "阅读更多",
            widget.brandColor,
            _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
          ),
        ),
      ],
    );
  }

  /// 构建"阅读更多"或"收起介绍"按钮
  Widget _buildMore(String str, Color color, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          str,
          style: TextStyle(color: color),
        ),
        Icon(icon, color: color)
      ],
    );
  }
}
