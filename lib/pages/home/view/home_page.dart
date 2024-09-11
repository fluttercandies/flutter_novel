import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novel_flutter_bit/base/base_provider.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/pages/home/entry/novel_hot_entry.dart';
import 'package:novel_flutter_bit/pages/home/view_model/home_view_model.dart';
import 'package:novel_flutter_bit/route/route.gr.dart';
import 'package:novel_flutter_bit/style/theme.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';
import 'package:novel_flutter_bit/widget/barber_pole_progress_bar.dart';
import 'package:novel_flutter_bit/widget/image.dart';
import 'package:novel_flutter_bit/widget/loading.dart';
import 'package:novel_flutter_bit/widget/pull_to_refresh.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = HomeViewModel();
  double progress = .5;
  @override
  void initState() {
    super.initState();
    _viewModel.getData();
  }

  /// 跳转小说 站源 列表 页面
  _onToBookPage(String name) {
    context.router.push(BookRoute(name: name));
  }

  @override
  Widget build(BuildContext context) {
    final MyColorsTheme myColors =
        Theme.of(context).extension<MyColorsTheme>()!;
    return Scaffold(
      appBar: AppBar(title: const Text('每日推荐')),
      body: SafeArea(
        child: ProviderConsumer<HomeViewModel>(
          viewModel: _viewModel,
          builder: (BuildContext context, HomeViewModel value, Widget? child) {
            if (value.homeState.netState == NetState.loadingState) {
              return const LoadingBuild();
            }
            return _buildSuccess(myColors: myColors, value: value);
          },
        ),
      ),
    );
  }

  /// 成功状态构建
  _buildSuccess(
      {required MyColorsTheme myColors, required HomeViewModel value}) {
    return FadeIn(
      child: DefaultTextStyle(
        style: TextStyle(
            color: myColors.textColorHomePage,
            fontSize: 16,
            fontWeight: FontWeight.w300),
        child: PullToRefreshNotification(
            reachToRefreshOffset: 100,
            onRefresh: value.onRefresh,
            child: CustomScrollView(
              slivers: [
                PullToRefresh(
                  backgroundColor: myColors.brandColor ?? Colors.grey.shade400,
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
                  child: _buildReadList(value,
                      progress: progress, myColors: myColors),
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
                    itemCount: value.homeState.novelHot?.data?.length,
                    itemBuilder: (context, index) {
                      return _buildHotItem(
                          value.homeState.novelHot?.data?[index],
                          myColors: myColors,
                          onTap: _onToBookPage);
                    })
              ],
            )),
      ),
    );
  }

  /// 热门item
  _buildHotItem(Datum? novelHot,
      {required MyColorsTheme myColors,
      double height = 180,
      required void Function(String str) onTap}) {
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
                            style: TextStyle(color: myColors.brandColor)),
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
  _buildReadList(HomeViewModel value,
      {required double progress,
      required MyColorsTheme myColors,
      double height = 280,
      double widthItem = 160}) {
    return SizedBox(
      height: height,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: value.homeState.novelHot?.data?.length,
          itemBuilder: (context, index) {
            return _buildReadItem(
                width: widthItem,
                url: value.homeState.novelHot?.data?[index].img ?? "",
                bookName: value.homeState.novelHot?.data?[index].name ?? "",
                progress: progress.clamp(0, 1),
                myColors: myColors);
          }),
    );
  }

  /// 阅读列表item
  _buildReadItem(
      {required String url,
      required String bookName,
      required double progress,
      required double width,
      required MyColorsTheme myColors}) {
    return Container(
      margin: 5.padding,
      constraints: BoxConstraints(maxWidth: width, minWidth: width),
      decoration: BoxDecoration(
          color: myColors.containerColor,
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
              child: ExtendedImageBuild(url: url, width: width),
            ),
            1.verticalSpace,
            Padding(
              padding: 10.horizontal,
              child:
                  Text(bookName, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
            1.verticalSpace,
            Padding(
              padding: 5.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: BarberPoleProgressBar(
                          progress: progress,
                          animationEnabled: true,
                          color: myColors.brandColor,
                          notArriveProgressAnimation: false)),
                  5.horizontalSpace,
                  SizedBox(
                      width: 40,
                      child: Text('${(progress * 100).toStringAsFixed(0)}%'))
                ],
              ),
            ),
            3.verticalSpace
          ]),
    );
  }
}
