import 'package:flutter/material.dart';

@immutable
class MyColorsTheme extends ThemeExtension<MyColorsTheme> {
  const MyColorsTheme({
    required this.brandColor,
    required this.danger,
  });

  final Color? brandColor;
  final Color? danger;

  @override
  MyColorsTheme copyWith({Color? brandColor, Color? danger}) {
    return MyColorsTheme(
      brandColor: brandColor ?? this.brandColor,
      danger: danger ?? this.danger,
    );
  }

  @override
  MyColorsTheme lerp(MyColorsTheme? other, double t) {
    if (other is! MyColorsTheme) {
      return this;
    }
    return MyColorsTheme(
      brandColor: Color.lerp(brandColor, other.brandColor, t),
      danger: Color.lerp(danger, other.danger, t),
    );
  }

  // Optional
  @override
  String toString() => 'MyColors(brandColor: $brandColor, danger: $danger)';
}
