import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:image_editor/image_editor.dart';

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
  static Future<Uint8List?> cropImageDataWithDartLibrary(
      ImageEditorController imageEditorController) async {
    // /// 获取裁剪区域
    /// Rect cropRect = imageEditorController.getCropRect()!;

    // /// 获取图片编辑控制器
    final ExtendedImageEditorState state = imageEditorController.state!;

    // /// 图片数据
    final Uint8List data = state.rawImageData;

    /// 创建图片编辑配置
    final option = ImageEditorOption();

    /// 添加图片编辑配置
    final EditActionDetails action = state.editAction!;

    /// 旋转
    if (action.hasRotateDegrees) {
      final int rotateDegrees = action.rotateDegrees.toInt();
      option.addOption(RotateOption(rotateDegrees));
    }

    /// 翻转
    if (action.flipY) {
      option.addOption(const FlipOption(horizontal: true, vertical: false));
    }

    /// 裁剪
    if (action.needCrop) {
      Rect cropRect = imageEditorController.getCropRect()!;
      option.addOption(ClipOption.fromRect(cropRect));
    }

    /// 处理
    final result = await ImageEditor.editImage(
      image: data,
      imageEditorOption: option,
    );
    return result;
  }
}
