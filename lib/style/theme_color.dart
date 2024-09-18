import 'package:flutter/material.dart';

/// 颜色配置抽象类
abstract class LocalThemeStyle {
  Color get iconFontColor;
  Color get iconFontHighlightColor;
  Color get iconFontDarkLightColor;
  Color get iconWarningColor;
  Color get iconBrandColor;

  Color get brandColor;
  Color get auxiliaryColor;
  Color get warningColor;
  Color get successColor;
  Color get errorColor;

  Color get titleColor;
  Color get textColor;
  Color get auxiliaryTextColor;

  Color get bottomAppBarColor;
  Color get backgroundColor;
  double get fontSize;
  Color get appbarColor;
}

abstract class ThemeStyle {
  static late Color primaryColor;
  static late Color backgroundColor;
  static late Color appbarColor;
  static late Color textColor;

  static ThemeData getThemeData({
    Color? primaryColor,
    Color? backgroundColor,
    Color? appbarColor,
    Color? textColor,
  }) {
    return ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor ?? Colors.black, primary: primaryColor),
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
        bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
        appBarTheme: AppBarTheme(
            color: appbarColor,
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
            surfaceTintColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white)),
        iconButtonTheme: const IconButtonThemeData(
            style: ButtonStyle(
                overlayColor: WidgetStatePropertyAll(Colors.transparent))));
  }
}
