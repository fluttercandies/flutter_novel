import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class LikePage extends ConsumerStatefulWidget {
  const LikePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LikePageState();
}

class _LikePageState extends ConsumerState<LikePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的书架"),
      ),
    );
  }
}
