import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/icons/novel_icon_icons.dart';
import 'package:novel_flutter_bit/style/theme_enum.dart';
import 'package:novel_flutter_bit/style/theme_style.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({
    super.key,
    required this.themeStyleProvider,
  });
  final ThemeStyleProvider themeStyleProvider;
  @override
  State<ThemeSwitch> createState() => _ShowSliderSheetState();
}

class _ShowSliderSheetState extends State<ThemeSwitch> {
  late Map<ThemeEnum, ThemeData> themes;
  @override
  void initState() {
    super.initState();
    themes = widget.themeStyleProvider.getThemeList();
    LoggerTools.looger.i(themes);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      width: 300,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "主题选择",
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: theme.textTheme.bodyLarge?.color,
                  fontSize: 20),
            ),
            20.verticalSpace,
            Wrap(
              spacing: 8,
              runSpacing: 10,
              children: _getThemeListWidget(),
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }

  /// 获取主题列表
  List<Widget> _getThemeListWidget() {
    List<Widget> list = [];
    for (int i = 0; i < themes.length; i++) {
      final key = themes.keys.elementAt(i);
      final value = themes[key];
      final isSelected =
          widget.themeStyleProvider.theme.primaryColor == value!.primaryColor;
      Widget child = GestureDetector(
          onTap: () => widget.themeStyleProvider.setTheme(key),
          child: Container(
              width: 37,
              height: 37,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                color: value.primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: isSelected
                  ? const Icon(
                      NovelIcon.meteor,
                      color: Colors.white,
                      size: 20,
                    )
                  : 0.verticalSpace));
      list.add(child);
    }
    return list;
  }
}
