import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/base/base_provider.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/icons/novel_icon_icons.dart';
import 'package:novel_flutter_bit/pages/book_novel/entry/book_entry.dart';
import 'package:novel_flutter_bit/pages/detail_novel/view_model/detail_view_model.dart';
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
    final MyColorsTheme myColors =
        Theme.of(context).extension<MyColorsTheme>()!;
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
          return _buildSuccess(value, myColors: myColors);
        },
      ),
      bottomNavigationBar: _buildBottomAppbar(myColors: myColors),
      floatingActionButton: FloatingActionButton(
          onPressed: _animationToUp,
          backgroundColor: myColors.brandColor,
          child: Icon(Icons.keyboard_arrow_up, color: myColors.containerColor)),
    );
  }

  /// 成功状态构建
  _buildSuccess(DetailViewModel value,
      {required MyColorsTheme myColors, double height = 160}) {
    return SafeArea(
      child: FadeIn(
          child: DefaultTextStyle(
        style: TextStyle(color: myColors.textColorHomePage, fontSize: 16),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPadding(padding: 8.vertical),
            SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                                color: Colors.grey.withOpacity(.6),
                                blurRadius: 10.0,
                                spreadRadius: 2)
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "${value.detailState.detailNovel?.data?.name}",
                                  style: const TextStyle(fontSize: 20)),
                              Text(
                                  "${value.detailState.detailNovel?.data?.type}",
                                  style: const TextStyle(color: Colors.grey)),
                              Text(
                                  "作者： ${value.detailState.detailNovel?.data?.author}",
                                  style: const TextStyle(color: Colors.grey)),
                              Text("来源： ${widget.bookDatum.name}",
                                  style: const TextStyle(color: Colors.grey)),
                              Text("最新章节： ${widget.bookDatum.datumNew}",
                                  style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
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
            SliverGrid.builder(
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  height: 20,
                  margin: 8.padding,
                  padding: 5.padding,
                  decoration: BoxDecoration(
                    color: myColors.bottomAppBarColor,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: myColors.brandColor!.withOpacity(.5), // 阴影颜色
                        blurRadius: 3.0, // 模糊半径
                        // 阴影偏移，第一个值是水平方向，第二个值是垂直方向
                      ),
                    ],
                  ),
                  child: Text(
                    "${value.detailState.detailNovel?.data?.list?[index].name}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  ),
                );
              },
              itemCount: value.detailState.detailNovel?.data?.list?.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: itemHheight),
            )
          ],
        ),
      )),
    );
  }

  /// 底部导航栏
  _buildBottomAppbar(
      {required MyColorsTheme myColors,
      void Function()? collectOnTap,
      void Function()? readOnTap}) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
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
}