import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/theme/theme_color.dart';

/// 主题
class AppThemeWhite extends ThemeStyle {
// /// 主颜色
  static Color primaryColor = Colors.white;
  static Color appbarColor = Colors.white;
  static Color backgroundColor = const Color(0xfff5f5f5);
  static Color textColor = Colors.black54;
  static Color textMinorColor = Colors.black87;
  static final ThemeData lightTheme = ThemeStyle.getThemeData(
      primaryColor: primaryColor,
      appbarColor: appbarColor,
      backgroundColor: backgroundColor,
      textColor: textColor,
      backButtonColorBlack: true,
      textMinorColor: textMinorColor);
}
