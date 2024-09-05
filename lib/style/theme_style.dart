import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';

import 'theme.dart';

/// 主题颜色
class ThemeStyleProvider extends ChangeNotifier {
  static const Color _colorLight = Color(0xfff87038);
  static const Color _colorDark = Color.fromARGB(255, 114, 74, 184);
  static get color => _colorLight;

  ThemeData get theme => _data;

  /// 主题
  late ThemeData _data = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: _colorLight),
    useMaterial3: true,
    iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
            overlayColor: WidgetStatePropertyAll(Colors.transparent))),
    // appBarTheme: const AppBarTheme(
    //   elevation: 0,
    //   toolbarHeight: 80,
    //   surfaceTintColor: Colors.transparent,
    //   backgroundColor: Colors.transparent,
    //    systemOverlayStyle: SystemUiOverlayStyle(
    //    statusBarColor: Colors.transparent,
    //     statusBarIconBrightness: Brightness.light,
    //      systemNavigationBarColor: Colors.transparent,
    //    ),
    //   iconTheme: IconThemeData(color: Color(0xFF212529)),
    // ),
    brightness: Brightness.light,
  );

  /// 浅色主题
  late ThemeData _lightTheme;

  /// 深色主题
  late ThemeData _darkTheme;

  /// 初始化
  ThemeStyleProvider() {
    _lightTheme = _data.copyWith(
      scaffoldBackgroundColor: const Color(0xfffafafa),
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(color: Colors.white),
      textTheme: const TextTheme(
        //bodyLarge: TextStyle(color: Colors.red),
        bodyMedium: TextStyle(color: Colors.black),
        // bodySmall: TextStyle(color: Colors.orange),
        // headlineLarge: TextStyle(color: Colors.green),
        // headlineMedium: TextStyle(color: Colors.yellow),
        // headlineSmall: TextStyle(color: Colors.pink),
      ),
      extensions: <ThemeExtension<dynamic>>[
        const MyColorsTheme(
          brandColor: _colorLight,
          danger: Color(0xFFE53935),
        ),
      ],
    );
    _darkTheme = _data.copyWith(
      scaffoldBackgroundColor: Colors.black,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(color: _colorDark),
      textTheme: const TextTheme(
        //bodyLarge: TextStyle(color: Colors.red),
        bodyMedium: TextStyle(color: Colors.white),
        // bodySmall: TextStyle(color: Colors.orange),
        // headlineLarge: TextStyle(color: Colors.green),
        // headlineMedium: TextStyle(color: Colors.yellow),
        // headlineSmall: TextStyle(color: Colors.pink),
      ),
      extensions: <ThemeExtension<dynamic>>[
        const MyColorsTheme(
          brandColor: _colorDark,
          danger: Colors.white,
        ),
      ],
    );
    _data = _lightTheme;
    _setSystemUiOverlayStyle();
  }

  /// Toggles the current brightness between light and dark.
  void switchTheme() {
    var dataTheme =
        _data.brightness == Brightness.dark ? _lightTheme : _darkTheme;
    _data = dataTheme;
    LoggerTools.looger.d('switchTheme: ${dataTheme.brightness} ');
    _setSystemUiOverlayStyle();
    notifyListeners();
  }

  /// 设置状态栏样式
  void _setSystemUiOverlayStyle() {
    // 设置状态栏为透明
    if (Platform.isAndroid) {
      if (_data.brightness == Brightness.light) {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark, // 状态栏图标颜色
          statusBarBrightness: Brightness.light, // 状态栏文字颜色
        ));
      } else {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark, // 状态栏图标颜色
          statusBarBrightness: Brightness.light, // 状态栏文字颜色
        ));
      }
    }
  }
}
