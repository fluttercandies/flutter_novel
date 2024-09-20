import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novel_flutter_bit/pages/home/entry/novel_hot_entry.dart';
import 'package:novel_flutter_bit/pages/home/state/home_state.dart';
import 'package:novel_flutter_bit/pages/home/view_model/home_view_model.dart';
import 'package:novel_flutter_bit/route/route.gr.dart';
import 'package:novel_flutter_bit/tools/net_state_tools.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/image.dart';
import 'package:novel_flutter_bit/widget/loading.dart';
import 'package:novel_flutter_bit/widget/pull_to_refresh.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  //late MyColorsTheme _myColors;
  @override
  void initState() {
    super.initState();

    //final data = await PreferencesDB.instance.getNovleHistoryList();
  }

  /// 跳转小说 站源 列表 页面
  _onToBookPage(String name) {
    context.router.push(BookRoute(name: name));
  }

  @override
  Widget build(BuildContext context) {
    //_myColors = Theme.of(context).extension<MyColorsTheme>()!;
    final homeViewModel = ref.watch(homeViewModelProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('每日推荐')),
      body: SafeArea(
          child: switch (homeViewModel) {
        AsyncData(:final value) => Builder(builder: (BuildContext context) {
            //LoggerTools.looger.e(value.netState);
            return NetStateTools.getWidget(value.netState) ??
                _buildSuccess(value: value);
          }),
        AsyncError() => const EmptyBuild(),
        _ => const LoadingBuild(),
      }),
    );
  }

  /// 成功状态构建
  _buildSuccess({required HomeState value}) {
    return FadeIn(
      child: DefaultTextStyle(
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontSize: 17, fontWeight: FontWeight.w300),
        child: PullToRefreshNotification(
            reachToRefreshOffset: 100,
            onRefresh: ref.read(homeViewModelProvider.notifier).onRefresh,
            child: CustomScrollView(
              slivers: [
                PullToRefresh(
                  backgroundColor: Theme.of(context).primaryColor,
                  //_myColors.brandColor ?? Colors.grey.shade400,
                  textColor: Colors.white,
                ),
                SliverPadding(
                    sliver: const SliverToBoxAdapter(
                        child: Text(
                      '我的阅读',
                      style: TextStyle(fontSize: 20),
                    )),
                    padding: 10.padding),
                SliverToBoxAdapter(
                  child: _buildReadList(value: value),
                ),
                SliverPadding(
                    sliver: const SliverToBoxAdapter(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('全网最热', style: TextStyle(fontSize: 20)),
                        Icon(Icons.chevron_right)
                      ],
                    )),
                    padding: 10.padding),
                SliverList.builder(
                    itemCount: value.novelHot?.data?.length,
                    itemBuilder: (context, index) {
                      return _buildHotItem(value.novelHot?.data?[index],
                          onTap: _onToBookPage);
                    })
              ],
            )),
      ),
    );
  }

  /// 热门item
  _buildHotItem(Datum? novelHot,
      {double height = 180, required void Function(String str) onTap}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap.call(novelHot?.name ?? "");
      },
      child: SizedBox(
        height: height,
        child: Padding(
          padding: 10.padding,
          child: Row(
            children: [
              Flexible(
                  child: ExtendedImageBuild(
                      url: novelHot?.img ?? "", width: 120, height: height)),
              10.horizontalSpace,
              Expanded(
                flex: 2,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(novelHot?.name ?? "",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 20)),
                      5.verticalSpace,
                      Text("${novelHot?.author}/${novelHot?.type}",
                          style: const TextStyle(color: Colors.black54)),
                      5.verticalSpace,
                      Row(children: [
                        SvgPicture.asset(
                          'assets/svg/hot.svg',
                          width: 24,
                        ),
                        5.horizontalSpace,
                        Text(novelHot?.hot ?? "0",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor)),
                      ]),
                      5.verticalSpace,
                      Flexible(
                        child: Text(novelHot?.desc ?? "",
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54)),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 阅读列表
  _buildReadList(
      {required HomeState value, double height = 240, double widthItem = 130}) {
    return SizedBox(
      height: (value.dataHistory?.isEmpty ?? false) ? height : 0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: (value.dataHistory?.isEmpty ?? false)
              ? value.dataHistory?.length
              : 0,
          itemBuilder: (context, index) {
            return _buildReadItem(
              width: widthItem,
              url: value.dataHistory?[index].imageUrl ?? "",
              bookName: value.dataHistory?[index].name ?? "",
              readChapter: value.dataHistory?[index].readChapter ?? "",
            );
          }),
    );
  }

  /// 阅读列表item
  _buildReadItem(
      {required String url,
      required String bookName,
      required double width,
      required String readChapter}) {
    return Container(
      margin: 5.padding,
      constraints: BoxConstraints(maxWidth: width, minWidth: width),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.2),
                blurRadius: 8.0,
                spreadRadius: 0.5)
          ]),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child:
                  ExtendedImageBuild(url: url, width: width, isJoinUrl: true),
            ),
            3.verticalSpace,
            Padding(
              padding: 10.horizontal,
              child:
                  Text(bookName, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                "阅读至:$readChapter",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            3.verticalSpace,
            // Padding(
            //   padding: 5.horizontal,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       // Flexible(
            //       //     child: ClipRRect(
            //       //   borderRadius: BorderRadius.circular(5),
            //       //   child: LinearProgressIndicator(
            //       //     value: progress,
            //       //     color: Theme.of(context).primaryColor,
            //       //     backgroundColor:
            //       //         Theme.of(context).primaryColor.withOpacity(.2),
            //       //   ),
            //       // )
            //       // ),
            //       // BarberPoleProgressBar(
            //       //     progress: progress,
            //       //     animationEnabled: true,
            //       //     color: Theme.of(context).primaryColor,
            //       //     notArriveProgressAnimation: false)

            //       5.horizontalSpace,
            //       SizedBox(
            //           width: 40,
            //           child: Text('${(progress * 100).toStringAsFixed(0)}%'))
            //     ],
            //   ),
            // ),

            // 3.verticalSpace
          ]),
    );
  }
}
