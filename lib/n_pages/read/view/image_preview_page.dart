import 'package:auto_route/auto_route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

@RoutePage()
class ImagePreviewPage extends StatelessWidget {
  const ImagePreviewPage({super.key, required this.asset});
  final AssetEntity asset;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ExtendedImage(
            fit: BoxFit.contain,
            width: double.infinity,
            image: AssetEntityImageProvider(asset, isOriginal: false)),
      ),
    );
  }
}
