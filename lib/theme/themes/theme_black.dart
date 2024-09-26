import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/theme/theme_color.dart';

/// 主题
class AppThemeBlack extends ThemeStyle {
// /// 主颜色
  static Color primaryColor = Colors.black87;
  static Color appbarColor = Colors.black87;
  static Color backgroundColor = const Color.fromARGB(255, 240, 240, 240);
  static Color textColor = Colors.black54;
  static Color textMinorColor = Colors.black87;
  static final ThemeData lightTheme = ThemeStyle.getThemeData(
      primaryColor: primaryColor,
      appbarColor: appbarColor,
      backgroundColor: backgroundColor,
      textColor: textColor,
      textMinorColor: textMinorColor);
}
