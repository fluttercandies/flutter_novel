import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/widget/border_buttom_navigation_bar.dart';

class FramePage extends StatefulWidget {
  const FramePage({super.key});

  @override
  State<FramePage> createState() => _FramePageState();
}

class _FramePageState extends State<FramePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        color: Colors.red,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "更多"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "我的")
        ],
        currentIndex: 0,
        onTap: (int value) {},
      ),
    );
  }
}
