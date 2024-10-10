import 'dart:convert';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/db/preferences_db.dart';
import 'package:novel_flutter_bit/entry/book_source_entry.dart';
import 'package:novel_flutter_bit/n_pages/detail/entry/detail_book_entry.dart';
import 'package:novel_flutter_bit/n_pages/detail/state/detail_state.dart';
import 'package:novel_flutter_bit/n_pages/read/state/read_state.dart';
import 'package:novel_flutter_bit/net/new_novel_http.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:novel_flutter_bit/tools/parse_source_rule.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'read_view_model.g.dart';

/// 阅读页面
/// 时间 2024-10-10
/// 7-bit
@riverpod
class ReadViewModel extends _$ReadViewModel {
  /// 创建state
  ReadState readState = ReadState();

  /// url
  late Chapter chapter;

  late BookSourceEntry _bookSourceEntry;
  @override
  Future<ReadState> build({
    required Chapter chapter1,
    required BookSourceEntry bookSource,
  }) async {
    LoggerTools.looger.d("NEW NewDetailViewModel init build");
    chapter = chapter1;
    _bookSourceEntry = bookSource;
    _initData(detailUrl: chapter1.chapterUrl ?? "");
    return readState;
  }

  void _initData({
    required String detailUrl,
  }) async {
    try {
      final resultData = await NewNovelHttp().request(detailUrl);
      final uint8List = resultData.data;
      resultData.data = ParseSourceRule.parseHtmlDecode(uint8List);
      final detailBook = ParseSourceRule.parseAllMatches(
          rule: _bookSourceEntry.ruleContent?.content ?? "",
          htmlData: resultData.data);

      if (detailBook.isEmpty) {
        readState.netState = NetState.emptyDataState;
        state = AsyncData(readState);
        return;
      }
      readState.content = detailBook[0];
      readState.netState = NetState.dataSuccessState;
      state = AsyncData(readState);
      LoggerTools.looger.d(detailBook.toString());
    } catch (e) {
      LoggerTools.looger.e("NewSearchViewModel _initData error:$e");
      // searchState.netState = NetState.error403State;
      // state = AsyncData(searchState);
      SmartDialog.showToast(e.toString());
    }
  }
}
