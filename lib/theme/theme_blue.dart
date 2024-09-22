import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/style/theme_color.dart';

/// 主题
class AppThemeBlue extends ThemeStyle {
// /// 主颜色
  static Color primaryColor = const Color(0xff3f85ff);
  static Color appbarColor = const Color(0xff3f85ff);
  static Color backgroundColor = const Color(0xfffafafa);
  static Color textColor = Colors.black87;
  static Color textMinorColor = const Color(0xff3f85ff);
  static final ThemeData lightTheme = ThemeStyle.getThemeData(
      primaryColor: primaryColor,
      appbarColor: appbarColor,
      backgroundColor: backgroundColor,
      textColor: textColor,
      textMinorColor: textMinorColor);
}
