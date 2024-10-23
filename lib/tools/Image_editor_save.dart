import 'dart:ui' as ui;

import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as img;

enum ImageType { gif, jpg }

class EditImageInfo {
  EditImageInfo(
    this.data,
    this.imageType,
  );
  final Uint8List? data;
  final ImageType imageType;
}

class ImageEditorSave {
  static Future<Uint8List> cropImageDataWithDartLibrary(
      ImageEditorController imageEditorController) async {
    /// 获取裁剪区域
    Rect cropRect = imageEditorController.getCropRect()!;

    /// 获取图片编辑控制器
    final ExtendedImageEditorState state = imageEditorController.state!;

    /// 图片数据
    final Uint8List data = state.rawImageData;

    if (data == state.rawImageData &&
        state.widget.extendedImageState.imageProvider is ExtendedResizeImage) {
      final ui.ImmutableBuffer buffer =
          await ui.ImmutableBuffer.fromUint8List(state.rawImageData);
      final ui.ImageDescriptor descriptor =
          await ui.ImageDescriptor.encoded(buffer);
      final double widthRatio = descriptor.width / state.image!.width;
      final double heightRatio = descriptor.height / state.image!.height;
      cropRect = Rect.fromLTRB(
        cropRect.left * widthRatio,
        cropRect.top * heightRatio,
        cropRect.right * widthRatio,
        cropRect.bottom * heightRatio,
      );
    }

    /// 将 Uint8List 转为 Image 对象
    img.Image? originalImage = img.decodeImage(data);

    if (originalImage == null) {
      throw Exception("无法解码图片数据");
    }

    /// 计算裁剪后的图片
    img.Image croppedImage = img.copyCrop(
      originalImage,
      x: cropRect.left.toInt(),
      y: cropRect.top.toInt(),
      width: cropRect.width.toInt(),
      height: cropRect.height.toInt(),
    );

    /// 将裁剪后的图片转回 Uint8List 格式
    final Uint8List croppedData =
        Uint8List.fromList(img.encodePng(croppedImage));
    return croppedData;
  }

  /// 解码图片
  ui.Image _decodeImage(Uint8List list) {
    late ui.Image image;
    ui.decodeImageFromList(list, (ui.Image callBack) {
      image = callBack;
    });
    return image;
  }
}
