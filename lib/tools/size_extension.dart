import 'package:flutter/material.dart';

extension SizeExtension on num {
  /// 垂直间距
  SizedBox get verticalSpace => SizedBox(height: toDouble());

  /// 水平间距
  SizedBox get horizontalSpace => SizedBox(width: toDouble());
}
