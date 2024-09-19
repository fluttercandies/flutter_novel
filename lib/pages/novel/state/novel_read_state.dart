import 'package:novel_flutter_bit/pages/novel/enum/novel_read_font_weight_enum.dart';

class NovelReadState {
  static double size = 18;
  static NovelReadFontWeightEnum weight = NovelReadFontWeightEnum.w300;
  static bool isChange = false;

  List<NovelReadFontWeightEnum> fontWeightList = [
    NovelReadFontWeightEnum.w300,
    NovelReadFontWeightEnum.w400,
    NovelReadFontWeightEnum.w500,
    NovelReadFontWeightEnum.w600,
  ];
}
