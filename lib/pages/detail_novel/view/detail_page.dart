import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/base/base_provider.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/icons/novel_icon_icons.dart';
import 'package:novel_flutter_bit/pages/book_novel/entry/book_entry.dart';
import 'package:novel_flutter_bit/pages/detail_novel/entry/detail_entry.dart';
import 'package:novel_flutter_bit/pages/detail_novel/view_model/detail_view_model.dart';
import 'package:novel_flutter_bit/route/route.gr.dart';
import 'package:novel_flutter_bit/style/theme.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';
import 'package:novel_flutter_bit/widget/detail_desc_text.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/image.dart';
import 'package:novel_flutter_bit/widget/loading.dart';

@RoutePage()
class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.bookDatum});
  final BookDatum bookDatum;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  /// 创建viewModel
  late DetailViewModel _detailViewModel;
  late ScrollController _scrollController;

  final double itemHheight = 55.0;

  late MyColorsTheme myColors;
  @override
  void initState() {
    super.initState();
    _detailViewModel = DetailViewModel(widget.bookDatum.url!);
    _detailViewModel.getData();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    if (mounted) _scrollController.dispose();
    super.dispose();
  }

  /// 跳转小说展示页
  _onToNovelPage(ListElement? data) {
    _detailViewModel.setReadIndex(data ?? ListElement());
    context.router
        .push(NovelRoute(url: data?.url ?? "", name: data?.name ?? ""));
  }

  // 跳转阅读页
  _onKeepReadNovelPage() {
    int index = _detailViewModel.detailState.detailNovel?.data?.list
            ?.indexOf(_detailViewModel.strUrl) ??
        0;
    var data = _detailViewModel.detailState.detailNovel?.data?.list?[index];
    context.router
        .push(NovelRoute(url: data?.url ?? "", name: data?.name ?? ""));
  }

  /// 滚动到顶部
  _animationToUp() async {
    int currentItemIndex = (_scrollController.offset / (itemHheight)).round();
    // _scrollController.animateTo(0,
    //     duration: Durations.long4, curve: Curves.easeInCirc);
    if (currentItemIndex > 50) {
      _scrollController.jumpTo(0.0);
      return;
    }
    final animationDuration = Duration(
        milliseconds: ((currentItemIndex / 5) * 150).clamp(100, 5000).toInt());
    _scrollController.animateTo(
      0.0,
      duration: animationDuration,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    myColors = Theme.of(context).extension<MyColorsTheme>()!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("书籍详情"),
        centerTitle: true,
      ),
      body: ProviderConsumer<DetailViewModel>(
        viewModel: _detailViewModel,
        builder: (BuildContext context, DetailViewModel value, Widget? child) {
          if (value.detailState.netState == NetState.loadingState) {
            return const LoadingBuild();
          }

          if (value.detailState.netState == NetState.emptyDataState) {
            return const EmptyBuild();
          }
          return _buildSuccess(value);
        },
      ),
      bottomNavigationBar: _buildBottomAppbar(readOnTap: _onKeepReadNovelPage),
      floatingActionButton: FloatingActionButton(
          onPressed: _animationToUp,
          backgroundColor: myColors.brandColor,
          child: Icon(Icons.keyboard_arrow_up, color: myColors.containerColor)),
    );
  }

  /// 成功状态构建
  _buildSuccess(DetailViewModel value, {double height = 160}) {
    return SafeArea(
      child: FadeIn(
          child: DefaultTextStyle(
        style: TextStyle(
          color: myColors.textColorHomePage,
          fontSize: 18,
          fontWeight: FontWeight.w300,
        ),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPadding(padding: 8.vertical),
            _buildTitle(height: height, value: value),
            SliverToBoxAdapter(
              child: Padding(
                padding: 20.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("书籍简介", style: TextStyle(fontSize: 18)),
                    DetailDescText(
                      text: " ${value.detailState.detailNovel?.data?.desc}",
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(padding: 3.vertical),
            SliverPersistentHeader(
                pinned: true,
                delegate: BookTitleSliverPersistentHeaderDelegate(
                    myColors: myColors,
                    reverse: value.reverse,
                    onPressed: value.onReverse,
                    count: value.detailState.detailNovel?.data?.list?.length ??
                        0)),
            _buildGridElement(value: value)
          ],
        ),
      )),
    );
  }

  /// 构建标题
  SliverPadding _buildTitle({
    required double height,
    required DetailViewModel value,
  }) {
    return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        sliver: SliverToBoxAdapter(
          child: SizedBox(
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: height,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(.3),
                        blurRadius: 4.0,
                        spreadRadius: 1)
                  ]),
                  child: ExtendedImageBuild(
                    fit: BoxFit.cover,
                    isJoinUrl: true,
                    height: height,
                    url: "${value.detailState.detailNovel?.data?.img}",
                  ),
                ),
                20.horizontalSpace,
                Expanded(
                  child: DefaultTextStyle(
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${value.detailState.detailNovel?.data?.name}",
                            style: TextStyle(
                                fontSize: 20,
                                color: myColors.textColorHomePage)),
                        Text("${value.detailState.detailNovel?.data?.type}"),
                        Text(
                            "作者： ${value.detailState.detailNovel?.data?.author}"),
                        Text("来源： ${widget.bookDatum.name}"),
                        Text("最新章节： ${widget.bookDatum.datumNew}"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  /// 底部导航栏
  _buildBottomAppbar(
      {void Function()? collectOnTap, void Function()? readOnTap}) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: myColors.brandColor!.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 0))
      ]),
      child: BottomAppBar(
          color: myColors.bottomAppBarColor,
          child: Row(
            children: [
              GestureDetector(
                onTap: collectOnTap,
                child: const SizedBox(
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(NovelIcon.heart),
                      Text("收藏", style: TextStyle(color: Colors.black87)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: readOnTap,
                  child: Container(
                    padding: 15.padding,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26, // 阴影颜色
                            blurRadius: 5.0, // 模糊半径
                            offset: Offset(0, 1), // 阴影偏移，第一个值是水平方向，第二个值是垂直方向
                          ),
                        ],
                        color: myColors.brandColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bookmark_add,
                            color: myColors.bottomAppBarColor),
                        Text("阅读",
                            style: TextStyle(
                                fontSize: 17,
                                color: myColors.bottomAppBarColor)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  /// 章节列表
  SliverList _buildGridElement({
    required DetailViewModel value,
  }) {
    return SliverList.builder(
      itemBuilder: (context, index) {
        bool readIndex = _detailViewModel.strUrl.name ==
            value.detailState.detailNovel?.data?.list?[index].name;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () =>
              _onToNovelPage(value.detailState.detailNovel?.data?.list?[index]),
          child: _buildSliverItem(
              "${value.detailState.detailNovel?.data?.list?[index].name}",
              readIndex),
        );
      },
      itemCount: value.detailState.detailNovel?.data?.list?.length,
    );
  }

  /// 构建item
  _buildSliverItem(String name, bool readIndex) {
    return Container(
      margin: 8.padding,
      padding: 5.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 19,
                color: readIndex ? myColors.brandColor : Colors.black87,
                wordSpacing: 2,
                fontWeight: FontWeight.w300),
          ),
          readIndex
              ? Text(
                  "阅读中",
                  style: TextStyle(
                      color: myColors.brandColor, fontWeight: FontWeight.w300),
                )
              : 0.verticalSpace
        ],
      ),
    );
  }
}

class BookTitleSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 50.0;
  @override
  double get maxExtent => 50.0;

  /// 颜色
  final MyColorsTheme myColors;

  /// 排序
  final bool reverse;

  final int count;
  final void Function()? onPressed;
  BookTitleSliverPersistentHeaderDelegate(
      {required this.count,
      required this.myColors,
      required this.reverse,
      this.onPressed});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: 10.horizontal,
      // color: myColors.containerColor,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [
            0.0,
            0.5
          ],
              colors: [
            myColors.containerColor!,
            Theme.of(context).scaffoldBackgroundColor
          ])),
      height: maxExtent,
      child: Row(
        children: [
          Text(
            '章节目录',
            style: TextStyle(fontSize: 20, color: myColors.brandColor),
          ),
          Text(" ($count) ",
              style: TextStyle(fontSize: 14, color: myColors.brandColor)),
          const Spacer(),
          Text(reverse ? "正序" : "倒叙"),
          IconButton(
              onPressed: onPressed, icon: const Icon(Icons.change_circle_sharp))
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
