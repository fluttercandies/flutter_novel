import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novel_flutter_bit/pages/book_novel/entry/book_entry.dart';
import 'package:novel_flutter_bit/pages/collect_novle/enrty/collect_entry.dart';
import 'package:novel_flutter_bit/pages/collect_novle/state/collect_state.dart';
import 'package:novel_flutter_bit/pages/collect_novle/view_model/collect_view_model.dart';
import 'package:novel_flutter_bit/route/route.gr.dart';
import 'package:novel_flutter_bit/tools/net_state_tools.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/widget/book_title_sliver_persistent_header_delegate.dart';
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

  /// 跳转详情页
  _onToDetailPage(CollectNovelEntry? data) {
    BookDatum bookData = BookDatum(
      name: data?.name,
      url: data?.readUrl,
      datumNew: data?.datumNew,
    );
    context.router.push(DetailRoute(bookDatum: bookData));
  }

  /// 跳转搜索页
  _onToSearchPage() {
    context.router.push(const SearchRoute());
  }

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
        collapsedHeight: Theme.of(context).appBarTheme.toolbarHeight ?? 56,
        slivers: [
          SliverPersistentHeader(
              pinned: true,
              delegate: TitleSliverPersistentHeaderDelegate(
                myColors: _themeData.scaffoldBackgroundColor,
                brandColor: _themeData.primaryColor,
                title: '最近收藏',
              )),
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
            sliver: const SliverFillRemaining(),
          )
        ],
        expandedWidget: Flexible(
          child: Padding(
              padding: 20.padding,
              child: Column(
                children: [Text("我的收藏：${value.collectNovelList?.length}")],
              )),
        ),
        collapsedWidget: _buildCollapsedWidget());
  }

  /// 构建折叠时的内容
  _buildCollapsedWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "我的收藏",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
          ),
          IconButton(
              onPressed: _onToSearchPage,
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              )),
        ],
      ),
    );
  }

  ///  构建item
  _buildGridItem(CollectNovelEntry value) {
    return GestureDetector(
      onTap: () => _onToDetailPage(value),
      child: Container(
        padding: 5.horizontal,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            ExtendedImageBuild(
              url: value.imageUrl ?? "",
              isJoinUrl: true,
            ),
            Text(
              "${value.name}",
              maxLines: 1,
            ),
            //Text("${value.datumNew}"),
            Text(
              value.readChapter ?? "暂未阅读",
              maxLines: 1,
              style: TextStyle(fontSize: 14, color: _themeData.primaryColor),
            ),
            Text(
              "新！:${value.datumNew}",
              maxLines: 1,
              style: const TextStyle(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
