import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/theme/theme_color.dart';

/// 主题
class AppThemeCyan extends ThemeStyle {
  /// 主颜色
  // /// 主颜色
  static Color primaryColor = const Color(0xFF19686A);
  static Color appbarColor = const Color(0xFF19686A);
  static Color backgroundColor = const Color(0xfffafafa);
  static Color textColor = Colors.black87;
  static Color textMinorColor = const Color(0xFF19686A);
  static final ThemeData lightTheme = ThemeStyle.getThemeData(
      primaryColor: primaryColor,
      appbarColor: appbarColor,
      backgroundColor: backgroundColor,
      textColor: textColor,
      textMinorColor: textMinorColor);
}