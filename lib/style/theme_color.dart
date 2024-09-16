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
  static late  Color primaryColor;
  static late Color backgroundColor;
  static late Color appbarColor;
  static late Color textColor;
}
