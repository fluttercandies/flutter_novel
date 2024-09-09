import 'package:flutter/material.dart';

@immutable
class MyColorsTheme extends ThemeExtension<MyColorsTheme> {
  const MyColorsTheme({
    required this.brandColor,
    required this.containerColor,
    required this.textColorHomePage,
    required this.bookTitleColor,
    required this.bookBodyColor,
  });

  final Color? brandColor;
  final Color? containerColor;
  final Color? textColorHomePage;
  final Color? bookTitleColor;
  final Color? bookBodyColor;
  @override
  MyColorsTheme copyWith(
      {Color? brandColor,
      Color? containerColor,
      Color? textColorHomePage,
      Color? bookTitleColor,
      Color? bookBodyColor}) {
    return MyColorsTheme(
      brandColor: brandColor ?? this.brandColor,
      containerColor: containerColor ?? this.containerColor,
      textColorHomePage: textColorHomePage ?? this.textColorHomePage,
      bookTitleColor: bookTitleColor ?? this.bookTitleColor,
      bookBodyColor: bookBodyColor ?? this.bookBodyColor,
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
      bookTitleColor: Color.lerp(bookTitleColor, other.bookTitleColor, t),
      bookBodyColor: Color.lerp(bookTitleColor, other.bookTitleColor, t),
    );
  }

  // Optional
  @override
  String toString() =>
      'MyColors(brandColor: $brandColor, danger: $containerColor)';
}
