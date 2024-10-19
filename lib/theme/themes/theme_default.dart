import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/theme/theme_color.dart';

/// 主题
class AppThemeDefault extends ThemeStyle {
  // /// 主颜色
  static Color primaryColor = const Color(0xfff87038);
  static Color appbarColor = const Color(0xfff87038);
  static Color backgroundColor = Colors.white;
  static Color textColor = Colors.black87;
  static Color textMinorColor = const Color(0xfff87038);

  /// 浅色主题
  static final ThemeData lightTheme = ThemeStyle.getThemeData(
      primaryColor: primaryColor,
      appbarColor: appbarColor,
      backgroundColor: backgroundColor,
      textColor: textColor,
      textMinorColor: textMinorColor);
}
