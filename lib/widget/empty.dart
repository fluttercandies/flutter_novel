import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyBuild extends StatelessWidget {
  const EmptyBuild({super.key, this.text = "暂无数据"});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/svg/empty.svg',
          width: 240,
        ),
        Text(text, style: const TextStyle(fontSize: 18))
      ],
    ));
  }
}
