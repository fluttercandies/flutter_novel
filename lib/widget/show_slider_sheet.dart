import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/style/theme_novel.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';
import 'package:novel_flutter_bit/widget/slider_novel.dart';

class ShowSliderSheet extends StatefulWidget {
  ShowSliderSheet({
    super.key,
    required this.novelTheme,
    required this.value,
    required this.onPressed,
  });
  final NovelTheme novelTheme;
  late double value;
  final void Function(double size) onPressed;
  @override
  State<ShowSliderSheet> createState() => _ShowSliderSheetState();
}

class _ShowSliderSheetState extends State<ShowSliderSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("设置", style: TextStyle(fontSize: 20)),
            SliderNovel(
              color: widget.novelTheme.selectedColor!,
              value: widget.value,
              onChanged: (p0) {
                widget.value = p0;
                setState(() {});
              },
            ),
            const Spacer(),
            widget.value != widget.novelTheme.fontSize
                ? ElevatedButton(
                    onPressed: () {
                      widget.onPressed(widget.value);
                      Navigator.pop(context);
                    },
                    child: const Text("保存设置"))
                : 0.verticalSpace,
          ],
        ),
      ),
    );
  }
}
