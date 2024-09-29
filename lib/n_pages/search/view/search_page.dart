import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class NewSearchPage extends ConsumerStatefulWidget {
  const NewSearchPage({super.key, required this.searchKey});
  final String searchKey;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<NewSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
