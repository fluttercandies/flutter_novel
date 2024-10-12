import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:novel_flutter_bit/db/preferences_db.dart';
import 'package:novel_flutter_bit/entry/book_source_entry.dart';
import 'package:novel_flutter_bit/icons/novel_icon_icons.dart';
import 'package:novel_flutter_bit/n_pages/detail/entry/detail_book_entry.dart';
import 'package:novel_flutter_bit/n_pages/detail/state/detail_state.dart';
import 'package:novel_flutter_bit/n_pages/detail/view_model/detail_view_model.dart';
import 'package:novel_flutter_bit/n_pages/search/entry/search_entry.dart';
import 'package:novel_flutter_bit/route/route.gr.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';
import 'package:novel_flutter_bit/widget/book_title_sliver_persistent_header_delegate.dart';
import 'package:novel_flutter_bit/widget/detail_desc_text.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/image.dart';
import 'package:novel_flutter_bit/widget/loading.dart';
import 'package:novel_flutter_bit/widget/net_state_tools.dart';

@RoutePage()
class NewDetailPage extends ConsumerStatefulWidget {
  const NewDetailPage(
      {super.key, required this.searchEntry, required this.bookSourceEntry});
  final SearchEntry searchEntry;
  final BookSourceEntry bookSourceEntry;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewDetailPageState();
}

class _NewDetailPageState extends ConsumerState<NewDetailPage> {
  /// 创建viewModel
  late ScrollController _scrollController;

  final double itemHheight = 55.0;

  /// 主题样式
  //late ThemeStyleProvider _themeStyleProvider;
  ThemeData get _themeData => Theme.of(context);
  late bool _isLikeNovel = false;
  late NewDetailViewModel _detailViewModel;
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
        .getSenseLikeNovel(widget.searchEntry.url ?? "");
  }

  /// 设置是否收藏
  void _setLikeNovel(Chapter chapter) async {
    _isLikeNovel = !_isLikeNovel;
    if (chapter.chapterUrl == null) {
      chapter = _detailViewModel.detailState.detailBookEntry?.chapter?.first ??
          Chapter();
    }
    Chapter collectNovelEntry = chapter;
    await PreferencesDB.instance
        .setLike(widget.searchEntry.url ?? "", _isLikeNovel, collectNovelEntry);
    SmartDialog.showToast(_isLikeNovel ? "收藏成功" : "取消收藏");
    setState(() {});
  }

  /// 获取封面url
  String _getBookSourceUrl({
    required DetailState value,
  }) {
    if (value.detailBookEntry?.coverUrl == "暂无") {
      return widget.searchEntry.coverUrl ?? "";
    } else {
      return value.detailBookEntry?.coverUrl ?? "";
    }
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

  // 跳转阅读页
  _onReadPage(int index) async {
    final model = ref.read(NewDetailViewModelProvider(
      detailUrl: widget.searchEntry.url ?? "",
      bookSource: widget.bookSourceEntry,
    ).notifier);

    final chapter = model.detailState.detailBookEntry!.chapter!;
    _detailViewModel.setReadIndex(chapter[index]);
    List<Chapter> chapterList = [];
    if (index > 0) {
      chapterList = [chapter[index - 1], chapter[index], chapter[index + 1]];
    } else {
      chapterList = [chapter[index], chapter[index], chapter[index + 1]];
    }
    context.router.push(ReadRoute(
        chapter: chapter[index],
        source: model.bookSourceEntry,
        searchEntry: widget.searchEntry,
        chapterList: chapterList));
  }

  // 继续阅读
  _onKeepReadNovelPage() async {
    int index = _detailViewModel.getReadIndex();
    var data = _detailViewModel.detailState.detailBookEntry?.chapter?[index];
    _detailViewModel.setReadIndex(data ?? Chapter());

    final chapter = _detailViewModel.detailState.detailBookEntry!.chapter!;
    _detailViewModel.setReadIndex(chapter[index]);
    List<Chapter> chapterList = [];
    if (index > 0) {
      chapterList = [chapter[index - 1], chapter[index], chapter[index + 1]];
    } else {
      chapterList = [chapter[index], chapter[index], chapter[index + 1]];
    }
    await context.router.push(ReadRoute(
        chapter: data ?? Chapter(),
        source: widget.bookSourceEntry,
        searchEntry: widget.searchEntry,
        chapterList: chapterList));
  }

  @override
  Widget build(BuildContext context) {
    final newDetailViewModel = ref.watch(NewDetailViewModelProvider(
      detailUrl: widget.searchEntry.url ?? "",
      bookSource: widget.bookSourceEntry,
    ));
    return Scaffold(
      body: switch (newDetailViewModel) {
        AsyncData(:final value) => Builder(builder: (BuildContext context) {
            Widget? child = NetStateTools.getWidget(value.netState);
            if (child != null) {
              return child;
            }
            _detailViewModel = ref.read(NewDetailViewModelProvider(
              detailUrl: widget.searchEntry.url ?? "",
              bookSource: widget.bookSourceEntry,
            ).notifier);
            return Scaffold(
                appBar: AppBar(
                  title: const Text("书籍详情"),
                  centerTitle: true,
                ),
                body: _buildSuccess(value: value),
                bottomNavigationBar: _buildBottomAppbar(
                    readOnTap: _onKeepReadNovelPage,
                    collectOnTap: () =>
                        _setLikeNovel(_detailViewModel.chapter)),
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
                      text: " ${value.detailBookEntry?.intro}",
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
                    onPressed: _detailViewModel.onReverse,
                    count: value.detailBookEntry?.chapter?.length ?? 0)),
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
                    height: height,
                    url: _getBookSourceUrl(value: value),
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
                        Text("${widget.searchEntry.name}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20, color: _themeData.primaryColor)),
                        Text("作者： ${value.detailBookEntry?.author}",
                            maxLines: 2),
                        Text("来源： ${widget.bookSourceEntry.bookSourceName}",
                            maxLines: 2),
                        Expanded(
                            child: Text(
                          "最新章节： ${value.detailBookEntry?.lastChapter}",
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
        bool readIndex = _detailViewModel.chapter.chapterName ==
            value.detailBookEntry?.chapter?[index].chapterName;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onReadPage(index),
          child: _buildSliverItem(
              "${value.detailBookEntry?.chapter?[index].chapterName}",
              readIndex),
        );
      },
      itemCount: value.detailBookEntry?.chapter?.length,
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
