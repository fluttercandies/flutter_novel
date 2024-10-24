import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/widget/special_text_span_builder.dart';

@RoutePage()
class ColorPreviewPage extends StatefulWidget {
  const ColorPreviewPage({super.key, required this.style});
  final TextStyle style;
  @override
  State<ColorPreviewPage> createState() => _ColorPreviewPageState();
}

class _ColorPreviewPageState extends State<ColorPreviewPage> {
  String text =
      "Flutter Candies “ 糖果社区 ” 成立于 2019 年 2 月 14 日，是一个杰出的社区，由对 Flutter 有着共同热情的开发人员组成。我们坚定不移的承诺是不断创建、维护和贡献一套高质量的 Flutter 插件和库（Flutter / Dart 包）。我们的目标是增强 Flutter 的可访问性，从而促进开发人员快速高效地创建卓越的 Flutter 应用程序。";
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      // 添加回调函数，等待页面渲染完成
      Future.delayed(Durations.medium4, () {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark, // 状态栏图标颜色
          statusBarBrightness: Brightness.dark, // 状态栏文字颜色
        ));
      });
    }
  }

  late NovelSpecialTextSpanBuilder _specialTextSpanBuilder =
      NovelSpecialTextSpanBuilder(color: Colors.black);
  late Color _color = const Color(0xfffafafa);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfffafafa),
      child: SafeArea(
        child: Column(children: [
          _buildAppbar(),
          Expanded(child: _buildBody()),
          ColorPicker(
            color: _color,
            enableOpacity: true,
            enableShadesSelection: true,
            toolbarSpacing: 20,
            pickerTypeLabels: const {
              ColorPickerType.primary: "深色",
              ColorPickerType.accent: "浅色",
              ColorPickerType.wheel: "调色盘"
            },
            pickersEnabled: const {
              ColorPickerType.both: false,
              ColorPickerType.primary: true,
              ColorPickerType.accent: true,
              ColorPickerType.bw: false,
              ColorPickerType.custom: false,
              ColorPickerType.wheel: true,
            },
            onColorChanged: (Color value) {
              _color = value;
              // _specialTextSpanBuilder =
              //     NovelSpecialTextSpanBuilder(color: _color);
              setState(() {});
            },
          )
        ]),
      ),
    );
  }

  _buildAppbar() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          BackButton(),
          Text(
            "背景颜色选择",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w300, color: Colors.black),
          )
        ],
      ),
    );
  }

  _buildBody() {
    return Container(
        padding: 20.padding,
        color: _color,
        child: ExtendedText.rich(TextSpan(children: [
          _specialTextSpanBuilder.build(text, textStyle: widget.style),
        ])));
  }
}
