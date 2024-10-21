import 'dart:io';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

@RoutePage()
class ImagePreviewPage extends StatefulWidget {
  const ImagePreviewPage({super.key, required this.asset});
  final AssetEntity asset;
  @override
  State<ImagePreviewPage> createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFile();
  }

  late File? file = File.fromUri(
      Uri.parse("${widget.asset.relativePath}${widget.asset.title}"));
  void getFile() async {
    //file = await widget.asset.file;
    print(file!.path);
    print(file);
  }

  @override
  Widget build(BuildContext context) {
    print("${widget.asset.relativePath}${widget.asset.title}");
    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Center(
          child: ExtendedImage.file(
            file!,
            height: 500,
            fit: BoxFit.contain,
            mode: ExtendedImageMode.editor,
          ),
        ),
      ),
    );
  }
}
