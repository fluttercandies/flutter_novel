import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/base/base_provider.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/pages/home/view_model/view_model.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
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
    //_viewModel.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('每日推荐')),
      body: ProviderConsumer<HomeViewModel>(
        viewModel: _viewModel,
        builder: (BuildContext context, HomeViewModel value, Widget? child) {
          // if (value.homeState.netState == NetState.loadingState) {
          //   return const Center(child: CircularProgressIndicator());
          // }
          return PullToRefreshNotification(
              onRefresh: value.onRefresh,
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                      sliver: const SliverToBoxAdapter(
                          child: Text('我的阅读', style: TextStyle(fontSize: 20))),
                      padding: 20.padding),
                ],
              ));
        },
      ),
    );
  }
}
