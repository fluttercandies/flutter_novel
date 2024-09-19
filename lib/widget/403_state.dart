// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Build403 extends StatelessWidget {
  const Build403({super.key});

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
        const Text('服务器维护中', style: TextStyle(fontSize: 16))
      ],
    ));
  }
}
