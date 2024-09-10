import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/base/base_provider.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/pages/detail_novel/view/detail_page.dart';
import 'package:novel_flutter_bit/pages/novel/view_model/novel_view_model.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/loading.dart';

@RoutePage()
class NovelPage extends StatefulWidget {
  const NovelPage({super.key, required this.url, required this.name});
  final String url;
  final String name;
  @override
  State<NovelPage> createState() => _NovelPageState();
}

class _NovelPageState extends State<NovelPage> {
  late NovelViewModel _novelViewModel;
  @override
  void initState() {
    super.initState();
    _novelViewModel = NovelViewModel(widget.url);
    _novelViewModel.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: ProviderConsumer<NovelViewModel>(
        viewModel: _novelViewModel,
        builder: (BuildContext context, NovelViewModel value, Widget? child) {
          if (value.novelState.netState == NetState.loadingState) {
            return const LoadingBuild();
          }

          if (value.novelState.netState == NetState.emptyDataState) {
            return const EmptyBuild();
          }
          return Padding(
            padding: 10.padding,
            child: SingleChildScrollView(
              child: Text(
                value.novelState.novelEntry.data?.text ?? '',
              ),
            ),
          );
        },
      ),
    );
  }
}
