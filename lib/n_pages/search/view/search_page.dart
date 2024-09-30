import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novel_flutter_bit/entry/book_source_entry.dart';
import 'package:novel_flutter_bit/n_pages/home/view/home_page.dart';
import 'package:novel_flutter_bit/n_pages/home/view_model/home_view_model.dart';
import 'package:novel_flutter_bit/n_pages/search/entry/search_entry.dart';
import 'package:novel_flutter_bit/n_pages/search/view_model/search_view_model.dart';
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
  late BookSourceEntry? sourceEntry;

  ThemeData get theme => Theme.of(context);

  @override
  void initState() {
    super.initState();
    final homeviewmodel = ref.read(homeViewModelProvider.notifier);
    sourceEntry = homeviewmodel
        .homeState.sourceEntry?[homeviewmodel.homeState.currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    final newSearchViewModelProvider = ref.watch(NewSearchViewModelProvider(
        searchKey: widget.searchKey, bookSourceEntry: sourceEntry!));
    return Scaffold(
      appBar: AppBar(
          title: Text("${sourceEntry?.bookSourceName}--${widget.searchKey}")),
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
    return DefaultTextStyle(
      style: TextStyle(
          color: theme.textTheme.bodyLarge?.color,
          fontSize: 18,
          fontWeight: FontWeight.w300),
      child: ListView.builder(
          padding: 20.padding,
          itemCount: searchList?.length ?? 0,
          itemBuilder: (context, index) {
            return _buildItem(searchList![index]);
          }),
    );
  }

  _buildItem(SearchEntry searchEntry) {
    var str = searchEntry.bookAll?.replaceAll(" ", "");
    final list = str?.split("\n");

    ///默认显示文字
    Widget? imageWidget = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _getLineWidget(list)),
    );

    /// 封面
    if (searchEntry.coverUrl != null) {
      imageWidget = Row(
        children: [
          ExtendedImageBuild(
            url: searchEntry.coverUrl!,
            height: 180,
          ),
          Expanded(child: imageWidget)
        ],
      );
    }
    return Container(child: imageWidget);
  }

  List<Widget> _getLineWidget(List<String>? list) {
    List<Widget> res = [];
    for (var i = 0; i < (list?.length ?? 0); i++) {
      if (list?[i] == "") {
        res.add(0.verticalSpace);
      } else {
        res.add(Text(
          list?[i] ?? "",
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: i == 0
              ? TextStyle(color: theme.primaryColor, fontSize: 20)
              : const TextStyle(fontSize: 16, color: Colors.black54),
        ));
      }
    }
    return res;
  }

  String extractFirstLine(String input) {
    // 使用'\n'分割字符串，获取第一行
    String firstLine = input.split('\n').first;
    // 返回第一行，去除行尾的换行符
    return firstLine;
  }
}
