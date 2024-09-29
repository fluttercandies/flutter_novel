import 'package:auto_route/auto_route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novel_flutter_bit/assets/assets.dart';
import 'package:novel_flutter_bit/n_pages/home/view_model/home_view_model.dart';
import 'package:novel_flutter_bit/route/route.gr.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/loading.dart';
import 'package:novel_flutter_bit/widget/net_state_tools.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  ThemeData get theme => Theme.of(context);

  final TextEditingController _controller = TextEditingController();

  /// 搜索
  _onSearch() {
    if (_controller.text.isNotEmpty && _controller.text.trim().isNotEmpty) {
      context.router.push(NewSearchRoute(searchKey: _controller.text));
    } else {
      SmartDialog.showToast("请输入内容");
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = ref.watch(homeViewModelProvider);
    return Scaffold(
        body: switch (homeViewModel) {
      AsyncData(:final value) => Builder(builder: (BuildContext context) {
          return NetStateTools.getWidget(value.netState) ?? _buildSuccess();
        }),
      AsyncError() => EmptyBuild(),
      _ => const LoadingBuild(),
    });
  }

  _buildSuccess() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: FocusScope.of(context).unfocus,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ExtendedImage.asset(
            Assets.assets_images_logo2_png,
            height: 200,
          ),
          _buildSearchBar()
        ],
      ),
    );
  }

  /// 搜索框
  _buildSearchBar() {
    return Padding(
      padding: 10.padding,
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          hintText: '请输入内容',
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: theme.primaryColor.withOpacity(.5), width: 2),
            borderRadius: BorderRadius.circular(50), // 设置圆角
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black38, width: 2),
            borderRadius: BorderRadius.circular(50), // 设置圆角
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Colors.black38), // 设置未选中且禁用时的边框颜色
            borderRadius: BorderRadius.circular(50),
          ),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: Container(
            margin: 5.padding,
            decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(25)),
            child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: _onSearch,
                icon: SvgPicture.asset(
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                  Assets.assets_svg_undo_up_svg,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                )),
          ),
          fillColor: Colors.white, // 输入框背景颜色
          filled: true, // 填充样式
        ),
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w300,
            fontSize: 16), // 输入文字颜色
      ),
    );
  }
}