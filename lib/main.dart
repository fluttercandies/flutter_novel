import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:novel_flutter_bit/route/route.dart';
import 'package:novel_flutter_bit/style/theme_style.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/loading.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

void main() {
  runApp(
      // ChangeNotifierProvider(
      //   create: (_) => ThemeStyleProvider(),
      //   child:
      ProviderScope(child: MyApp())
      //)
      );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // make sure you don't initiate your router
  // inside of the build function.
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      //LoggerTools.looger.i('theme: ${value.theme.brightness}');
      final theme = ref.watch(themeStyleProviderProvider);
      return Center(
        child: switch (theme) {
          AsyncData(:final value) => _buildSuccess(value),
          AsyncError() => const EmptyBuild(),
          _ => const LoadingBuild(),
        },
      );
    });
  }

  _buildSuccess(ThemeData theme) {
    return MaterialApp.router(
      title: 'Novel',
      theme: theme,
      routerDelegate: _appRouter.delegate(
        navigatorObservers: () => [FlutterSmartDialog.observer],
      ),
      builder: FlutterSmartDialog.init(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
// siwtch(theme){
//         AsyncData(:final value)=>
// MaterialApp.router(
//         //routerConfig: _appRouter.config(),
//         title: 'Novel',
//         theme: theme.value,
//         routerDelegate: _appRouter.delegate(
//           navigatorObservers: () => [FlutterSmartDialog.observer],
//         ),
//         builder: FlutterSmartDialog.init(),
//         routeInformationParser: _appRouter.defaultRouteParser(),
//       ),
//       AsyncError()=>const Text('error'),
//       _=>CircularProgressIndicator
//       }