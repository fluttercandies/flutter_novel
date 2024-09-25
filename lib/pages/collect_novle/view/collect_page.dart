import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
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
      child: _buildBody(collectViewModel),
    ));
  }

  _buildBody(AsyncValue<CollectState> collectViewModel) {
    return SliverAdsorptionAppbar(
        controller: _controller,
        collapsedBrightness: Brightness.light,
        collapsedColors: _themeData.primaryColor,
        expandedColors: _themeData.scaffoldBackgroundColor,
        expandedHeight: 200,
        collapsedHeight: Theme.of(context).appBarTheme.toolbarHeight ?? 56,
        slivers: _buildSliver(collectViewModel),
        expandedWidget: _buildExpandedWidget(),
        collapsedWidget: _buildCollapsedWidget());
  }

  _buildSliver(AsyncValue<CollectState> collectViewModel) {
    return switch (collectViewModel) {
      AsyncData(:final value) => _buildAsyncData(value),
      AsyncError() => [const EmptyBuild()],
      _ => [const LoadingBuild()],
    };
  }

  List<Widget> _buildAsyncData(CollectState value) {
    Widget? child = NetStateTools.getWidget(value.netState);
    if (child != null) {
      return [child];
    }
    return _buildSuccess(value);
  }

  _buildSuccess(CollectState value) {
    return [
      SliverPersistentHeader(
          pinned: true,
          delegate: TitleSliverPersistentHeaderDelegate(
            myColors: _themeData.scaffoldBackgroundColor,
            brandColor: _themeData.primaryColor,
            title: '最近收藏（${value.collectNovelList?.length}）',
          )),
      SliverSafeArea(
        top: false,
        sliver: SliverPadding(
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
      )
    ];
  }

  /// 展开状态构建
  _buildExpandedWidget() {
    return Padding(
        padding: 20.horizontal,
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.settings))),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(100),
              //   child: ExtendedImage.asset("assets/images/logo.jpg",
              //       width: 80, height: 80, fit: BoxFit.cover),
              // ),
              // ExtendedImageBuild(
              //     url: "https://api.likepoems.com/counter/get/@7-bit"),
              SvgPicture.network("https://api.likepoems.com/counter/get/@7bit")
            ]),
          ),
        ));
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
