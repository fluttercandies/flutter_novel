import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novel_flutter_bit/icons/novel_icon_icons.dart';
import 'package:novel_flutter_bit/pages/book_novel/entry/book_entry.dart';
import 'package:novel_flutter_bit/pages/collect_novle/view_model/collect_view_model.dart';
import 'package:novel_flutter_bit/pages/search/entry/search_entry.dart';
import 'package:novel_flutter_bit/pages/search/state/search_state.dart';
import 'package:novel_flutter_bit/pages/search/view_model/search_view_model.dart';
import 'package:novel_flutter_bit/route/route.gr.dart';
import 'package:novel_flutter_bit/tools/debouncer.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:novel_flutter_bit/tools/net_state_tools.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/image.dart';
import 'package:novel_flutter_bit/widget/loading.dart';

@RoutePage()
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late ThemeData _theme;

  /// 搜索框控制器
  final TextEditingController _controller = TextEditingController();

  /// 搜索框防抖
  final _debouncer = Debouncer();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 跳转详情页
  _onToDetailPage(Book data) async {
    final book = BookDatum(
        name: data.name,
        url: data.url,
        newurl: data.newurl,
        datumNew: data.bookNew);
    await context.router.push(DetailRoute(bookDatum: book));
    if (mounted) FocusScope.of(context).requestFocus(FocusNode());
    ref.read(collectViewModelProvider.notifier).getData();
  }

  /// 搜索 文本输入框改变
  _onChangeText(String str) {
    _debouncer.debounce(() {
      LoggerTools.looger.i("执行搜索：$str");
      setState(() {});
    }, const Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    final searchViewModel =
        ref.watch(searchViewModelProvider(bookName: _controller.text));
    return Scaffold(
      body: DefaultTextStyle(
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w300, color: Colors.black87),
        child: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: CustomScrollView(
            slivers: [
              _buildAppbar(),
              switch (searchViewModel) {
                AsyncData(:final value) =>
                  Builder(builder: (BuildContext context) {
                    //LoggerTools.looger.e(value.netState);
                    final data =
                        NetStateTools.getWidget(value.netState, msg: value.msg);
                    if (data != null) {
                      return SliverToBoxAdapter(
                          child: Padding(
                              padding: const EdgeInsets.only(top: 100),
                              child: FadeIn(child: data)));
                    }
                    return _buildSuccess(value: value);
                  }),
                AsyncError() => const SliverToBoxAdapter(child: EmptyBuild()),
                _ => const SliverToBoxAdapter(child: LoadingBuild()),
              }
            ],
          ),
        ),
      ),
    );
  }

  /// 构建appbar
  SliverAppBar _buildAppbar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 180,
      collapsedHeight: 100,
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextField(
              controller: _controller,
              cursorColor: Colors.white,
              onChanged: _onChangeText,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                hintText: "搜索全网小说",
                hintStyle: const TextStyle(color: Colors.white),
                prefixIcon: const Hero(
                    tag: "Icons.search",
                    child: Icon(Icons.search, color: Colors.white)),
                suffixIcon: IconButton(
                    onPressed: _controller.clear,
                    icon: const Icon(NovelIcon.crossed_bones,
                        color: Colors.white)),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              )),
        ],
      ),
      // title: TextField(
      //     controller: _controller,
      //     cursorColor: Colors.white,
      //     style: const TextStyle(
      //         color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),
      //     decoration: const InputDecoration(
      //       contentPadding: EdgeInsets.symmetric(vertical: 15),
      //       hintText: "搜索全网小说",
      //       hintStyle: TextStyle(color: Colors.white),
      //       prefixIcon: Hero(
      //           tag: "Icons.search",
      //           child: Icon(Icons.search, color: Colors.white)),
      //       enabledBorder: UnderlineInputBorder(
      //         borderSide: BorderSide(color: Colors.white),
      //       ),
      //       focusedBorder: UnderlineInputBorder(
      //         borderSide: BorderSide(color: Colors.white),
      //       ),
      //     ))
    );
  }

  /// 构建成功
  Widget _buildSuccess({required SearchState value}) {
    return SliverList.builder(
        itemCount: value.searchEntry?.data?.length,
        itemBuilder: (context, index) {
          return _buildSearchItem(value.searchEntry!.data![index]);
        });
  }

  /// 构建搜索item
  _buildSearchItem(SearchEntryDatum entry, {double imageheight = 150}) {
    const style = TextStyle(
        color: Colors.black54, fontSize: 16, overflow: TextOverflow.ellipsis);

    return FadeIn(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  ExtendedImageBuild(
                    url: entry.img ?? "",
                    height: imageheight,
                    isJoinUrl: true,
                  ),
                  10.horizontalSpace,
                  Expanded(
                      child: SizedBox(
                    height: imageheight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${entry.name}"),
                        Text("${entry.author}/${entry.type}", style: style),
                        Expanded(
                          child:
                              Text("${entry.desc}", style: style, maxLines: 5),
                        )
                      ],
                    ),
                  ))
                ],
              ),
              10.verticalSpace,
              _buildSourceList(entry)
            ],
          )),
    );
  }

  /// 构建源列表
  _buildSourceList(SearchEntryDatum entry) {
    return Column(
      children: [
        for (int i = 0; i < (entry.book?.length ?? 0); i++) ...{
          _buildSourceItem(entry.book![i])
        }
      ],
    );
  }

  /// 构建书源
  _buildSourceItem(Book book) {
    const style1 = TextStyle(color: Colors.black87, fontSize: 16);
    return DefaultTextStyle(
      style: style1.copyWith(fontSize: 16, fontWeight: FontWeight.w300),
      child: GestureDetector(
        onTap: () => _onToDetailPage(book),
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: _theme.primaryColor.withOpacity(.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _theme.primaryColor.withOpacity(.1))),
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              children: [Text("来源：${book.name}"), Text("最新章节：${book.bookNew}")],
            )),
      ),
    );
  }
}
