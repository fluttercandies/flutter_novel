import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/base/base_provider.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/pages/book_novel/entry/book_entry.dart';
import 'package:novel_flutter_bit/pages/book_novel/view/book_page.dart';
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
  @override
  void initState() {
    super.initState();
    _detailViewModel = DetailViewModel(widget.bookDatum.url!);
    _detailViewModel.getData();
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
      bottomSheet: BottomAppBar(
        color: myColors.bookBodyColor,
        child: Container(
          height: 100,
          color: Colors.red,
        ),
      ),
    );
  }

  /// 成功状态构建
  _buildSuccess(DetailViewModel value,
      {required MyColorsTheme myColors, double height = 160}) {
    return FadeIn(
        child: DefaultTextStyle(
      style: TextStyle(color: myColors.textColorHomePage, fontSize: 16),
      child: CustomScrollView(
        slivers: [
          SliverPadding(padding: 8.vertical),
          SliverPadding(
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
                            Text("${value.detailState.detailNovel?.data?.name}",
                                style: const TextStyle(fontSize: 20)),
                            Text("${value.detailState.detailNovel?.data?.type}",
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
          SliverFillRemaining(
              child: Container(
            color: Colors.amber,
            child: const Text("SliverFillRemaining"),
          ))
        ],
      ),
    ));
  }
}
