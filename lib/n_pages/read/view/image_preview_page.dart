import 'dart:io';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        color1: Colors.white, // 颜色1
        color2: _themeData.primaryColor, // 颜色2
        leftAngle: 0, rightAngle: 10,
        lineHeight: .8, // 位置2：正中间或其他位置
        child: Center(
          child: ExtendedImage.file(
            file!,
            height: 500,
            enableLoadState: true,
            fit: BoxFit.contain,
            mode: ExtendedImageMode.editor,
            initEditorConfigHandler: (ExtendedImageState? state) {
              return EditorConfig(
                maxScale: 8.0,
                cropRectPadding: const EdgeInsets.all(20.0),
                hitTestSize: 20.0,
                cropLayerPainter: _cropLayerPainter!,
                initCropRectType: InitCropRectType.imageRect,
                cropAspectRatio: _aspectRatio,
                controller: _controller,
              );
            },
          ),
        ),
      ),
    );
  }
}
