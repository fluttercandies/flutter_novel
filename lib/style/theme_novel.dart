import 'package:flutter/material.dart';

class NovelTheme extends ThemeExtension<NovelTheme> {
  const NovelTheme({
    this.bottomAppBarColor,
    this.selectedColor,
    this.notSelectedColor,
    this.backgroundColor,
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

  ///
  final Color? bottomAppBarColor;
  @override
  ThemeExtension<NovelTheme> copyWith({
    Color? selectedColor,
    Color? notSelectedColor,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    Color? bottomAppBarColor,
  }) {
    return NovelTheme(
        selectedColor: selectedColor ?? this.selectedColor,
        notSelectedColor: notSelectedColor ?? this.notSelectedColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        fontSize: fontSize ?? this.fontSize,
        fontWeight: fontWeight ?? this.fontWeight,
        bottomAppBarColor: bottomAppBarColor ?? this.bottomAppBarColor);
  }

  @override
  ThemeExtension<NovelTheme> lerp(
      covariant ThemeExtension<NovelTheme>? other, double t) {
    if (other is! NovelTheme) {
      return this;
    }
    return NovelTheme(
      selectedColor: Color.lerp(selectedColor, other.selectedColor, t),
      notSelectedColor: Color.lerp(notSelectedColor, other.notSelectedColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      fontSize: fontSize,
      fontWeight: fontWeight,
      bottomAppBarColor:
          Color.lerp(bottomAppBarColor, other.bottomAppBarColor, t),
    );
  }
}
