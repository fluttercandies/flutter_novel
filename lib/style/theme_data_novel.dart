import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/style/theme_novel.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'theme_data_novel.g.dart';

/// 主题颜色
@riverpod
class ThemeDataNovel extends _$ThemeDataNovel {
  static const Color _colorLight = Color(0xfff87038);
  static const Color _colorDark = Color.fromARGB(255, 114, 74, 184);
  static get color => _colorLight;
  ThemeData get theme => _data;
  bool isInit = false;

  /// 主题
  late ThemeData _data = ThemeData(
    fontFamily: 'MiSans',
  );

  /// 浅色主题
  late ThemeData _lightTheme;

  /// 深色主题
  late ThemeData _darkTheme;

  /// 初始化
  @override
  Future<ThemeData> build() async {
    initTheme();
    return _data;
  }

  /// 初始化主题
  void initTheme({double? size}) {
    if (size != null) {
      isInit = false;
    }
    if (!isInit) {
      LoggerTools.looger.f('init ThemeStyleProvider');
      _lightTheme = _data.copyWith(
        extensions: <ThemeExtension<dynamic>>[
          NovelTheme(
              fontSize: size ?? 18,
              selectedColor: _colorLight,
              notSelectedColor: Colors.black,
              bottomAppBarColor: Colors.white,
              backgroundColor: const Color(0xfffafafa))
        ],
      );
      _darkTheme = _data.copyWith(
        extensions: <ThemeExtension<dynamic>>[
          NovelTheme(
              fontSize: size ?? 18,
              selectedColor: _colorDark,
              notSelectedColor: Colors.black,
              bottomAppBarColor: const Color.fromARGB(255, 251, 248, 255),
              backgroundColor: const Color(0xfffff9fe))
        ],
      );
      //_setSystemUiOverlayStyle();
      _data = _lightTheme;
      state = AsyncData(_data);
      isInit = true;
    }
  }

  /// Toggles the current brightness between light and dark.
  void switchTheme() {
    var dataTheme =
        _data.brightness == Brightness.dark ? _lightTheme : _darkTheme;
    _data = dataTheme;
    LoggerTools.looger.d('_dataswitchTheme: ${_data.brightness} ');
    //_setSystemUiOverlayStyle();
    state = AsyncData(_data);
  }

  /// 设置状态栏样式
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
