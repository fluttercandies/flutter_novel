import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novel_flutter_bit/pages/search/entry/search_entry.dart';
import 'package:novel_flutter_bit/pages/search/state/search_state.dart';
import 'package:novel_flutter_bit/pages/search/view_model/search_view_model.dart';
import 'package:novel_flutter_bit/tools/net_state_tools.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/loading.dart';

@RoutePage()
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late ThemeData _theme;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    final searchViewModel =
        ref.watch(searchViewModelProvider(bookName: _controller.text));
    return Scaffold(
      body: DefaultTextStyle(
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w300, color: Colors.black87),
        child: CustomScrollView(
          slivers: [
            _buildAppbar(),
            switch (searchViewModel) {
              AsyncData(:final value) =>
                Builder(builder: (BuildContext context) {
                  //LoggerTools.looger.e(value.netState);
                  final data = NetStateTools.getWidget(value.netState,
                      msg: "输入书本名称，我们将全网搜索");
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
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15),
                hintText: "搜索全网小说",
                hintStyle: TextStyle(color: Colors.white),
                prefixIcon: Hero(
                    tag: "Icons.search",
                    child: Icon(Icons.search, color: Colors.white)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
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

  Widget _buildSuccess({required SearchState value}) {
    return SliverList.builder(
        itemCount: value.searchEntry?.data?.length,
        itemBuilder: (context, index) {
          return _buildSearchItem(value.searchEntry?.data?[index]);
        });
  }

  _buildSearchItem(SearchEntryDatum? entry) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            entry?.name ?? "",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
          )
        ]));
  }
}
