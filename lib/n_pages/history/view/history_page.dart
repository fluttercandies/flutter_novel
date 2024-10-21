import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novel_flutter_bit/n_pages/history/entry/history_entry.dart';
import 'package:novel_flutter_bit/n_pages/history/state/history_state.dart';
import 'package:novel_flutter_bit/n_pages/history/view_model/history_view_model.dart';
import 'package:novel_flutter_bit/route/route.gr.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/loading.dart';
import 'package:novel_flutter_bit/widget/net_state_tools.dart';
import 'package:novel_flutter_bit/widget/pull_to_refresh.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

@RoutePage()
class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  /// 列表布局
  late SliverGridDelegate _sliverGridDelegate;

  /// 主题
  ThemeData get theme => Theme.of(context);

  /// 跳转详情页
  _toDeatilPage(HistoryEntry entry) async {
    await context.router.push(NewDetailRoute(
      searchEntry: entry.searchEntry!,
      bookSourceEntry: entry.searchEntry!.bookSourceEntry!,
    ));
    ref.read(historyViewModelProvider.notifier).onRefresh();
  }

  /// 初始化列表布局
  _initSliverGridDelegate() {
    _sliverGridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, mainAxisExtent: 70, crossAxisSpacing: 10);
    if (Platform.isWindows || Platform.isMacOS) {
      _sliverGridDelegate = const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 90,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 16 / 9);
    }
  }

  @override
  void initState() {
    super.initState();
    _initSliverGridDelegate();
  }

  @override
  Widget build(BuildContext context) {
    final historyViewModel = ref.watch(historyViewModelProvider);
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        title: const Text("阅读记录"),
      ),
      body: switch (historyViewModel) {
        AsyncData(:final value) => Builder(builder: (_) {
            Widget? child =
                NetStateTools.getWidget(value.netState, msg: "还没有历史记录哦！");
            if (child != null) {
              return child;
            }
            return _buildSuccess(value);
          }),
        AsyncError() => EmptyBuild(),
        _ => const LoadingBuild(),
      },
    );
  }

  Widget _buildSuccess(HistoryState value) {
    return DefaultTextStyle(
      style: const TextStyle(
          overflow: TextOverflow.ellipsis,
          color: Colors.black54,
          fontSize: 14,
          fontWeight: FontWeight.w300),
      child: PullToRefreshNotification(
        reachToRefreshOffset: 140,
        onRefresh: ref.read(historyViewModelProvider.notifier).onRefresh,
        child: CustomScrollView(
          slivers: [
            PullToRefresh(
              backgroundColor: theme.primaryColor,
              textColor: Colors.white,
            ),
            SliverToBoxAdapter(
              child: 20.verticalSpace,
            ),
            SliverGrid.builder(
              gridDelegate: _sliverGridDelegate,
              itemBuilder: (c, i) {
                return _buildItem(value.historyList![i]);
              },
              itemCount: value.historyList?.length,
            )
          ],
        ),
      ),
    );
  }

  _buildItem(HistoryEntry entry) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _toDeatilPage(entry),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              child: ExtendedImage.network(
                entry.searchEntry?.coverUrl ?? "",
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            15.horizontalSpace,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text((entry.searchEntry?.name ?? ""),
                    style:
                        const TextStyle(fontSize: 16, color: Colors.black87)),
                5.verticalSpace,
                Row(
                  children: [
                    Expanded(child: Text(entry.chapter?.chapterName ?? "")),
                    Text(entry.dateTime ?? ""),
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
