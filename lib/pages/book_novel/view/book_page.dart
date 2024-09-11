import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/base/base_provider.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/pages/book_novel/entry/book_entry.dart';
import 'package:novel_flutter_bit/pages/book_novel/view_model/book_view_model.dart';
import 'package:novel_flutter_bit/route/route.gr.dart';
import 'package:novel_flutter_bit/style/theme.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/loading.dart';
import 'package:novel_flutter_bit/widget/pull_to_refresh.dart';
import 'package:novel_flutter_bit/widget/special_text_span_builder.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

@RoutePage()
class BookPage extends StatefulWidget {
  const BookPage({super.key, required this.name});
  final String name;
  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  /// 创建viewModel
  late BookViewModel _bookViewModel;
  @override
  void initState() {
    super.initState();
    _bookViewModel = BookViewModel(widget.name);
    _bookViewModel.getData();
  }

  /// 跳转详情页
  _onToDetailPage(BookDatum? data) {
    context.router.push(DetailRoute(bookDatum: data ?? BookDatum()));
  }

  @override
  Widget build(BuildContext context) {
    final MyColorsTheme myColors =
        Theme.of(context).extension<MyColorsTheme>()!;
    return Scaffold(
        appBar: AppBar(title: Text(widget.name)),
        body: ProviderConsumer<BookViewModel>(
            viewModel: _bookViewModel,
            builder:
                (BuildContext context, BookViewModel value, Widget? child) {
              if (value.bookState.netState == NetState.loadingState) {
                return const LoadingBuild();
              }

              if (value.bookState.netState == NetState.emptyDataState) {
                return const EmptyBuild();
              }
              return _buildSuccess(value, myColors: myColors);
            }));
  }

  /// 成功 构建器
  _buildSuccess(BookViewModel value, {required MyColorsTheme myColors}) {
    return FadeIn(
      child: DefaultTextStyle(
        style: TextStyle(
            color: myColors.bookTitleColor,
            fontSize: 18,
            fontWeight: FontWeight.w300),
        child: PullToRefreshNotification(
          onRefresh: value.onRefresh,
          reachToRefreshOffset: 100,
          child: CustomScrollView(slivers: [
            PullToRefresh(
              backgroundColor: myColors.brandColor ?? Colors.grey.shade400,
              textColor: Colors.white,
            ),
            SliverPadding(
              padding: 20.padding,
              sliver: const SliverToBoxAdapter(
                  child: Text("站源", style: TextStyle(fontSize: 24))),
            ),
            SliverPadding(
              padding: 20.horizontal,
              sliver: _buildList(value, myColors: myColors),
            )
          ]),
        ),
      ),
    );
  }

  /// list
  _buildList(BookViewModel value, {required MyColorsTheme myColors}) {
    return SliverList.separated(
      itemCount: value.bookState.bookEntry?.data?.length ?? 0,
      itemBuilder: (context, index) {
        return _buildItem(value.bookState.bookEntry?.data?[index],
            myColors: myColors,
            onTap: () =>
                _onToDetailPage(value.bookState.bookEntry?.data?[index]));
      },
      separatorBuilder: (BuildContext context, int index) {
        return 20.verticalSpace;
      },
    );
  }

  /// item
  _buildItem(BookDatum? data,
      {required MyColorsTheme myColors, required void Function()? onTap}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(children: [
              const TextSpan(text: "来源"),
              const TextSpan(text: "："),
              TextSpan(
                  text: "${data?.name}",
                  style: TextStyle(color: myColors.bookBodyColor))
            ]),
          ),
          Text.rich(
            TextSpan(children: [
              const TextSpan(text: "最新章节"),
              const TextSpan(text: "："),
              TextSpan(
                  text: "${data?.datumNew}",
                  style: TextStyle(color: myColors.bookTitleColor))
            ]),
          ),
        ],
      ),
    );
  }

  /// 富文本Demo
  _buildDemoExtendedText({required String title, required String body}) {
    final NovleSpecialTextSpanBuilder builder = NovleSpecialTextSpanBuilder();

    return ExtendedText.rich(
      gradientConfig: GradientConfigClass.config,
      TextSpan(
        children: [
          IgnoreGradientTextSpan(
            text: title,
          ),
          builder.build("123"),
          IgnoreGradientTextSpan(
            text: body,
          ),
        ],
      ),
    );
  }
}
