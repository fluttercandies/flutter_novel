import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:novel_flutter_bit/icons/novel_icon_icons.dart';
import 'package:novel_flutter_bit/n_pages/home/view/home_page.dart' as n;

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
    //// 配置toast
    SmartDialog.config.toast =
        SmartConfigToast(alignment: const Alignment(0, -.2), debounce: true);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
    const n.HomePage(),
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.green,
    ),
    // const CategoryPage(),
    // const CollectPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            iconSize: 18,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(NovelIcon.meteor), label: "首页"),
              BottomNavigationBarItem(icon: Icon(NovelIcon.cat), label: "其他"),
              BottomNavigationBarItem(icon: Icon(NovelIcon.heart), label: "收藏")
            ],
            onTap: (value) => setState(() => _currentIndex = value)
            //  CustomBottomNavigationBar(
            //   borderRadius: 24,
            //   height: 70,
            //   items: const [
            //     Icon(NovelIcon.meteor),
            //     Icon(NovelIcon.cat),
            //     Icon(NovelIcon.heart),
            //   ],
            //   currentIndex: _currentIndex,
            //   onTap: (int value) {
            //     _currentIndex = value;
            //     setState(() {});
            //   },
            // ),
            ));
  }
}
