// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/pages/book_novel/view/book_page.dart';
import 'package:novel_flutter_bit/pages/novel/view/novel_page.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';
import 'package:novel_flutter_bit/widget/slider_novel.dart';

class ShowSliderSheet extends StatefulWidget {
  ShowSliderSheet({
    super.key,
    required this.color,
    required this.value,
    required this.onChanged,
  });
  final Color color;
  late double value;
  final dynamic Function(dynamic)? onChanged;
  @override
  State<ShowSliderSheet> createState() => _ShowSliderSheetState();
}

class _ShowSliderSheetState extends State<ShowSliderSheet> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return DefaultTextStyle(
      style: TextStyle(
          fontWeight: FontWeight.w300,
          color: theme.textTheme.bodyLarge?.color,
          fontSize: 18),
      child: SizedBox(
        height: 500,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              const Align(
                  child: Text(
                "设置",
                style: TextStyle(fontSize: 20),
              )),
              10.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("字体大小：${NovelSize.size.toInt()}"),
              ),
              SliderNovel(
                color: widget.color,
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
      ),
    );
  }
}
