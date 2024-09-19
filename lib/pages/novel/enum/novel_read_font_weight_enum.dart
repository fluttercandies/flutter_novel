import 'package:flutter/material.dart';

enum NovelReadFontWeightEnum {
  w200("w200", "特细", FontWeight.w200),
  w300("w300", "默认", FontWeight.w300),
  w400("w400", "中等", FontWeight.w400),
  w500("w500", "粗", FontWeight.w500),
  w600("w600", "特粗", FontWeight.w600);

  final String id;
  final String name;
  final FontWeight fontWeight;
  const NovelReadFontWeightEnum(this.id, this.name, this.fontWeight);
}
