import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';

import 'theme.dart';

/// 主题颜色
class ThemeStyleProvider extends ChangeNotifier {
  static const Color _color = Color(0xfff87038);
  static get color => _color;

  ThemeData get theme => _data;

  /// 主题
  late ThemeData _data = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: _color),
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
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      extensions: <ThemeExtension<dynamic>>[
        const MyColors(
          brandColor: Color(0xFF1E88E5),
          danger: Color(0xFFE53935),
        ),
      ],
    );
    _darkTheme = _data.copyWith(
      scaffoldBackgroundColor: Colors.black,
      brightness: Brightness.dark,
      extensions: <ThemeExtension<dynamic>>[
        const MyColors(
          brandColor: Color(0xFF90CAF9),
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
          statusBarIconBrightness: Brightness.light, // 状态栏图标颜色
          statusBarBrightness: Brightness.dark, // 状态栏文字颜色
        ));
      }
    }
  }
}
