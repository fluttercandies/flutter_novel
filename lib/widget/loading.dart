import 'package:flutter/material.dart';

/// 加载中
class LoadingBuild extends StatelessWidget {
  const LoadingBuild({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
