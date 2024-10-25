import 'dart:typed_data';

import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/n_pages/detail/entry/detail_book_entry.dart';

class ReadState extends BaseState {
  /// 阅读内容
  String? content;

  /// 阅读内容
  List<String>? listContent;

  /// 章节列表
  List<Chapter>? chapterList;

  /// 背景图片
  Uint8List? backgroundImage;

  /// 背景颜色
  int? backgroundColor;

  /// 文本颜色
  int? textColor;

  /// 选中文本
  int? selectText;
}
