// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/style/theme_novel.dart';
import 'package:novel_flutter_bit/widget/slider_novel.dart';

class ShowSliderSheet extends StatefulWidget {
  ShowSliderSheet({
    super.key,
    required this.novelTheme,
    required this.value,
    required this.onChanged,
  });
  final NovelTheme novelTheme;
  late double value;
  final dynamic Function(dynamic)? onChanged;
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
                if (widget.onChanged != null) {
                  widget.onChanged!(widget.value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
