import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novel_flutter_bit/entry/book_source_entry.dart';
import 'package:novel_flutter_bit/n_pages/detail/view_model/detail_view_model.dart';

@RoutePage()
class NewDetailPage extends ConsumerStatefulWidget {
  const NewDetailPage(
      {super.key, required this.detailUrl, required this.bookSourceEntry});
  final String detailUrl;
  final BookSourceEntry bookSourceEntry;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewDetailPageState();
}

class _NewDetailPageState extends ConsumerState<NewDetailPage> {
  @override
  Widget build(BuildContext context) {
    ref.watch(NewDetailViewModelProvider(
      detailUrl: widget.detailUrl,
      bookSource: widget.bookSourceEntry,
    ));
    return Scaffold(
      appBar: AppBar(title: const Text("详情")),
    );
  }
}
