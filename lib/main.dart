import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:novel_flutter_bit/route/route.dart';
import 'package:novel_flutter_bit/style/theme_style.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => ThemeStyleProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // make sure you don't initiate your router
  // inside of the build function.
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeStyleProvider>(builder:
        (BuildContext context, ThemeStyleProvider value, Widget? child) {
      //LoggerTools.looger.i('theme: ${value.theme.brightness}');
      return MaterialApp.router(
        //routerConfig: _appRouter.config(),
        title: 'Novel',
        theme: value.theme,
        routerDelegate: _appRouter.delegate(
          navigatorObservers: () => [FlutterSmartDialog.observer],
        ),
        builder: FlutterSmartDialog.init(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      );
    });
  }
}
