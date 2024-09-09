import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/pages/book_novel/entry/book_entry.dart';

@RoutePage()
class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.bookDatum});
  final BookDatum bookDatum;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
