import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novel_flutter_bit/pages/collect_novle/enrty/collect_entry.dart';
import 'package:novel_flutter_bit/pages/collect_novle/state/collect_state.dart';
import 'package:novel_flutter_bit/pages/collect_novle/view_model/collect_view_model.dart';
import 'package:novel_flutter_bit/tools/net_state_tools.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/image.dart';
import 'package:novel_flutter_bit/widget/loading.dart';
import 'package:sliver_head_automatic_adsorption/sliver_head_automatic_adsorption.dart';

class CollectPage extends ConsumerStatefulWidget {
  const CollectPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CollectPageState();
}

class _CollectPageState extends ConsumerState<CollectPage> {
  final ScrollController _controller = ScrollController();
  late ThemeData _themeData;
  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    final collectViewModel = ref.watch(collectViewModelProvider);
    return Scaffold(
        body: DefaultTextStyle(
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w300,
          color: _themeData.textTheme.bodyLarge?.color),
      child: switch (collectViewModel) {
        AsyncData(:final value) => Builder(builder: (BuildContext context) {
            Widget? child = NetStateTools.getWidget(value.netState);
            if (child != null) {
              return child;
            }
            return _buildSuccess(value);
          }),
        AsyncError() => const EmptyBuild(),
        _ => const LoadingBuild(),
      },
    ));
  }

  _buildSuccess(CollectState value) {
    return SliverAdsorptionAppbar(
        controller: _controller,
        collapsedBrightness: Brightness.light,
        collapsedColors: _themeData.primaryColor,
        expandedColors: _themeData.scaffoldBackgroundColor,
        expandedHeight: 300,
        slivers: [
          SliverPadding(padding: 20.vertical),
          SliverPadding(
            padding: 5.horizontal,
            sliver: SliverGrid.builder(
              itemBuilder: (c, i) {
                return _buildGridItem(value.collectNovelList![i]);
              },
              itemCount: value.collectNovelList?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 220,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
            ),
          ),
          SliverPadding(
            padding: 0.padding,
            sliver: SliverFillRemaining(),
          )
        ],
        expandedWidget: Container(
          child: Padding(
              padding: 20.padding,
              child: Column(
                children: [Text("我的收藏：${value.collectNovelList?.length}")],
              )),
        ),
        collapsedWidget: const Center(
            child: Text(
          "我的收藏",
          style: TextStyle(color: Colors.white),
        )));
  }

  _buildGridItem(CollectNovelEntry value) {
    return Container(
      padding: 5.horizontal,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Expanded(
            child: ExtendedImageBuild(
              url: value.imageUrl ?? "",
              isJoinUrl: true,
            ),
          ),
          Text("${value.name}"),
          //Text("${value.datumNew}"),
          Text(
            value.readChapter ?? "暂未阅读",
            maxLines: 1,
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            "新！:${value.datumNew}",
            maxLines: 1,
            style: const TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }
}
