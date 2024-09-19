import 'dart:math';

import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/db/preferences_db.dart';
import 'package:novel_flutter_bit/style/theme_enum.dart';
import 'package:novel_flutter_bit/theme/theme_black.dart';
import 'package:novel_flutter_bit/theme/theme_blue.dart';
import 'package:novel_flutter_bit/theme/theme_cyan.dart';
import 'package:novel_flutter_bit/theme/theme_default.dart';
import 'package:novel_flutter_bit/theme/theme_green.dart';
import 'package:novel_flutter_bit/theme/theme_orange.dart';
import 'package:novel_flutter_bit/theme/theme_pink.dart';
import 'package:novel_flutter_bit/theme/theme_purple.dart';
import 'package:novel_flutter_bit/theme/theme_red.dart';
import 'package:novel_flutter_bit/theme/theme_white.dart';
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

  Map<ThemeEnum, ThemeData> getThemeList() {
    return {
      ThemeEnum.defaultTheme: AppThemeDefault.lightTheme,
      ThemeEnum.red: AppThemeRed.lightTheme,
      ThemeEnum.blue: AppThemeBlue.lightTheme,
      ThemeEnum.cyan: AppThemeCyan.lightTheme,
      ThemeEnum.pink: AppThemePink.lightTheme,
      ThemeEnum.purple: AppThemePurple.lightTheme,
      ThemeEnum.orange: AppThemeOrange.lightTheme,
      ThemeEnum.yellow: AppThemeYellow.lightTheme,
      ThemeEnum.black: AppThemeBlack.lightTheme,
      ThemeEnum.white: AppThemeWhite.lightTheme,
    };
    // {},
    // {}
    // AppThemeDefault.lightTheme,
    // AppThemeRed.lightTheme,
    // AppThemeGreen.lightTheme,
    // AppThemeBlue.lightTheme,
    // AppThemeCyan.lightTheme,
    // AppThemePink.lightTheme,
    // AppThemePurple.lightTheme,
    // AppThemeOrange.lightTheme,
    // AppThemeYellow.lightTheme,
    // AppThemeBlack.lightTheme,
    // AppThemeWhite.lightTheme
    //];
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
      case 'blue':
        _data = AppThemeBlue.lightTheme;
        break;
      case 'cyan':
        _data = AppThemeCyan.lightTheme;
        break;
      case 'pink':
        _data = AppThemePink.lightTheme;
        break;
      case 'purple':
        _data = AppThemePurple.lightTheme;
        break;
      case 'orange':
        _data = AppThemeOrange.lightTheme;
        break;
      case 'yellow':
        _data = AppThemeYellow.lightTheme;
        break;
      case 'black':
        _data = AppThemeBlack.lightTheme;
        break;
      case 'white':
        _data = AppThemeWhite.lightTheme;
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

  void setTheme(ThemeEnum enumData) {
    ThemeData data = switch (enumData) {
      ThemeEnum.red => AppThemeRed.lightTheme,
      ThemeEnum.green => AppThemeGreen.lightTheme,
      ThemeEnum.yellow => AppThemeYellow.lightTheme,
      ThemeEnum.orange => AppThemeOrange.lightTheme,
      ThemeEnum.defaultTheme => AppThemeDefault.lightTheme,
      ThemeEnum.blue => AppThemeBlue.lightTheme,
      ThemeEnum.cyan => AppThemeCyan.lightTheme,
      ThemeEnum.pink => AppThemePink.lightTheme,
      ThemeEnum.purple => AppThemePurple.lightTheme,
      ThemeEnum.black => AppThemeBlack.lightTheme,
      ThemeEnum.white => AppThemeWhite.lightTheme,
    };
    PreferencesDB.instance.setMultipleThemesMode(enumData.name);
    _data = data;
    state = AsyncData(_data);
  }

  /// Toggles the current brightness between light and dark.
  // void switchTheme() {
  //   // var dataTheme =
  //   //     _data.brightness == Brightness.dark ? _lightTheme : _darkTheme;
  //   // _data = dataTheme;
  //   // LoggerTools.looger.d('_dataswitchTheme: ${_data.brightness} ');
  //   //_setSystemUiOverlayStyle();
  //   List data = getThemeList();
  //   var randomInt = Random().nextInt(data.length);
  //   _data = data[randomInt];
  //   state = AsyncData(_data);
  // }

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
