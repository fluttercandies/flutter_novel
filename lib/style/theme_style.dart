import 'dart:math';

import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/db/preferences_db.dart';
import 'package:novel_flutter_bit/theme/theme_default.dart';
import 'package:novel_flutter_bit/theme/theme_green.dart';
import 'package:novel_flutter_bit/theme/theme_orange.dart';
import 'package:novel_flutter_bit/theme/theme_red.dart';
import 'package:novel_flutter_bit/theme/theme_yellow.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_style.g.dart';

/// 主题颜色
@riverpod
class ThemeStyleProvider extends _$ThemeStyleProvider {
  static const Color _colorLight = Color(0xfff87038);
  static get color => _colorLight;
  ThemeData get theme => _data;
  bool isInit = false;

  /// 主题
  late ThemeData _data = ThemeData(fontFamily: 'MiSans');

  /// 初始化
  @override
  Future<ThemeData> build() async {
    initTheme();
    return _data;
  }

  List<ThemeData> getThemeList() {
    return [
      AppThemeDefault.lightTheme,
      AppThemeRed.lightTheme,
      AppThemeGreen.lightTheme,
      AppThemeYellow.lightTheme,
      AppThemeOrange.lightTheme,
    ];
  }

  /// 初始化主题
  void initTheme({String? data}) async {
    String mode = data ?? await PreferencesDB.instance.getMultipleThemesMode();
    switch (mode) {
      case 'red':
        _data = AppThemeRed.lightTheme;
        break;
      case 'green':
        _data = AppThemeGreen.lightTheme;
        break;
      case 'yellow':
        _data = AppThemeYellow.lightTheme;
        break;
      case 'orange':
        _data = AppThemeOrange.lightTheme;
        break;
      default:
        _data = AppThemeDefault.lightTheme;
    }
    state = AsyncData(_data);
    // if (size != null) {
    //   isInit = false;
    // }
    // if (!isInit) {
    //   LoggerTools.looger.f('init ThemeStyleProvider');
    //   _lightTheme = _data.copyWith(
    //     scaffoldBackgroundColor: const Color(0xfffafafa),
    //     brightness: Brightness.light,
    //     appBarTheme: const AppBarTheme(
    //       color: Colors.white,
    //       titleTextStyle: _textStyle,
    //       surfaceTintColor: Colors.transparent,
    //     ),
    //     iconTheme: const IconThemeData(color: _colorLight),
    //     textTheme: const TextTheme(
    //       bodyMedium:
    //           TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
    //     ),
    //     extensions: <ThemeExtension<dynamic>>[
    //       const MyColorsTheme(
    //         brandColor: _colorLight,
    //         containerColor: Colors.white,
    //         textColorHomePage: Colors.black,
    //         bookTitleColor: Colors.black87,
    //         bookBodyColor: _colorLight,
    //         bottomAppBarColor: Colors.white,
    //       ),
    //       NovelTheme(
    //           fontSize: size ?? 18,
    //           selectedColor: _colorLight,
    //           notSelectedColor: Colors.black,
    //           bottomAppBarColor: Colors.white,
    //           backgroundColor: const Color(0xfffafafa))
    //     ],
    //   );
    //   _darkTheme = _data.copyWith(
    //     scaffoldBackgroundColor: const Color(0xfff5f5f5),
    //     brightness: Brightness.dark,
    //     appBarTheme: AppBarTheme(
    //         color: _colorDark,
    //         surfaceTintColor: Colors.transparent,
    //         titleTextStyle: _textStyle.copyWith(color: Colors.white)),
    //     iconTheme: const IconThemeData(color: _colorDark),
    //     textTheme: const TextTheme(
    //       bodyMedium:
    //           TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
    //     ),
    //     extensions: <ThemeExtension<dynamic>>[
    //       const MyColorsTheme(
    //         brandColor: _colorDark,
    //         containerColor: Color(0xfffff9fe),
    //         textColorHomePage: _colorDark,
    //         bookTitleColor: Colors.black87,
    //         bookBodyColor: _colorDark,
    //         bottomAppBarColor: Color(0xfffff9fe),
    //       ),
    //       NovelTheme(
    //           fontSize: size ?? 18,
    //           selectedColor: _colorDark,
    //           notSelectedColor: Colors.black,
    //           bottomAppBarColor: const Color.fromARGB(255, 251, 248, 255),
    //           backgroundColor: const Color(0xfffff9fe))
    //     ],
    //   );
    //   _setSystemUiOverlayStyle();
    //   _data = _lightTheme;
    //   state = AsyncData(_data);
    //   isInit = true;
    // }
  }

  void setTheme(ThemeData data) {
    _data = data;
    state = AsyncData(_data);
  }

  /// Toggles the current brightness between light and dark.
  void switchTheme() {
    // var dataTheme =
    //     _data.brightness == Brightness.dark ? _lightTheme : _darkTheme;
    // _data = dataTheme;
    // LoggerTools.looger.d('_dataswitchTheme: ${_data.brightness} ');
    //_setSystemUiOverlayStyle();
    List data = getThemeList();
    var randomInt = Random().nextInt(data.length);
    _data = data[randomInt];
    state = AsyncData(_data);
  }

  // /// 设置状态栏样式
  // void _setSystemUiOverlayStyle() {
  //   // 设置状态栏为透明
  //   if (Platform.isAndroid) {
  //     if (_data.brightness == Brightness.light) {
  //       SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //         statusBarColor: Colors.transparent,
  //         statusBarIconBrightness: Brightness.dark, // 状态栏图标颜色
  //         statusBarBrightness: Brightness.light, // 状态栏文字颜色
  //       ));
  //     } else {
  //       SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //         statusBarColor: Colors.transparent,
  //         statusBarIconBrightness: Brightness.dark, // 状态栏图标颜色
  //         statusBarBrightness: Brightness.light, // 状态栏文字颜色
  //       ));
  //     }
  //   }
  // }
}
