import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/style/theme_color.dart';

/// 主题
class AppThemeBlack extends ThemeStyle {
// /// 主颜色
  static Color primaryColor = Colors.black87;
  static Color appbarColor = Colors.black87;
  static Color backgroundColor = const Color.fromARGB(255, 71, 70, 70);
  static Color textColor = Colors.white;

  static final ThemeData lightTheme = ThemeStyle.getThemeData(
    primaryColor: primaryColor,
    appbarColor: appbarColor,
    backgroundColor: backgroundColor,
    textColor: textColor,
  );
}
