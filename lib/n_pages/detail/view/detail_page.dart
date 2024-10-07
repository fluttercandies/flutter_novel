import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novel_flutter_bit/entry/book_source_entry.dart';
import 'package:novel_flutter_bit/n_pages/detail/view_model/detail_view_model.dart';
import 'package:novel_flutter_bit/n_pages/search/entry/search_entry.dart';

@RoutePage()
class NewDetailPage extends ConsumerStatefulWidget {
  const NewDetailPage(
      {super.key, required this.searchEntry, required this.bookSourceEntry});
  final SearchEntry searchEntry;
  final BookSourceEntry bookSourceEntry;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewDetailPageState();
}

class _NewDetailPageState extends ConsumerState<NewDetailPage> {
  @override
  Widget build(BuildContext context) {
    ref.watch(NewDetailViewModelProvider(
      detailUrl: widget.searchEntry.url ?? "",
      bookSource: widget.bookSourceEntry,
    ));
    return Scaffold(
      appBar: AppBar(title: Text(widget.searchEntry.name ?? "")),
    );
  }
}
