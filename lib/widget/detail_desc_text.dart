import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/style/theme.dart';

class DetailDescText extends StatefulWidget {
  const DetailDescText({super.key, required this.text, required this.maxLines});

  /// 文本
  final String text;

  /// 最大行数
  final int maxLines;

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
    final MyColorsTheme myColors =
        Theme.of(context).extension<MyColorsTheme>()!;

    return Column(
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Text(
            widget.text,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
            ),
            maxLines: _isExpanded ? null : widget.maxLines,
            overflow: TextOverflow.fade,
          ),
        ),
        if (_isOverflowing) // 仅当文本超出最大行数时才显示"阅读更多/收起"
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: _isExpanded
                ? _buildMore(
                    "收起介绍", myColors.brandColor!, Icons.keyboard_arrow_up)
                : _buildMore(
                    "阅读更多", myColors.brandColor!, Icons.keyboard_arrow_down),
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
