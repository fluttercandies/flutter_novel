import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:novel_flutter_bit/db/preferences_db.dart';
import 'package:novel_flutter_bit/pages/novel/state/novel_read_state.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';
import 'package:novel_flutter_bit/widget/custom_toggle_tab.dart';
import 'package:novel_flutter_bit/widget/special_text_span_builder.dart';

@RoutePage()
class ColorPreviewPage extends StatefulWidget {
  ColorPreviewPage(
      {super.key,
      required this.style,
      required this.backgroundColor,
      required this.selectedTextColor,
      required this.textColor});
  final TextStyle style;

  /// 背景色
  late Color backgroundColor;

  /// 文字颜色
  late Color textColor;

  /// 选中文字颜色
  late Color selectedTextColor;
  @override
  State<ColorPreviewPage> createState() => _ColorPreviewPageState();
}

class _ColorPreviewPageState extends State<ColorPreviewPage> {
  String text =
      "Flutter Candies “ 糖果社区 ” 成立于 2019 年 2 月 14 日，是一个杰出的社区，由对 Flutter 有着共同热情的开发人员组成。我们坚定不移的承诺是不断创建、维护和贡献一套高质量的 Flutter 插件和库（Flutter / Dart 包）。我们的目标是增强 Flutter 的可访问性，从而促进开发人员快速高效地创建卓越的 Flutter 应用程序。";

  final NovelSpecialTextSpanBuilder _specialTextSpanBuilder =
      NovelSpecialTextSpanBuilder(color: Colors.black);

  int _currentIndex = 0;

  List<Color> colorList = [];
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
    colorList = [
      widget.backgroundColor,
      widget.textColor,
      widget.selectedTextColor
    ];
  }

  /// 重置颜色列表
  void _resetColorList() {
    SmartDialog.showLoading(msg: "正在重置...");
    colorList = [
      NovelReadState.bgColor,
      NovelReadState.textColor,
      NovelReadState.selectText
    ];
    _specialTextSpanBuilder.color = NovelReadState.selectText;
    Future.delayed(Durations.medium4, () {
      setState(() {});
      SmartDialog.dismiss();
    });
  }

  /// 颜色改变时触发
  void _onColorChanged(Color color) {
    colorList[_currentIndex] = color;
    if (_currentIndex == 2) {
      _specialTextSpanBuilder.color = color;
    }
    setState(() {});
  }

  /// 保存颜色
  void _onSaveColor() async {
    SmartDialog.showLoading(msg: "正在保存...");
    NovelReadState.bgColor = colorList[0]; //Color (Color(0x71ffcdd2))
    NovelReadState.textColor = colorList[1];
    NovelReadState.selectText = colorList[2];
    await PreferencesDB.instance
        .setBackgroundColor(NovelReadState.bgColor.value);
    await PreferencesDB.instance.setTextColor(NovelReadState.textColor.value);
    await PreferencesDB.instance
        .setSelectedTextColor(NovelReadState.selectText.value);
    Future.delayed(Durations.medium4, () {
      SmartDialog.dismiss();
      if (mounted) context.router.maybePop(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffffffff),
      child: SafeArea(
        child: Column(children: [
          _buildAppbar(),
          Expanded(child: _buildBody()),
          CustomToggleTab(
              onTap: (index) => setState(() => _currentIndex = index)),
          ColorPicker(
            color: colorList[_currentIndex],
            enableOpacity: true,
            enableShadesSelection: true,
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
            onColorChanged: _onColorChanged,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                SizedBox(
                  height: 45,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      elevation: const WidgetStatePropertyAll(0),
                      shape: WidgetStatePropertyAll(StadiumBorder(
                          side: BorderSide(
                              width: 0, color: Colors.grey.shade300) // 不起作用
                          )),
                    ),
                    onPressed: _resetColorList,
                    label: const Text("重置"),
                    icon: const Icon(Icons.restore),
                  ),
                ),
                10.horizontalSpace,
                Flexible(
                  child: SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _onSaveColor,
                      style: ButtonStyle(
                        elevation: const WidgetStatePropertyAll(0),
                        shape: WidgetStatePropertyAll(StadiumBorder(
                            side: BorderSide(
                                width: 0, color: Colors.grey.shade300) // 不起作用
                            )),
                      ),
                      label: const Text("保存"),
                      icon: const Icon(Icons.save),
                    ),
                  ),
                )
              ],
            ),
          ),
          20.verticalSpace
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
          ),
        ],
      ),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Container(
          padding: 20.padding,
          color: colorList[0],
          child: ExtendedText.rich(TextSpan(children: [
            _specialTextSpanBuilder.build(text,
                textStyle: widget.style.copyWith(color: colorList[1])),
          ]))),
    );
  }
}
