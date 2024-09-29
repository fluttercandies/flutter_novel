import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novel_flutter_bit/entry/book_source_entry.dart';
import 'package:novel_flutter_bit/n_pages/home/view_model/home_view_model.dart';
import 'package:novel_flutter_bit/n_pages/search/view_model/search_view_model.dart';

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
    ref.watch(NewSearchViewModelProvider(
        searchKey: widget.searchKey, bookSourceEntry: sourceEntry!));
    return Center(child: Text(widget.searchKey));
  }
}
