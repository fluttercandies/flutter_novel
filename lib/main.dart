import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:novel_flutter_bit/frame.dart';
import 'package:novel_flutter_bit/style/theme_style.dart';

void main() {
  // 设置状态栏为透明
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Novel Reader',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ThemeStyle.color),
        useMaterial3: true,
      ),
      home: const FramePage(),
    );
  }
}
