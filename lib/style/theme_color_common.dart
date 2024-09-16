import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/style/theme_color.dart';

/// 公用颜色部分提取
abstract class CommonThemeColors implements LocalThemeStyle {
  @override
  Color get iconFontColor => const Color(0xff868d9a);
  @override
  Color get iconFontHighlightColor => const Color(0xfffefefe);
  @override
  Color get iconWarningColor => const Color(0xfff4ea2a);
  @override
  Color get iconBrandColor => const Color(0xff29D697);
  @override
  Color get brandColor => const Color(0xff29D697);
  @override
  Color get successColor => const Color(0xff05D69C);
  @override
  Color get errorColor => const Color(0xffec1f5a);

  @override
  Color get backgroundColor => throw UnimplementedError();

  @override
  Color get bottomAppBarColor => throw UnimplementedError();

  @override
  double get fontSize => throw UnimplementedError();
}

/// 亮色主题配置
class LocalThemeLight extends CommonThemeColors {
  @override
  Color get iconFontDarkLightColor => const Color(0xfffefefe);
  @override
  Color get auxiliaryColor => const Color(0xffe1e1e1);
  @override
  Color get warningColor => const Color(0xffe2d21a);

  @override
  Color get titleColor => const Color(0xff222832);
  @override
  Color get textColor => const Color(0xff282d37);
  @override
  Color get auxiliaryTextColor => const Color(0xff868d9a);

  @override
  Color get backgroundColor => throw UnimplementedError();

  @override
  Color get bottomAppBarColor => throw UnimplementedError();

  @override
  double get fontSize => throw UnimplementedError();
}

/// 暗色主题配置
class LocalThemeDark extends CommonThemeColors {
  @override
  Color get iconFontDarkLightColor => const Color(0xfffefefe);
  @override
  Color get auxiliaryColor => const Color(0xffD6E3FF);
  @override
  Color get warningColor => const Color(0xffe2d21a);

  @override
  Color get titleColor => const Color(0xffdfdfdf);
  @override
  Color get textColor => const Color(0xffd5d5d5);
  @override
  Color get auxiliaryTextColor => const Color(0xffeaeaea);

  @override
  Color get backgroundColor => throw UnimplementedError();

  @override
  Color get bottomAppBarColor => throw UnimplementedError();

  @override
  double get fontSize => throw UnimplementedError();
}
