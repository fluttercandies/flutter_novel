import 'package:flutter/material.dart';

class DetailDescText extends StatefulWidget {
  const DetailDescText({
    super.key,
    required this.text,
    required this.maxLines,
    required this.brandColor,
  });

  /// 文本
  final String text;

  /// 最大行数
  final int maxLines;

  final Color brandColor;

  @override
  State<DetailDescText> createState() => _DetailDescTextState();
}

class _DetailDescTextState extends State<DetailDescText>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  bool _isOverflowing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkTextOverflow();
    });
  }

  void _checkTextOverflow() {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: widget.text,
        style: const TextStyle(
          fontSize: 16,
          height: 1.5,
        ),
      ),
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: context.size!.width);

    setState(() {
      _isOverflowing = textPainter.didExceedMaxLines;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Text(
            widget.text,
            style: const TextStyle(
                fontSize: 16, height: 1.5, color: Colors.black54),
            maxLines: _isOverflowing
                ? _isExpanded
                    ? null
                    : widget.maxLines
                : null,
            overflow: TextOverflow.fade,
          ),
        ),
        GestureDetector(
          onTap: () {
            // if (_isOverflowing) {
            //   // 仅当文本超出最大行数时才显示"阅读更多/收起"
            // }
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: _isExpanded
              ? _buildMore("收起介绍", widget.brandColor, Icons.keyboard_arrow_up)
              : _buildMore(
                  "阅读更多", widget.brandColor, Icons.keyboard_arrow_down),
        ),
      ],
    );
  }

  /// 构建更多介绍
  Widget _buildMore(String str, Color color, IconData icon) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        str,
        style: TextStyle(color: color),
      ),
      Icon(icon, color: color)
    ]);
  }
}
