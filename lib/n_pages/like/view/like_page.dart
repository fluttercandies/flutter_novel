import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:novel_flutter_bit/n_pages/like/enrty/like_entry.dart';
import 'package:novel_flutter_bit/n_pages/like/state/like_state.dart';
import 'package:novel_flutter_bit/n_pages/like/view_model/like_view_model.dart';
import 'package:novel_flutter_bit/route/route.gr.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/image.dart';
import 'package:novel_flutter_bit/widget/loading.dart';
import 'package:novel_flutter_bit/widget/net_state_tools.dart';
import 'package:novel_flutter_bit/widget/pull_to_refresh.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

@RoutePage()
class LikePage extends ConsumerStatefulWidget {
  const LikePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LikePageState();
}

class _LikePageState extends ConsumerState<LikePage> {
  ThemeData get theme => Theme.of(context);

  /// 跳转详情页
  _toDeatilPage(LikeEntry entry) async {
    await context.router.push(NewDetailRoute(
      searchEntry: entry.searchEntry!,
      bookSourceEntry: entry.searchEntry!.bookSourceEntry!,
    ));
    ref.read(likeViewModelProvider.notifier).build();
  }

  @override
  Widget build(BuildContext context) {
    final likeViewModel = ref.watch(likeViewModelProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("我的书架")),
      body: switch (likeViewModel) {
        AsyncData(:final value) => Builder(builder: (BuildContext context) {
            Widget? child =
                NetStateTools.getWidget(value.netState, msg: "还没有收藏书籍哦！");
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

  _buildSuccess(LikeState value) {
    return DefaultTextStyle(
      style: const TextStyle(
          fontSize: 14,
          color: Colors.black54,
          fontWeight: FontWeight.w300,
          overflow: TextOverflow.ellipsis),
      child: PullToRefreshNotification(
        reachToRefreshOffset: 100,
        onRefresh: ref.read(likeViewModelProvider.notifier).onRefresh,
        child: CustomScrollView(
          slivers: [
            PullToRefresh(
              backgroundColor: theme.primaryColor,
              textColor: Colors.white,
            ),
            SliverPadding(
              padding: 8.padding,
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    mainAxisExtent: 230),
                itemBuilder: (c, i) {
                  return _buildItem(value.likeList![i]);
                  //  DefaultTextStyle(
                  //     style: const TextStyle(
                  //         fontSize: 14,
                  //         color: Colors.black54,
                  //         fontWeight: FontWeight.w300,
                  //         overflow: TextOverflow.ellipsis),
                  //     child:
                  // MasonryGridView.count(
                  //   crossAxisCount: 3,
                  //   mainAxisSpacing: 6,
                  //   crossAxisSpacing: 5,
                  //   padding: 10.padding,
                  //   itemBuilder: (c, i) {
                  //     return _buildItem(value.likeList![i]);
                  //   },
                  //   itemCount: value.likeList?.length,
                  // ),
                  //       );
                },
                itemCount: value.likeList?.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 构建item
  _buildItem(LikeEntry entry) {
    return GestureDetector(
      onTap: () => _toDeatilPage(entry),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, // 阴影的颜色
                  offset: Offset(2.0, 2.0), // 阴影在x轴和y轴的偏移量
                  blurRadius: 5.0, // 阴影的模糊程度
                  spreadRadius: 1.0 // 阴影的扩散程度
                  )
            ],
            color: const Color(0xfffafafa)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(5)),
              child: ExtendedImage.network(
                entry.searchEntry?.coverUrl ?? "",
                width: double.infinity,
                height: 160,
                fit: BoxFit.cover,
              ),
            ),
            Flexible(
              child: Padding(
                padding: 3.padding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.searchEntry?.name ?? "",
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: "阅:",
                          style: TextStyle(color: theme.primaryColor)),
                      TextSpan(text: entry.chapter?.chapterName ?? "")
                    ])),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: "来源:",
                          style: TextStyle(color: theme.primaryColor)),
                      TextSpan(
                          text: entry.searchEntry?.bookSourceEntry
                                  ?.bookSourceName ??
                              "")
                    ])),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
