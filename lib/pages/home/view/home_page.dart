import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/base/base_provider.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/pages/home/view_model/view_model.dart';
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

  /// 阅读列表
  _buildReadList(HomeViewModel value) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: value.homeState.novelHot?.data?.length,
          itemBuilder: (context, index) {
            return _buildReadItem(
                url: value.homeState.novelHot?.data?[index].img ?? "",
                bookName: value.homeState.novelHot?.data?[index].name ?? "",
                progress: .5);
          }),
    );
  }

  /// 阅读列表item
  _buildReadItem(
      {required String url,
      required String bookName,
      required double progress}) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      constraints: const BoxConstraints(maxWidth: 170, minWidth: 170),
      decoration: BoxDecoration(
          color: Colors.white,
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
            ExtendedImage.network(
              url,
              fit: BoxFit.cover,
              cache: true,
              loadStateChanged: (state) {
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    return const CircularProgressIndicator();
                  case LoadState.completed:
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                            maxHeight: 240, minHeight: 240, minWidth: 160),
                        child: ExtendedRawImage(
                            image: state.extendedImageInfo?.image,
                            fit: BoxFit.cover),
                      ),
                    );
                  case LoadState.failed:
                    return const Text("加载失败");
                }
              },
            ),
            Flexible(
              child: Padding(
                padding: 10.horizontal,
                child: Text(bookName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15)),
              ),
            ),
            Padding(
              padding: 5.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: BarberPoleProgressBar(progress: progress)
                      // ClipRRect(
                      //     borderRadius: BorderRadius.circular(8),
                      //     child: LinearProgressIndicator(value: progress)),
                      ),
                  5.horizontalSpace,
                  Text('${progress * 100.toInt()}%')
                ],
              ),
            )
          ]),
    );
  }
}
