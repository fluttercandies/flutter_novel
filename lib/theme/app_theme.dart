import 'package:flutter/material.dart';

/// 当前深色模式
///
/// [mode] system(默认)：跟随系统 light：普通 dark：深色
ThemeMode darkThemeMode(String mode) => switch (mode) {
      'system' => ThemeMode.system,
      'dark' => ThemeMode.dark,
      'light' => ThemeMode.light,
      _ => ThemeMode.system,
    };
