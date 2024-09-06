import 'package:flutter/material.dart';

@immutable
class MyColorsTheme extends ThemeExtension<MyColorsTheme> {
  const MyColorsTheme({
    required this.brandColor,
    required this.containerColor,
    required this.textColorHomePage,
  });

  final Color? brandColor;
  final Color? containerColor;
  final Color? textColorHomePage;
  @override
  MyColorsTheme copyWith(
      {Color? brandColor, Color? containerColor, Color? textColorHomePage}) {
    return MyColorsTheme(
      brandColor: brandColor ?? this.brandColor,
      containerColor: containerColor ?? this.containerColor,
      textColorHomePage: textColorHomePage ?? this.textColorHomePage,
    );
  }

  @override
  MyColorsTheme lerp(MyColorsTheme? other, double t) {
    if (other is! MyColorsTheme) {
      return this;
    }
    return MyColorsTheme(
      brandColor: Color.lerp(brandColor, other.brandColor, t),
      containerColor: Color.lerp(containerColor, other.containerColor, t),
      textColorHomePage:
          Color.lerp(textColorHomePage, other.textColorHomePage, t),
    );
  }

  // Optional
  @override
  String toString() =>
      'MyColors(brandColor: $brandColor, danger: $containerColor)';
}
