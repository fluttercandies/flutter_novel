import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/pages/novel/view_model/novel_view_model.dart';

@RoutePage()
class NovelPage extends StatefulWidget {
  const NovelPage({super.key, required this.url});
  final String url;
  @override
  State<NovelPage> createState() => _NovelPageState();
}

class _NovelPageState extends State<NovelPage> {
  late NovelViewModel _novelViewModel;
  @override
  void initState() {
    super.initState();
    _novelViewModel = NovelViewModel(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${_novelViewModel.novelState.novelEntry.data?.name}"),
      ),
    );
  }
}
