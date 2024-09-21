import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/base/base_view_model.dart';
import 'package:novel_flutter_bit/net/http_config.dart';
import 'package:novel_flutter_bit/net/net_state.dart';
import 'package:novel_flutter_bit/net/novel_http.dart';
import 'package:novel_flutter_bit/net/service_result.dart';
import 'package:novel_flutter_bit/pages/category/enum/category_enum.dart';
import 'package:novel_flutter_bit/pages/category/state/category_state.dart';
import 'package:novel_flutter_bit/pages/home/entry/novel_hot_entry.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'category_view_model.g.dart';

@riverpod
class CategoryViewModel extends _$CategoryViewModel
    implements BaseViewModelImplements {
  /// 创建state
  CategoryState categoryState = CategoryState();

  late CategoryEnum _categoryEnum;

  @override
  Future<bool> onRefresh() async {
    LoggerTools.looger.d("分类页面刷新 onRefresh Vlaue : ${categoryState.netState}");
    _initData();
    await Future.delayed(const Duration(seconds: 1));
    LoggerTools.looger.d("分类页面刷新 onRefresh Vlaue : ${categoryState.netState}");
    return true;
  }

  @override
  Future<CategoryState> build({required CategoryEnum categoryEnum}) async {
    LoggerTools.looger.d("CategoryViewModel init build");
    _categoryEnum = categoryEnum;
    _initData();
    //initIndex(categoryEnum: categoryEnum);
    return categoryState;
  }

  void _initData() async {
    categoryState.netState = NetState.loadingState;
    ServiceResultData resultData = await NovelHttp().request('hot',
        params: {'category': _categoryEnum.name}, method: HttpConfig.get);
    LoggerTools.looger.d(resultData.success);
    if (resultData.data case null) {
      /// 没有更多数据了
      categoryState.netState = NetState.emptyDataState;
      state = AsyncData(categoryState);
      return;
    }
    categoryState.netState = NetStateTools.handle(resultData);
    if (categoryState.netState == NetState.dataSuccessState) {
      NovelHot novelHot = NovelHot.fromJson(resultData.data);
      if (novelHot.data case null) {
        categoryState.netState = NetState.emptyDataState;
      }

      /// 赋值
      categoryState.novelHot = novelHot;
      LoggerTools.looger.i(categoryState.netState);
      state = AsyncData(categoryState);
    }
  }

  /// 初始化索引
  // int initIndex({required CategoryEnum categoryEnum}) {
  //   return CategoryEnum.values.indexOf(categoryEnum);
  // }
}
