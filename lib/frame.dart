import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/style/theme.dart';
import 'package:novel_flutter_bit/style/theme_style.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:novel_flutter_bit/widget/border_buttom_navigation_bar.dart';
import 'package:provider/provider.dart';

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
    final MyColors myColors = Theme.of(context).extension<MyColors>()!;
    final themeData = context.read<ThemeStyleProvider>();
    return Scaffold(
      extendBody: true,
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
