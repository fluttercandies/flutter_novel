import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/pages/home/view/home_page.dart';
import 'package:novel_flutter_bit/style/theme.dart';
import 'package:novel_flutter_bit/style/theme_style.dart';
import 'package:novel_flutter_bit/widget/border_buttom_navigation_bar.dart';
import 'package:provider/provider.dart';

@RoutePage()
class FramePage extends StatefulWidget {
  const FramePage({super.key});

  @override
  State<FramePage> createState() => _FramePageState();
}

class _FramePageState extends State<FramePage> {
  /// 当前选中的索引
  int _currentIndex = 0;
  int i = 0;
  @override
  Widget build(BuildContext context) {
    final MyColorsTheme myColors =
        Theme.of(context).extension<MyColorsTheme>()!;
    final themeData = context.read<ThemeStyleProvider>();
    return Scaffold(
      extendBody: true,
      body: const HomePage(),
      floatingActionButton: FloatingActionButton(
          onPressed: themeData.switchTheme,
          child: Icon(
              themeData.theme.brightness == Brightness.dark
                  ? Icons.nightlight
                  : Icons.wb_sunny,
              color: myColors.danger)),
      bottomNavigationBar: CustomBottomNavigationBar(
        borderRadius: 24,
        height: 70,
        items: const [Icon(Icons.home), Icon(Icons.star), Icon(Icons.people)],
        currentIndex: _currentIndex,
        onTap: (int value) {
          _currentIndex = value;
          setState(() {});
        },
      ),
    );
  }
}
