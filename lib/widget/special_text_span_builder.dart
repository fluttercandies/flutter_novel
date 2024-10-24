// ignore_for_file: use_super_parameters

import 'package:extended_text/extended_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class NovelSpecialTextSpanBuilder extends SpecialTextSpanBuilder {
  NovelSpecialTextSpanBuilder({required this.color});
  Color color;
  set setColor(Color c) => color = c;
  @override
  SpecialText? createSpecialText(String flag,
      {TextStyle? textStyle,
      SpecialTextGestureTapCallback? onTap,
      int? index}) {
    if (flag == '') {
      return null;
    } else if (isStart(flag, AtText.flag)) {
      return AtText(
        textStyle,
        onTap,
        start: index! - (AtText.flag.length - 1),
        color: color,
      );
    } else if (isStart(flag, MateText.flag)) {
      return MateText(
        textStyle,
        onTap,
        start: index! - (MateText.flag.length - 1),
        color: color,
      );
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

class MateText extends SpecialText {
  MateText(
    TextStyle? textStyle,
    SpecialTextGestureTapCallback? onTap, {
    this.showAtBackground = false,
    required this.start,
    required this.color,
  }) : super(flag, '”', textStyle, onTap: onTap);
  static const String flag = '“';
  final int start;
  final Color color;

  /// whether show background for @somebody
  final bool showAtBackground;

  @override
  InlineSpan finishText() {
    final TextStyle textStyle =
        this.textStyle?.copyWith(color: color) ?? const TextStyle();

    final String atText = toString();

    return showAtBackground
        ? BackgroundTextSpan(
            background: Paint()..color = Colors.blue.withOpacity(0.15),
            text: atText,
            actualText: atText,
            start: start,

            ///caret can move into special text
            deleteAll: true,
            style: textStyle,
            recognizer: (TapGestureRecognizer()
              ..onTap = () {
                if (onTap != null) {
                  onTap!(atText);
                }
              }))
        : SpecialTextSpan(
            text: atText,
            actualText: atText,
            start: start,
            style: textStyle,
            recognizer: (TapGestureRecognizer()
              ..onTap = () {
                if (onTap != null) {
                  onTap!(atText);
                }
              }));
  }
}

class AtText extends SpecialText {
  AtText(
    TextStyle? textStyle,
    SpecialTextGestureTapCallback? onTap, {
    this.showAtBackground = false,
    required this.start,
    required this.color,
  }) : super(flag, '@', textStyle, onTap: onTap);
  static const String flag = '@';
  final int start;
  final Color color;

  /// whether show background for @somebody
  final bool showAtBackground;

  @override
  InlineSpan finishText() {
    final TextStyle textStyle =
        this.textStyle?.copyWith(color: color) ?? const TextStyle();

    final String atText = toString();

    return showAtBackground
        ? BackgroundTextSpan(
            background: Paint()..color = Colors.blue.withOpacity(0.15),
            text: atText,
            actualText: atText,
            start: start,

            ///caret can move into special text
            deleteAll: true,
            style: textStyle,
            recognizer: (TapGestureRecognizer()
              ..onTap = () {
                if (onTap != null) {
                  onTap!(atText);
                }
              }))
        : SpecialTextSpan(
            text: atText,
            actualText: atText,
            start: start,
            style: textStyle,
            recognizer: (TapGestureRecognizer()
              ..onTap = () {
                if (onTap != null) {
                  onTap!(atText);
                }
              }));
  }
}
