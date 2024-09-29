import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novel_flutter_bit/entry/book_source_entry.dart';
import 'package:novel_flutter_bit/n_pages/home/view_model/home_view_model.dart';
import 'package:novel_flutter_bit/n_pages/search/entry/search_entry.dart';
import 'package:novel_flutter_bit/n_pages/search/view_model/search_view_model.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/loading.dart';
import 'package:novel_flutter_bit/widget/net_state_tools.dart';

@RoutePage()
class NewSearchPage extends ConsumerStatefulWidget {
  const NewSearchPage({super.key, required this.searchKey});
  final String searchKey;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<NewSearchPage> {
  late BookSourceEntry? sourceEntry;
  @override
  void initState() {
    super.initState();
    sourceEntry =
        ref.read(homeViewModelProvider.notifier).homeState.sourceEntry;
  }

  @override
  Widget build(BuildContext context) {
    final newSearchViewModelProvider = ref.watch(NewSearchViewModelProvider(
        searchKey: widget.searchKey, bookSourceEntry: sourceEntry!));
    return Scaffold(
      appBar: AppBar(title: Text(widget.searchKey)),
      body: switch (newSearchViewModelProvider) {
        AsyncData(:final value) => Builder(builder: (_) {
            return NetStateTools.getWidget(value.netState) ??
                _buildSuccess(searchList: value.searchList);
          }),
        AsyncError() => EmptyBuild(),
        _ => const LoadingBuild(),
      },
    );
  }

  _buildSuccess({List<SearchEntry>? searchList}) {
    return ListView.builder(
        itemCount: searchList?.length ?? 0,
        itemBuilder: (context, index) {
          debugPrint(index.toString());
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Text(searchList![index].name ?? ""),
          );
        });
  }
}
