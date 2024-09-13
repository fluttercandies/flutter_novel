import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/base/base_view_model.dart';
import 'package:novel_flutter_bit/net/http_config.dart';
import 'package:novel_flutter_bit/net/net_state.dart';
import 'package:novel_flutter_bit/net/novel_http.dart';
import 'package:novel_flutter_bit/net/service_result.dart';
import 'package:novel_flutter_bit/pages/book_novel/entry/book_entry.dart';
import 'package:novel_flutter_bit/pages/book_novel/state/book_state.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'book_view_model.g.dart';

@riverpod
class BookViewModel extends _$BookViewModel implements BaseViewModelImplements {
  // BookViewModel(this.name) : super();

  /// 书名
  late String name;

  /// 创建state
  BookState bookState = BookState();

  @override
  Future<bool> onRefresh() async {
    LoggerTools.looger.d("book站源 onRefresh Vlaue : ${bookState.netState}");
    getData();
    await Future.delayed(const Duration(seconds: 1));
    LoggerTools.looger.d("book站源 onRefresh Vlaue : ${bookState.netState}");
    // bool value = bookState.netState == NetState.dataSuccessState;
    return true;
  }

  @override
  Future<BookState> build({required String nameBook}) async {
    LoggerTools.looger.d("book站源 build Vlaue : name = $nameBook");
    name = nameBook;
    getData();
    return bookState;
  }

  void getData() async {
    ServiceResultData resultData = await NovelHttp()
        .request('book', params: {'name': name}, method: HttpConfig.get);
    LoggerTools.looger.d(resultData.success);
    if (resultData.data case null) {
      /// 没有更多数据了
      bookState.netState = NetState.emptyDataState;
      state = AsyncData(bookState);
      return;
    }
    bookState.netState = NetStateTools.handle(resultData);
    if (bookState.netState == NetState.dataSuccessState) {
      BookEntry bookEntry = BookEntry.fromJson(resultData.data);
      if (bookEntry.data case null) {
        bookState.netState = NetState.emptyDataState;
      }

      /// 赋值
      bookState.bookEntry = bookEntry;
      LoggerTools.looger.i(bookState.bookEntry);
      state = AsyncData(bookState);
    }
  }
}
