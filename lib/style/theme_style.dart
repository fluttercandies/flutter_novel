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
      //ThemeEnum.white: AppThemeWhite.lightTheme,
    };
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
      // case 'white':
      //   _data = AppThemeWhite.lightTheme;
      //   break;
      default:
        _data = AppThemeDefault.lightTheme;
    }
    state = AsyncData(_data);
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
      //ThemeEnum.white => AppThemeWhite.lightTheme,
    };
    PreferencesDB.instance.setMultipleThemesMode(enumData.name);
    _data = data;
    state = AsyncData(_data);
  }
}
