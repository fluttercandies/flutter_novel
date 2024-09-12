import 'package:auto_route/auto_route.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/base/base_provider.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/pages/novel/view_model/novel_view_model.dart';
import 'package:novel_flutter_bit/style/theme.dart';
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
    final MyColorsTheme myColors =
        Theme.of(context).extension<MyColorsTheme>()!;
    _specialTextSpanBuilder.color = myColors.brandColor!;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: ProviderConsumer<NovelViewModel>(
        viewModel: _novelViewModel,
        builder: (BuildContext context, NovelViewModel value, Widget? child) {
          if (value.novelState.netState == NetState.loadingState) {
            return const LoadingBuild();
          }

          if (value.novelState.netState == NetState.emptyDataState) {
            return const EmptyBuild();
          }
          return _buildSuccess(value, myColors: myColors);
        },
      ),
    );
  }

  /// 构建成功
  _buildSuccess(NovelViewModel value, {required MyColorsTheme myColors}) {
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
              textStyle: const TextStyle(fontSize: 20))
        ])));
  }
}
