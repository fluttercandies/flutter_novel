import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:novel_flutter_bit/route/route.dart';
import 'package:novel_flutter_bit/style/theme_style.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/loading.dart';

void main() {
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark, // 状态栏图标颜色
      statusBarBrightness: Brightness.light, // 状态栏文字颜色
    ));
  }
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);
  runApp(ProviderScope(child: MyApp()));

  /// 强制竖屏
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // make sure you don't initiate your router
  // inside of the build function.
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      LoggerTools.looger.d("MyApp Page build");
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

  /// build
  _buildSuccess(ThemeData theme) {
    return MaterialApp.router(
      title: '好看',
      theme: theme,
      routerDelegate: _appRouter.delegate(
        navigatorObservers: () => [FlutterSmartDialog.observer],
      ),
      builder: FlutterSmartDialog.init(
          // toastBuilder: (msg) => Container(
          //     alignment: Alignment.center,
          //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          //     decoration: BoxDecoration(
          //       color: theme.primaryColor,
          //       borderRadius: BorderRadius.circular(6),
          //     ),
          //     child: Text(
          //       msg,
          //       style: const TextStyle(color: Colors.white),
          //     )),
          ),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
