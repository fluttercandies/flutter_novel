import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/base/base_provider.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/pages/home/view_model/view_model.dart';
import 'package:novel_flutter_bit/style/theme.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';
import 'package:novel_flutter_bit/widget/barber_pole_progress_bar.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('每日推荐')),
      body: ProviderConsumer<HomeViewModel>(
        viewModel: _viewModel,
        builder: (BuildContext context, HomeViewModel value, Widget? child) {
          if (value.homeState.netState == NetState.loadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return PullToRefreshNotification(
              onRefresh: value.onRefresh,
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                      sliver: const SliverToBoxAdapter(
                          child: Text('我的阅读', style: TextStyle(fontSize: 20))),
                      padding: 10.padding),
                  SliverToBoxAdapter(
                    child: _buildReadList(value),
                  )
                ],
              ));
        },
      ),
    );
  }

  double progress = .5;

  /// 阅读列表
  _buildReadList(HomeViewModel value,
      {double height = 260, double widthItem = 150}) {
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
                progress: progress.clamp(0, 1));
          }),
    );
  }

  /// 阅读列表item
  _buildReadItem(
      {required String url,
      required String bookName,
      required double progress,
      required double width}) {
    final MyColorsTheme myColors =
        Theme.of(context).extension<MyColorsTheme>()!;
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
      child: DefaultTextStyle(
        style: TextStyle(color: myColors.textColorHomePage),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ExtendedImage.network(
                  url,
                  cache: true,
                  width: width,
                  loadStateChanged: (state) {
                    switch (state.extendedImageLoadState) {
                      case LoadState.loading:
                        return const Center(child: CircularProgressIndicator());
                      case LoadState.completed:
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: ExtendedRawImage(
                              image: state.extendedImageInfo?.image,
                              fit: BoxFit.cover),
                        );
                      case LoadState.failed:
                        return LayoutBuilder(builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return const Center(child: Text("加载失败"));
                        });
                    }
                  },
                ),
              ),
              1.verticalSpace,
              Padding(
                padding: 10.horizontal,
                child: Text(bookName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15)),
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
      ),
    );
  }
}
