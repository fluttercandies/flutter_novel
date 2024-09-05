import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/frame.dart';
import 'package:novel_flutter_bit/style/theme_style.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => ThemeStyleProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeStyleProvider>(builder:
        (BuildContext context, ThemeStyleProvider value, Widget? child) {
      //LoggerTools.looger.i('theme: ${value.theme.brightness}');
      return MaterialApp(
        title: 'Novel Reader',
        theme: value.theme,
        home: const FramePage(),
      );
    });
  }
}
