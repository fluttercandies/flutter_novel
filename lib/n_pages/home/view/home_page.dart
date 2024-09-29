import 'package:auto_route/auto_route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novel_flutter_bit/assets/assets.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  ThemeData get theme => Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
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
      ),
    );
  }

  _buildSearchBar() {
    return Padding(
      padding: 10.padding,
      child: TextField(
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          hintText: '请输入内容',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50), // 设置圆角
          ),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: Container(
            margin: 5.padding,
            decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(25)),
            child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
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
