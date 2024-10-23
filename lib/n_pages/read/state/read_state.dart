import 'dart:typed_data';

import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/n_pages/detail/entry/detail_book_entry.dart';

class ReadState extends BaseState {
  String? content;
  List<String>? listContent;
  List<Chapter>? chapterList;
  Uint8List? backgroundImage;
}
