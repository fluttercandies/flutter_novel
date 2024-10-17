import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novel_flutter_bit/entry/book_source_entry.dart';
import 'package:novel_flutter_bit/n_pages/search/entry/search_entry.dart';
import 'package:novel_flutter_bit/n_pages/search/view_model/search_view_model.dart';
import 'package:novel_flutter_bit/route/route.gr.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/image.dart';
import 'package:novel_flutter_bit/widget/loading.dart';
import 'package:novel_flutter_bit/widget/net_state_tools.dart';

@RoutePage()
class NewSearchPage extends ConsumerStatefulWidget {
  const NewSearchPage({super.key, required this.searchKey});
  final String searchKey;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<NewSearchPage> {
  ThemeData get theme => Theme.of(context);

  double height = 160;

  /// 跳转详情页
  void _onTapToDeatilPage(
      {required SearchEntry entry, required BookSourceEntry bookSource}) {
    context.router.push(NewDetailRoute(
      searchEntry: entry,
      bookSourceEntry: bookSource,
    ));
    //SmartDialog.showToast(url);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newSearchViewModelProvider =
        ref.watch(NewSearchViewModelProvider(searchKey: widget.searchKey));
    return Scaffold(
      appBar: AppBar(title: Text(widget.searchKey)),
      body: switch (newSearchViewModelProvider) {
        AsyncData(:final value) => Builder(builder: (_) {
            return NetStateTools.getWidget(value.netState) ??
                _buildSuccess(searchList: value.searchList);
          }),
        AsyncError() => EmptyBuild(),
        _ => const LoadingBuild(),
      },
    );
  }

  _buildSuccess({List<SearchEntry>? searchList}) {
    return FadeIn(
      child: DefaultTextStyle(
        style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontSize: 17,
            fontWeight: FontWeight.w300),
        child: ListView.builder(
            padding: 20.padding,
            itemCount: searchList?.length ?? 0,
            itemBuilder: (context, index) {
              return _buildItem(searchList![index]);
            }),
      ),
    );
  }

  _buildItem(SearchEntry searchEntry) {
    // var str = searchEntry.bookAll?.replaceAll(" ", "");
    // final list = str?.split("\n");

    ///默认显示文字
    Widget? imageWidget = SizedBox(
      height: height,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: Text(
                (searchEntry.name ?? ""),
                style: TextStyle(fontSize: 18, color: theme.primaryColor),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
            ),
            searchEntry.kind != "" && searchEntry.kind != null
                ? Text("类型：${searchEntry.kind}")
                : 0.verticalSpace,
            searchEntry.author != "" && searchEntry.author != null
                ? Text("作者：${searchEntry.author}")
                : 0.verticalSpace,
            searchEntry.lastChapter != "" && searchEntry.lastChapter != null
                ? Text(
                    "最近更新：${searchEntry.lastChapter}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                : 0.verticalSpace,
            Text("来源：${searchEntry.bookSourceEntry?.bookSourceName}")
          ]),
    );

    /// 封面
    imageWidget = Row(
      children: [
        ExtendedImageBuild(
          url: searchEntry.coverUrl ?? "",
          height: height,
        ),
        10.horizontalSpace,
        Expanded(child: imageWidget)
      ],
    );
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _onTapToDeatilPage(
              entry: searchEntry,
              bookSource: searchEntry.bookSourceEntry!,
            ),
        child: Container(margin: 10.vertical, child: imageWidget));
  }
}
