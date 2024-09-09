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
          builder:
              (BuildContext context, DetailViewModel value, Widget? child) {
            if (value.detailState.netState == NetState.loadingState) {
              return const LoadingBuild();
            }

            if (value.detailState.netState == NetState.emptyDataState) {
              return const EmptyBuild();
            }
            return _buildSuccess(value, myColors: myColors);
          },
        ));
  }

  /// 成功状态构建
  _buildSuccess(DetailViewModel value,
      {required MyColorsTheme myColors, double height = 160}) {
    return FadeIn(
        child: DefaultTextStyle(
      style: TextStyle(color: myColors.textColorHomePage, fontSize: 16),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: 20.padding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.5),
                          blurRadius: 8.0,
                          spreadRadius: 1)
                    ]),
                    child: ExtendedImageBuild(
                      width: 110,
                      isJoinUrl: true,
                      height: height,
                      url: "${value.detailState.detailNovel?.data?.img}",
                    ),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: SizedBox(
                      height: height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${value.detailState.detailNovel?.data?.name}",
                              style: const TextStyle(fontSize: 18)),
                          5.verticalSpace,
                          Text("${value.detailState.detailNovel?.data?.type}",
                              style: TextStyle(color: Colors.grey)),
                          3.verticalSpace,
                          Text(
                              "作者： ${value.detailState.detailNovel?.data?.author}",
                              style: TextStyle(color: Colors.grey)),
                          3.verticalSpace,
                          Text("来源： ${widget.bookDatum.name}",
                              style: TextStyle(color: Colors.grey)),
                          3.verticalSpace,
                          Text("最新章节： ${widget.bookDatum.datumNew}",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: 20.horizontal,
              child: Text("${value.detailState.detailNovel?.data?.desc}"),
            ),
          )
        ],
      ),
    ));
  }
}
