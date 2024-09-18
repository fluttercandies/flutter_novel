// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/icons/novel_icon_icons.dart';
import 'package:novel_flutter_bit/pages/novel/view/novel_page.dart';
import 'package:novel_flutter_bit/style/theme_style.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';
import 'package:novel_flutter_bit/widget/slider_novel.dart';

class ShowSliderSheet extends StatefulWidget {
  ShowSliderSheet({
    super.key,
    required this.color,
    required this.value,
    required this.onChanged,
    required this.themeStyleProvider,
  });
  final Color color;
  late double value;
  final dynamic Function(dynamic)? onChanged;
  final ThemeStyleProvider themeStyleProvider;
  @override
  State<ShowSliderSheet> createState() => _ShowSliderSheetState();
}

class _ShowSliderSheetState extends State<ShowSliderSheet> {
  late List<ThemeData> themes;
  @override
  void initState() {
    super.initState();
    themes = widget.themeStyleProvider.getThemeList();
    LoggerTools.looger.i(themes);
  }

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
              20.verticalSpace,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text("主题选择"),
              ),
              5.verticalSpace,
              Expanded(
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: themes.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 5),
                    itemBuilder: (context, index) {
                      final isSelected =
                          widget.themeStyleProvider.theme.primaryColor ==
                              themes[index].primaryColor;
                      return InkWell(
                          onTap: () {
                            widget.themeStyleProvider.setTheme(themes[index]);
                          },
                          child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: themes[index].primaryColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Icon(
                                NovelIcon.meteor,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.transparent,
                              )));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
