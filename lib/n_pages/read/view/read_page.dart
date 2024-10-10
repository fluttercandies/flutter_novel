import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novel_flutter_bit/entry/book_source_entry.dart';
import 'package:novel_flutter_bit/n_pages/detail/entry/detail_book_entry.dart';
import 'package:novel_flutter_bit/n_pages/read/view_model/read_view_model.dart';

@RoutePage()
class ReadPage extends ConsumerStatefulWidget {
  const ReadPage({super.key, required this.chapter, required this.source});
  final Chapter chapter;
  final BookSourceEntry source;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReadPageState();
}

class _ReadPageState extends ConsumerState<ReadPage> {
  @override
  Widget build(BuildContext context) {
    final readViewModel = ref.watch(readViewModelProvider(
        chapter1: widget.chapter, bookSource: widget.source));
    return Scaffold(
        appBar: AppBar(
      title: Text(widget.chapter.chapterName ?? " 暂无标题"),
    ));
  }
}
