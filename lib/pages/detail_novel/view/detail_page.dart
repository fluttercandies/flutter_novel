import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:novel_flutter_bit/db/preferences_db.dart';
import 'package:novel_flutter_bit/icons/novel_icon_icons.dart';
import 'package:novel_flutter_bit/pages/book_novel/entry/book_entry.dart';
import 'package:novel_flutter_bit/pages/collect_novel/enrty/collect_entry.dart';
import 'package:novel_flutter_bit/pages/detail_novel/entry/detail_entry.dart';
import 'package:novel_flutter_bit/pages/detail_novel/state/detail_state.dart';
import 'package:novel_flutter_bit/pages/detail_novel/view_model/detail_view_model.dart';
import 'package:novel_flutter_bit/route/route.gr.dart';
import 'package:novel_flutter_bit/widget/net_state_tools.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';
import 'package:novel_flutter_bit/widget/book_title_sliver_persistent_header_delegate.dart';
import 'package:novel_flutter_bit/widget/detail_desc_text.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/image.dart';
import 'package:novel_flutter_bit/widget/loading.dart';

@RoutePage()
class DetailPage extends ConsumerStatefulWidget {
  const DetailPage({super.key, required this.bookDatum});
  final BookDatum bookDatum;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  /// 创建viewModel
  late ScrollController _scrollController;

  final double itemHheight = 55.0;

  /// 详情页viewModel
  late DetailViewModel _detailViewModel;

  /// 主题样式
  //late ThemeStyleProvider _themeStyleProvider;
  late ThemeData _themeData;

