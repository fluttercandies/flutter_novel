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
// /// 定义颜色提供者，使用 Notifier 而非 StateNotifier
// class LocalTheme extends Notifier<LocalThemeStyle> {
//   // 初始化默认状态为亮色主题
//   @override
//   LocalThemeStyle build() {
//     return LocalThemeLight();
//   }
//   // 更新主题方法
//   void updateTheme(Brightness brightness, AdaptiveThemeMode adaptiveThemeMode) {
//     switch (adaptiveThemeMode) {
//       case AdaptiveThemeMode.dark:
//         state = LocalThemeDark();
//         break;
//       case AdaptiveThemeMode.light:
//         state = LocalThemeLight();
//         break;
//       case AdaptiveThemeMode.system:
//         state = (brightness == Brightness.dark) ? LocalThemeDark() : LocalThemeLight();
//         break;
//     }
//   }
// }
// /// 提供主题的 provider，使用 NotifierProvider 以保证持久化
// final localThemeProvider = NotifierProvider<LocalTheme, LocalThemeStyle>(() {
//   return LocalTheme();
// });


// /// 公用颜色部分提取
// abstract class CommonThemeColors implements LocalThemeStyle {
//   @override
//   Color get iconFontColor => const Color(0xff868d9a);
//   @override
//   Color get iconFontHighlightColor => const Color(0xfffefefe);
//   @override
//   Color get iconWarningColor => const Color(0xfff4ea2a);
//   @override
//   Color get iconBrandColor => const Color(0xff29D697);
//   @override
//   Color get brandColor => const Color(0xff29D697);
//   @override
//   Color get successColor => const Color(0xff05D69C);
//   @override
//   Color get errorColor => const Color(0xffec1f5a);
// }

// /// 亮色主题配置
// class LocalThemeLight extends CommonThemeColors {
//   @override
//   Color get iconFontDarkLightColor => const Color(0xfffefefe);
//   @override
//   Color get auxiliaryColor => const Color(0xffe1e1e1);
//   @override
//   Color get warningColor => const Color(0xffe2d21a);

//   @override
//   Color get titleColor => const Color(0xff222832);
//   @override
//   Color get textColor => const Color(0xff282d37);
//   @override
//   Color get auxiliaryTextColor => const Color(0xff868d9a);
// }

// /// 暗色主题配置
// class LocalThemeDark extends CommonThemeColors {
//   @override
//   Color get iconFontDarkLightColor => const Color(0xfffefefe);
//   @override
//   Color get auxiliaryColor => const Color(0xffD6E3FF);
//   @override
//   Color get warningColor => const Color(0xffe2d21a);

//   @override
//   Color get titleColor => const Color(0xffdfdfdf);
//   @override
//   Color get textColor => const Color(0xffd5d5d5);
//   @override
//   Color get auxiliaryTextColor => const Color(0xffeaeaea);
// }







// 主动在页面使用的话

// class ExamplePage extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // 读主题样式
//     final _localThemeStyle = ref.watch(localThemeProvider);
//     // 读字体样式
//     final _localFontStyle = ref.watch(localFontProvider);
//     // 读取状态
//     final state = ref.watch(exampleLogicProvider);
//     // 获取logic
//     final logic = ref.read(exampleLogicProvider.notifier);

//     return Scaffold(
//       appBar: AppBar(title: Text('example')),
//       body: Center(
//         child: ListView(
//           children: [

//           ],
//         ),
//       ),
//     );
//   }
// }




///   /// 监听系统主题变化，并更新应用主题
//     _monitorSystemThemeChanges();

// 这个放到myApp的build树里面，进行监听

//   // 监听系统主题变化并更新应用的主题样式
//   void _monitorSystemThemeChanges() {
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       final brightness = MediaQuery.of(context).platformBrightness;
//       final updatedThemeMode = await AdaptiveTheme.getThemeMode();
//       debugPrint("brightness: $brightness, updatedThemeMode: $updatedThemeMode");
//       ref.read(localThemeProvider.notifier).updateTheme(brightness,updatedThemeMode!);
//     });
//   }