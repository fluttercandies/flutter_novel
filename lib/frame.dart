import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/widget/border_buttom_navigation_bar.dart';

class FramePage extends StatefulWidget {
  const FramePage({super.key});

  @override
  State<FramePage> createState() => _FramePageState();
}

class _FramePageState extends State<FramePage> {
  /// 当前选中的索引
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(),
      bottomNavigationBar: CustomBottomNavigationBar(
        items: const [Icon(Icons.home), Icon(Icons.star), Icon(Icons.people)],
        currentIndex: _currentIndex,
        onTap: (int value) {
          _currentIndex = value;
          setState(() {});
        },
      ),
      //     CustomBottomNavigationBar1(
      //   currentIndex: _currentIndex,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.star), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.people), label: '')
      //   ],
      //   onTap: (int value) {
      //     _currentIndex = value;
      //     setState(() {});
      //   },
      // )
    );
  }
}