  late bool _isLikeNovel = false;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _initLikeNovel();
    // _themeStyleProvider = ref.read(themeStyleProviderProvider.notifier);
  }

  @override
  void dispose() {
    if (mounted) _scrollController.dispose();
    super.dispose();
  }

  /// 初始化是否收藏
  void _initLikeNovel() async {
    _isLikeNovel = await PreferencesDB.instance
        .getSenseLikeNovel(widget.bookDatum.url ?? "");
  }

  /// 设置是否收藏
  void _setLikeNovel(DetailNovel? detailNovel) async {
    _isLikeNovel = !_isLikeNovel;
    final detailViewModel = ref.read(
        detailViewModelProvider(urlBook: widget.bookDatum.url ?? "").notifier);
    CollectNovelEntry collectNovelEntry = CollectNovelEntry(
      name: detailNovel?.data?.name ?? "",
      imageUrl: detailNovel?.data?.img ?? "",
      readUrl: widget.bookDatum.url ?? "",
      readChapter: detailViewModel.strUrl.name,
      datumNew: widget.bookDatum.datumNew,
    );
    await PreferencesDB.instance.setSenseLikeNovel(
        widget.bookDatum.url ?? "", _isLikeNovel, collectNovelEntry);
    SmartDialog.showToast(_isLikeNovel ? "收藏成功" : "取消收藏");
    setState(() {});
  }

  /// 跳转小说展示页
  _onToNovelPage(ListElement? data) async {
    _detailViewModel.setReadIndex(data ?? ListElement());
    await context.router.push(NovelRoute(
        url: data?.url ?? "",
        name: data?.name ?? "",
        bookDatum: widget.bookDatum));
  }

  // 跳转阅读页
  _onKeepReadNovelPage() async {
    int index = _detailViewModel.getReadIndex();
    var data = _detailViewModel.detailState.detailNovel?.data?.list?[index];
    _detailViewModel.setReadIndex(data ?? ListElement());

    await context.router.push(NovelRoute(
        url: data?.url ?? "",
        name: data?.name ?? "",
        bookDatum: widget.bookDatum));
  }

  /// 滚动到顶部
  _animationToUp() async {
    int currentItemIndex = (_scrollController.offset / (itemHheight)).round();
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

  /// 滚动到当前选中的索引
  _animationToLocal() async {
    int index = _detailViewModel.getReadIndex();
    double offsetHeight = index * (51.5);
    if (index > 50) {
      _scrollController.jumpTo(offsetHeight);
      return;
    }
    final animationDuration =
        Duration(milliseconds: ((index / 10) * 150).clamp(100, 5000).toInt());
    _scrollController.animateTo(
      offsetHeight,
      duration: animationDuration,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    final detailViewModel =
        ref.watch(detailViewModelProvider(urlBook: widget.bookDatum.url ?? ""));
    return Scaffold(
      body: switch (detailViewModel) {
        AsyncData(:final value) => Builder(builder: (BuildContext context) {
            _detailViewModel = ref.read(
                detailViewModelProvider(urlBook: widget.bookDatum.url ?? "")
                    .notifier);
            Widget? child = NetStateTools.getWidget(value.netState);
            if (child != null) {
              return child;
            }
            return Scaffold(
                appBar: AppBar(
                  title: const Text("书籍详情"),
                  centerTitle: true,
                ),
                body: _buildSuccess(value: value),
                bottomNavigationBar: _buildBottomAppbar(
                    readOnTap: _onKeepReadNovelPage,
                    collectOnTap: () => _setLikeNovel(value.detailNovel)),
                floatingActionButton: _buildFloatingActionButton());
          }),
        AsyncError() => EmptyBuild(),
        _ => const LoadingBuild(),
      },
    );
  }

  /// 浮动按钮
  _buildFloatingActionButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
            heroTag: "_animationToUp",
            onPressed: _animationToUp,
            backgroundColor: _themeData.primaryColor,
            child: Icon(Icons.keyboard_arrow_up,
                color: _themeData.scaffoldBackgroundColor)),
        10.verticalSpace,
        FloatingActionButton(
            heroTag: "_animationToLocal",
            onPressed: _animationToLocal,
            backgroundColor: _themeData.primaryColor,
            child: Icon(Icons.location_on,
                color: _themeData.scaffoldBackgroundColor)),
      ],
    );
  }

  /// 成功状态构建
  _buildSuccess({required DetailState value, double height = 170}) {
    return SafeArea(
      child: FadeIn(
          child: DefaultTextStyle(
        style: TextStyle(
          color: _themeData.textTheme.bodyLarge?.color,
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
                      text: " ${value.detailNovel?.data?.desc}",
                      brandColor: _themeData.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(padding: 3.vertical),
            SliverPersistentHeader(
                pinned: true,
                delegate: BookTitleSliverPersistentHeaderDelegate(
                    myColors: _themeData.scaffoldBackgroundColor,
                    brandColor: _themeData.primaryColor,
                    reverse: _detailViewModel.reverse,
                    onPressed: () {
                      _detailViewModel.onReverse();
                    },
                    count: value.detailNovel?.data?.list?.length ?? 0)),
            _buildListElement(value: value)
          ],
        ),
      )),
    );
  }

  /// 构建标题
  SliverPadding _buildTitle({
    required double height,
    required DetailState value,
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
                    url: "${value.detailNovel?.data?.img}",
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
                        Text("${value.detailNovel?.data?.name}",
                            style: TextStyle(
                                fontSize: 20, color: _themeData.primaryColor)),
                        Text("${value.detailNovel?.data?.type}"),
                        Text("作者： ${value.detailNovel?.data?.author}"),
                        Text("来源： ${widget.bookDatum.name}"),
                        Expanded(
                            child: Text(
                          "最新章节： ${widget.bookDatum.datumNew}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        )),
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
            color: _themeData.primaryColor.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 0))
      ]),
      child: BottomAppBar(
          color: _themeData.scaffoldBackgroundColor,
          child: Row(
            children: [
              GestureDetector(
                onTap: collectOnTap,
                child: SizedBox(
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        NovelIcon.heart,
                        color: _isLikeNovel
                            ? _themeData.primaryColor
                            : Colors.grey.shade300,
                      ),
                      Text(
                        _isLikeNovel ? "已收藏" : "收藏",
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
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
                        color: _themeData.primaryColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bookmark_add,
                            color: _themeData.scaffoldBackgroundColor),
                        Text(
                            _detailViewModel.getReadIndex() > 0
                                ? "继续阅读"
                                : "开始阅读",
                            style: TextStyle(
                                fontSize: 17,
                                color: _themeData.scaffoldBackgroundColor)),
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
  SliverList _buildListElement({
    required DetailState value,
  }) {
    return SliverList.builder(
      itemBuilder: (context, index) {
        bool readIndex = _detailViewModel.strUrl.name ==
            value.detailNovel?.data?.list?[index].name;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onToNovelPage(value.detailNovel?.data?.list?[index]),
          child: _buildSliverItem(
              "${value.detailNovel?.data?.list?[index].name}", readIndex),
        );
      },
      itemCount: value.detailNovel?.data?.list?.length,
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
          Expanded(
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 19,
                  color: readIndex ? _themeData.primaryColor : Colors.black87,
                  wordSpacing: 2,
                  fontWeight: FontWeight.w300),
            ),
          ),
          readIndex
              ? Text(
                  "阅读中",
                  style: TextStyle(
                      color: _themeData.primaryColor,
                      fontWeight: FontWeight.w300),
                )
              : 0.verticalSpace
        ],
      ),
    );
  }
}
