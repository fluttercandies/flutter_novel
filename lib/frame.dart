import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:novel_flutter_bit/icons/novel_icon_icons.dart';
import 'package:novel_flutter_bit/pages/home/view/home_page.dart';
import 'package:novel_flutter_bit/style/theme.dart';
import 'package:novel_flutter_bit/style/theme_style.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:novel_flutter_bit/widget/border_buttom_navigation_bar.dart';
import 'package:provider/provider.dart';

@RoutePage()
class FramePage extends ConsumerStatefulWidget {
  const FramePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FramePageState();
}

class _FramePageState extends ConsumerState<FramePage> {
  /// 当前选中的索引
  int _currentIndex = 0;
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: const HomePage(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.read(themeStyleProviderProvider.notifier).switchTheme();
            setState(() {});
          }, //themeData.switchTheme,
          child: Icon(
              ref.read(themeStyleProviderProvider.notifier).theme.brightness ==
                      Brightness.dark
                  ? Icons.nightlight
                  : Icons.wb_sunny,
              color: Colors.amberAccent //myColors.containerColor
              )),
      bottomNavigationBar: CustomBottomNavigationBar(
        borderRadius: 24,
        height: 70,
        items: const [
          Icon(NovelIcon.meteor),
          Icon(NovelIcon.cat),
          Icon(NovelIcon.heart),
        ],
        currentIndex: _currentIndex,
        onTap: (int value) {
          _currentIndex = value;
          setState(() {});
        },
      ),
    );
  }
}
