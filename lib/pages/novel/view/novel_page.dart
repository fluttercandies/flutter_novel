import 'package:auto_route/auto_route.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/base/base_provider.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/pages/novel/view_model/novel_view_model.dart';
import 'package:novel_flutter_bit/style/theme_novel.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/loading.dart';
import 'package:novel_flutter_bit/widget/special_text_span_builder.dart';

@RoutePage()
class NovelPage extends StatefulWidget {
  const NovelPage({super.key, required this.url, required this.name});
  final String url;
  final String name;
  @override
  State<NovelPage> createState() => _NovelPageState();
}

class _NovelPageState extends State<NovelPage> {
  late NovelViewModel _novelViewModel;
  final NovleSpecialTextSpanBuilder _specialTextSpanBuilder =
      NovleSpecialTextSpanBuilder(color: Colors.black);

  /// 动画时长
  final Duration _duration = const Duration(milliseconds: 300);
  // 控制AppBar和BottomNavigationBar的可见性
  bool _isAppBarVisible = true;
  bool _isBottomBarVisible = true;
  @override
  void initState() {
    super.initState();
    _novelViewModel = NovelViewModel(widget.url);
    _novelViewModel.getData();
  }

  /// Convert HTML content to a list of InlineSpans
  List<InlineSpan> _getTextSpan(
      {required String htmlContent, required Color textColor}) {
    List<InlineSpan> spans = <InlineSpan>[
      // Convert HTML content to a list of InlineSpans with proper newlines
    ];

    // Replace &nbsp; with a regular space
    String plainText = htmlContent.replaceAll(RegExp(r'&nbsp;'), ' ');
    String plainText1 = plainText.replaceAll(RegExp(r'</p>'), ' ');
    // Split the text into lines using the newline character
    List<String> lines = plainText1.split('<br />');

    for (String line in lines) {
      if (line.isNotEmpty) {
        spans.add(TextSpan(
            // ignore: prefer_const_constructors
            text: line,
            style: TextStyle(fontSize: 16, color: textColor)));
        // Add a newline (invisible container with zero height)
        spans.add(WidgetSpan(child: Container(height: 0)));
      }
    }
    return spans;
  }

  String _getText({required String htmlContent}) {
    String plainText = htmlContent.replaceAll(RegExp(r'&nbsp;'), ' ');
    String plainText1 = plainText.replaceAll(RegExp(r'</p>'), ' ');
    String plainText2 = plainText1.replaceAll(RegExp(r'<br />'), '\n');
    return plainText2;
  }

  @override
  Widget build(BuildContext context) {
    final NovelTheme novelTheme = Theme.of(context).extension<NovelTheme>()!;
    _specialTextSpanBuilder.color = novelTheme.selectedColor!;
    return Scaffold(
      backgroundColor: novelTheme.backgroundColor,
      appBar: _buildAppBar(
          height: 65,
          minHeight: 40,
          duration: _duration,
          isAppBarVisible: _isAppBarVisible),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _isAppBarVisible = !_isAppBarVisible;
            _isBottomBarVisible = !_isBottomBarVisible;
          });
        },
        child: ProviderConsumer<NovelViewModel>(
          viewModel: _novelViewModel,
          builder: (BuildContext context, NovelViewModel value, Widget? child) {
            if (value.novelState.netState == NetState.loadingState) {
              return const LoadingBuild();
            }

            if (value.novelState.netState == NetState.emptyDataState) {
              return const EmptyBuild();
            }
            return _buildSuccess(value, novelTheme: novelTheme);
          },
        ),
      ),
      bottomNavigationBar: _buildBottmAppBar(
        height: 100,
        minHeight: 0,
        duration: _duration,
        isBottomBarVisible: _isBottomBarVisible,
        theme: novelTheme,
      ),
    );
  }

  _buildBottmAppBar(
      {required double height,
      required double minHeight,
      required Duration duration,
      required bool isBottomBarVisible,
      required NovelTheme theme}) {
    return AnimatedOpacity(
      opacity: isBottomBarVisible ? 1 : 0,
      duration: duration,
      child: AnimatedContainer(
        height: isBottomBarVisible ? height : minHeight,
        duration: duration,
        child: BottomAppBar(
          child: Container(
            color: theme.backgroundColor,
            height: height,
            child: const Center(child: Text('Bottom Navigation Bar')),
          ),
        ),
      ),
    );
  }

  /// appBar 构建
  _buildAppBar(
      {required double height,
      required double minHeight,
      required Duration duration,
      required bool isAppBarVisible}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: AnimatedContainer(
        height: _isAppBarVisible ? height * 2 : minHeight,
        duration: duration,
        child: AnimatedOpacity(
          opacity: _isAppBarVisible ? 1.0 : 0.0,
          duration: duration,
          child: AppBar(
            title: Text(widget.name),
          ),
        ),
      ),
    );
  }

  /// 构建成功
  _buildSuccess(NovelViewModel value, {required NovelTheme novelTheme}) {
    TextStyle style = TextStyle(
        fontSize: novelTheme.fontSize,
        fontWeight: novelTheme.fontWeight,
        color: novelTheme.notSelectedColor);
    return SingleChildScrollView(
        padding: 20.padding,
        child: ExtendedText.rich(TextSpan(children: [
          // IgnoreGradientTextSpan(
          //   text: _getText(
          //       htmlContent: value.novelState.novelEntry.data?.text ?? ''),
          // ),
          _specialTextSpanBuilder.build(
              _getText(
                  htmlContent: value.novelState.novelEntry.data?.text ?? ''),
              textStyle: style)
        ])));
  }
}
