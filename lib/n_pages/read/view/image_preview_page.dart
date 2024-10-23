import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:novel_flutter_bit/icons/novel_icon_icons.dart';
import 'package:novel_flutter_bit/tools/Image_editor_save.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';
import 'package:novel_flutter_bit/widget/background.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

@RoutePage()
class ImagePreviewPage extends StatefulWidget {
  const ImagePreviewPage({super.key, required this.asset});
  final AssetEntity asset;
  @override
  State<ImagePreviewPage> createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  ThemeData get _themeData => Theme.of(context);
  @override
  void initState() {
    super.initState();

    _initFile();
  }

  /// 图片编辑 比例
  late double _aspectRatio;

  /// 裁剪
  EditorCropLayerPainter? _cropLayerPainter;

  /// 图片编辑控制器
  ImageEditorController? _controller;

  /// 编辑状态
  final GlobalKey<ExtendedImageEditorState> _editorKey =
      GlobalKey<ExtendedImageEditorState>();

  /// 图片文件
  late File? file = File.fromUri(
      Uri.parse("${widget.asset.relativePath}${widget.asset.title}"));

  /// 获取图片文件
  ///
  void _initFile() async {
    //file = await widget.asset.file;
    file = await widget.asset.file;
    _cropLayerPainter = const EditorCropLayerPainter();
    _aspectRatio = CropAspectRatios.ratio9_16;
    _controller = ImageEditorController();
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
    setState(() {});
  }

  /// 保存图片
  void _saveImage() async {
    SmartDialog.showLoading(msg: "图片裁剪中...");
    await Future.delayed(Durations.medium4, () async {
      final data =
          await ImageEditorSave.cropImageDataWithDartLibrary(_controller!);
      LoggerTools.looger.d(data.length);
      setState(() {});
    });
    SmartDialog.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      color1: Colors.white, // 颜色1
      color2: _themeData.primaryColor, // 颜色2
      leftAngle: 0,
      rightAngle: 10,
      child: SafeArea(
        child: Column(
          children: [
            _buildAppbar(),
            _buildEditorImage(),
            const Spacer(),
            _buildItemButtonList(),
            _buildSubmitButton(onPressed: _saveImage),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }

  _buildAppbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          const BackButton(),
          90.horizontalSpace,
          const Text(
            "图片编辑",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w300, color: Colors.black),
          )
        ],
      ),
    );
  }

  /// 构建图片编辑
  _buildEditorImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExtendedImage.file(
        file!,
        height: 500,
        enableLoadState: true,
        fit: BoxFit.contain,
        mode: ExtendedImageMode.editor,
        cacheRawData: true,
        extendedImageEditorKey: _editorKey,
        initEditorConfigHandler: (ExtendedImageState? state) {
          return EditorConfig(
            maxScale: 8.0,
            cropRectPadding: const EdgeInsets.all(20.0),
            hitTestSize: 20.0,
            editorMaskColorHandler: (context, pointerDown) =>
                Colors.grey.withOpacity(pointerDown ? 0.5 : 0.3),
            cropLayerPainter: _cropLayerPainter!,
            initCropRectType: InitCropRectType.imageRect,
            cropAspectRatio: _aspectRatio,
            controller: _controller,
          );
        },
      ),
    );
  }

  /// 构建按钮
  _buildItemButtonList() {
    return DefaultTextStyle(
      style: const TextStyle(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildItemButton(
                icon: NovelIcon.arrows_cw,
                text: '重置',
                onPressed: _controller?.reset),
            _buildItemButton(
                icon: NovelIcon.ccw,
                text: '上一步',
                onPressed: () {
                  if (_controller?.canUndo ?? false) {
                    _controller?.undo();
                    return;
                  }
                  SmartDialog.showToast("已经无法后退了");
                }),
            _buildItemButton(
                icon: NovelIcon.cw,
                text: '下一步',
                onPressed: () {
                  if (_controller?.canRedo ?? false) {
                    _controller?.redo();
                    return;
                  }
                  SmartDialog.showToast("已经无法前进了");
                }),
            _buildItemButton(
                icon: NovelIcon.undo,
                text: '旋转',
                onPressed: () => _controller?.rotate(animation: true)),
            _buildItemButton(
                icon: NovelIcon.exchange,
                text: '翻转',
                onPressed: () => _controller?.flip(animation: true))
          ],
        ),
      ),
    );
  }

  ///
  _buildItemButton(
      {required IconData icon,
      required String text,
      required void Function()? onPressed}) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white24, borderRadius: BorderRadius.circular(3)),
      child: Column(
        children: [
          IconButton(
              onPressed: onPressed,
              icon: Icon(
                icon,
                color: Colors.white,
              )),
          Text(text)
        ],
      ),
    );
  }

  /// 构建提交按钮
  _buildSubmitButton({required void Function()? onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
              style: const ButtonStyle(
                  elevation: WidgetStatePropertyAll(0),
                  backgroundColor: WidgetStatePropertyAll(Colors.white)),
              onPressed: onPressed,
              child: const Text(
                "确认",
                style: TextStyle(fontSize: 16),
              ))),
    );
  }
}
