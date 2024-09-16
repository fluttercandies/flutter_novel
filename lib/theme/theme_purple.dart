import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/style/theme_color.dart';

/// 主题
class AppThemePurple extends ThemeStyle {
// /// 主颜色
  static Color primaryColor = const Color.fromARGB(255, 114, 74, 184);
  static Color appbarColor = const Color.fromARGB(255, 114, 74, 184);
  static Color backgroundColor = const Color(0xfffafafa);
  static Color textColor = Colors.black87;

  /// 浅色主题
  static final lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      // 字体
      fontFamily: null,
      // 文字
      textTheme: TextTheme(
        displayLarge: TextStyle(color: textColor),
        displayMedium: TextStyle(color: textColor),
        displaySmall: TextStyle(color: textColor),
        bodyLarge: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor),
        bodySmall: TextStyle(color: textColor),
      ),
      // 主颜色
      primaryColor: primaryColor,

      // scaffold背景颜色
      scaffoldBackgroundColor:
          backgroundColor, // 0xFFF7F7F7 0xFFF9F9F9 0xFFF6F8FA 0xFFFCFBFC
      // bottomNavigationBar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
      ),
      // 点击时水波颜色
      splashColor: Colors.transparent,
      // 点击时背景高亮颜色
      highlightColor: Colors.transparent,
      // Card
      cardColor: Colors.white,
      // bottomSheet
      bottomSheetTheme:
          const BottomSheetThemeData(modalBackgroundColor: Color(0xFFF6F8FA)),
      // Radio

      appBarTheme: AppBarTheme(
          color: appbarColor,
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
          surfaceTintColor: Colors.transparent));
}
