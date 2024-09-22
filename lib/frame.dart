import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novel_flutter_bit/icons/novel_icon_icons.dart';
import 'package:novel_flutter_bit/pages/category/view/category_page.dart';
import 'package:novel_flutter_bit/pages/home/view/home_page.dart';
import 'package:novel_flutter_bit/widget/border_buttom_navigation_bar.dart';

@RoutePage()
class FramePage extends ConsumerStatefulWidget {
  const FramePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FramePageState();
}

class _FramePageState extends ConsumerState<FramePage>
    with WidgetsBindingObserver {
  /// 当前选中的索引
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  bool ishidden = false;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    ishidden = state != AppLifecycleState.resumed;
    setState(() {
      debugPrint("state=$state");
    });
  }

  List<Widget> pages = [
    const HomePage(),
    const CategoryPage(),
    Container(
      color: Colors.amber,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
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
