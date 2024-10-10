import 'package:auto_route/auto_route.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novel_flutter_bit/entry/book_source_entry.dart';
import 'package:novel_flutter_bit/n_pages/detail/entry/detail_book_entry.dart';
import 'package:novel_flutter_bit/n_pages/read/state/read_state.dart';
import 'package:novel_flutter_bit/n_pages/read/view_model/read_view_model.dart';
import 'package:novel_flutter_bit/pages/novel/state/novel_read_state.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/loading.dart';
import 'package:novel_flutter_bit/widget/net_state_tools.dart';
import 'package:novel_flutter_bit/widget/special_text_span_builder.dart';

@RoutePage()
class ReadPage extends ConsumerStatefulWidget {
  const ReadPage({super.key, required this.chapter, required this.source});
  final Chapter chapter;
  final BookSourceEntry source;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReadPageState();
}

class _ReadPageState extends ConsumerState<ReadPage> {
  ThemeData get _themeData => Theme.of(context);
  final NovelSpecialTextSpanBuilder _specialTextSpanBuilder =
      NovelSpecialTextSpanBuilder(color: Colors.black);
  late TextStyle _style;

  /// 动画时长
  final Duration _duration = const Duration(milliseconds: 400);

  /// 控制AppBar和BottomNavigationBar的可见性
  bool _isAppBarVisible = false;
  bool _isBottomBarVisible = false;

  /// 构建初始数据
  void _buildInitData() {
    _specialTextSpanBuilder.color = _themeData.primaryColor;
    _style = TextStyle(
        fontSize: NovelReadState.size,
        fontWeight: NovelReadState.weight.fontWeight,
        color: _themeData.textTheme.bodyLarge?.color);
    _specialTextSpanBuilder.color =
        _themeData.textTheme.bodyMedium?.color ?? Colors.black;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _buildInitData();
    final readViewModel = ref.watch(readViewModelProvider(
        chapter1: widget.chapter, bookSource: widget.source));
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.chapter.chapterName ?? " 暂无标题"),
        ),
        body: switch (readViewModel) {
          AsyncData(:final value) => Builder(builder: (BuildContext context) {
              Widget? child = NetStateTools.getWidget(value.netState);
              if (child != null) {
                return child;
              }
              return _buildSuccess(value: value, style: _style);
            }),
          AsyncError() => EmptyBuild(),
          _ => const LoadingBuild(),
        });
  }

  /// 构建成功
  _buildSuccess({required ReadState value, required TextStyle style}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      child: Center(
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
              padding: 20.padding,
              child: ExtendedText.rich(TextSpan(children: [
                _specialTextSpanBuilder.build(value.content ?? '',
                    textStyle: style)
              ]))),
        ),
      ),
    );
  }
}
