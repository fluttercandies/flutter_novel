// ignore_for_file: use_super_parameters

import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';

class NovleSpecialTextSpanBuilder extends SpecialTextSpanBuilder {
  NovleSpecialTextSpanBuilder();

  @override
  SpecialText? createSpecialText(String flag,
      {TextStyle? textStyle,
      SpecialTextGestureTapCallback? onTap,
      int? index}) {
    if (flag == '') {
      return null;
    }

    // index is end index of start flag, so text start index should be index-(flag.length-1)
    return null;
  }
}

class IgnoreGradientTextSpan extends TextSpan with IgnoreGradientSpan {
  IgnoreGradientTextSpan({String? text, List<InlineSpan>? children})
      : super(
          text: text,
          children: children,
        );
}

class GradientConfigClass {
  static GradientConfig config = GradientConfig(
    gradient: const LinearGradient(
      colors: <Color>[Colors.blue, Colors.red],
    ),
    ignoreRegex: GradientConfig.ignoreEmojiRegex,
    ignoreWidgetSpan: true,
    renderMode: GradientRenderMode.fullText,
    blendMode: BlendMode.srcIn,
    beforeDrawGradient:
        (PaintingContext context, TextPainter textPainter, Offset offset) {},
  );
}
