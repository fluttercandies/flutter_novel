import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/style/theme_color.dart';

/// 主题
class AppThemePink extends ThemeStyle {
// /// 主颜色
  static Color primaryColor = Colors.pinkAccent;
  static Color appbarColor = Colors.pinkAccent;
  static Color backgroundColor = const Color(0xfffafafa);
  static Color textColor = Colors.black87;

  static final ThemeData lightTheme = ThemeStyle.getThemeData(
    primaryColor: primaryColor,
    appbarColor: appbarColor,
    backgroundColor: backgroundColor,
    textColor: textColor,
  );
}
