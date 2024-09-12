import 'package:flutter/material.dart';

class ThemeNovel extends ThemeExtension<ThemeNovel> {
  const ThemeNovel({
    required this.selectedColor,
    required this.notSelectedColor,
    required this.backgroundColor,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w300,
  });

  /// 选中颜色
  final Color? selectedColor;

  /// 未选中颜色
  final Color? notSelectedColor;

  /// 背景颜色
  final Color? backgroundColor;

  /// 文字大小
  final double? fontSize;

  /// 文字粗细
  final FontWeight? fontWeight;
  @override
  ThemeExtension<ThemeNovel> copyWith({
    Color? selectedColor,
    Color? notSelectedColor,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return ThemeNovel(
      selectedColor: selectedColor ?? this.selectedColor,
      notSelectedColor: notSelectedColor ?? this.notSelectedColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
    );
  }

  @override
  ThemeExtension<ThemeNovel> lerp(
      covariant ThemeExtension<ThemeNovel>? other, double t) {
    if (other is! ThemeNovel) {
      return this;
    }
    return ThemeNovel(
      selectedColor: Color.lerp(selectedColor, other.selectedColor, t),
      notSelectedColor: Color.lerp(notSelectedColor, other.notSelectedColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}
