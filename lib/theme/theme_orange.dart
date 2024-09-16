import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/style/theme_color.dart';

/// 主题
class AppThemeOrange extends ThemeStyle {
// /// 主颜色
  static Color primaryColor = const Color.fromARGB(255, 244, 173, 30);
  static Color appbarColor = const Color.fromARGB(255, 244, 173, 30);
  static Color backgroundColor = const Color(0xfffafafa);
  static Color textColor = Colors.black87;

  static final ThemeData lightTheme = ThemeStyle.getThemeData(
    primaryColor: primaryColor,
    appbarColor: appbarColor,
    backgroundColor: backgroundColor,
    textColor: textColor,
  );
}
