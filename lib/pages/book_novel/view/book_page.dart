import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/pages/book_novel/entry/book_entry.dart';
import 'package:novel_flutter_bit/pages/book_novel/state/book_state.dart';
import 'package:novel_flutter_bit/pages/book_novel/view_model/book_view_model.dart';
import 'package:novel_flutter_bit/route/route.gr.dart';
import 'package:novel_flutter_bit/tools/net_state_tools.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/loading.dart';
import 'package:novel_flutter_bit/widget/pull_to_refresh.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

@RoutePage()
class BookPage extends ConsumerStatefulWidget {
  const BookPage({super.key, required this.name});
  final String name;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookPageState();
}

class _BookPageState extends ConsumerState<BookPage> {
  //late MyColorsTheme _myColors;
  @override
  void initState() {
    super.initState();
  }

  /// 跳转详情页
  _onToDetailPage(BookDatum? data) {
    context.router.push(DetailRoute(bookDatum: data ?? BookDatum()));
  }

  /// 下拉刷新
  Future<bool> _onRefresh() {
    return ref
        .read(bookViewModelProvider(nameBook: widget.name).notifier)
        .onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    //_myColors = Theme.of(context).extension<MyColorsTheme>()!;
    final bookViewModel =
        ref.watch(bookViewModelProvider(nameBook: widget.name));
    return Scaffold(
        appBar: AppBar(title: Text(widget.name)),
        body: switch (bookViewModel) {
          AsyncData(:final value) => Builder(builder: (BuildContext context) {
              //LoggerTools.looger.e(value.netState);
              Widget? child = NetStateTools.getWidget(value.netState);
              if (child != null) {
                return child;
              }
              return _buildSuccess(value: value);
            }),
          AsyncError() => const EmptyBuild(),
          _ => const LoadingBuild(),
        });
  }

  /// 成功 构建器
  _buildSuccess({required BookState value}) {
    return FadeIn(
      child: DefaultTextStyle(
        style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 18,
            fontWeight: FontWeight.w300),
        child: PullToRefreshNotification(
          onRefresh: _onRefresh,
          reachToRefreshOffset: 100,
          child: CustomScrollView(slivers: [
            PullToRefresh(
              backgroundColor: Theme.of(context).primaryColor,
              textColor: Colors.white,
            ),
            SliverPadding(
              padding: 20.padding,
              sliver: const SliverToBoxAdapter(
                  child: Text("站源", style: TextStyle(fontSize: 24))),
            ),
            SliverPadding(
              padding: 20.horizontal,
              sliver: _buildList(value: value),
            )
          ]),
        ),
      ),
    );
  }

  /// list
  _buildList({required BookState value}) {
    return SliverList.separated(
      itemCount: value.bookEntry?.data?.length ?? 0,
      itemBuilder: (context, index) {
        return _buildItem(value.bookEntry?.data?[index],
            onTap: () => _onToDetailPage(value.bookEntry?.data?[index]));
      },
      separatorBuilder: (BuildContext context, int index) {
        return 20.verticalSpace;
      },
    );
  }

  /// item
  _buildItem(BookDatum? data, {required void Function()? onTap}) {
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
                  style: TextStyle(color: Theme.of(context).primaryColor))
            ]),
          ),
          Text.rich(
            TextSpan(children: [
              const TextSpan(text: "最新章节"),
              const TextSpan(text: "："),
              TextSpan(text: "${data?.datumNew}")
            ]),
          ),
        ],
      ),
    );
  }
}
