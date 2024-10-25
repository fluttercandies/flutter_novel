import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/pages/novel/enum/novel_read_font_weight_enum.dart';

class NovelReadState {
  static double size = 18;
  static NovelReadFontWeightEnum weight = NovelReadFontWeightEnum.w300;
  static bool isChange = false;
  static Color textColor = const Color(0xff000000);
  static Color bgColor = const Color(0xfffafafa);
  static Color selectText = const Color(0xff000000);
  static void initFontWeight(String fontWeight) {
    if (fontWeight == NovelReadFontWeightEnum.w200.id) {
      weight = NovelReadFontWeightEnum.w200;
    } else if (fontWeight == NovelReadFontWeightEnum.w300.id) {
      weight = NovelReadFontWeightEnum.w300;
    } else if (fontWeight == NovelReadFontWeightEnum.w400.id) {
      weight = NovelReadFontWeightEnum.w400;
    } else if (fontWeight == NovelReadFontWeightEnum.w500.id) {
      weight = NovelReadFontWeightEnum.w500;
    } else if (fontWeight == NovelReadFontWeightEnum.w600.id) {
      weight = NovelReadFontWeightEnum.w600;
    } else {
      weight = NovelReadFontWeightEnum.w300;
    }
  }
}
