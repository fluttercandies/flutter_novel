import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late ThemeData _theme;
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Scaffold(
      body: DefaultTextStyle(
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
        child: CustomScrollView(
          slivers: [_buildAppbar()],
        ),
      ),
    );
  }

  /// 构建appbar
  SliverAppBar _buildAppbar() {
    return SliverAppBar(
        expandedHeight: 80,
        collapsedHeight: 80,
        title: TextField(
            controller: _controller,
            cursorColor: Colors.white,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),
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
            )));
  }
}
