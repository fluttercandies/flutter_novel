import 'package:auto_route/auto_route.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:novel_flutter_bit/base/base_provider.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/pages/book_novel/entry/book_entry.dart';
import 'package:novel_flutter_bit/pages/book_novel/view_model/book_view_model.dart';
import 'package:novel_flutter_bit/style/theme.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/loading.dart';
import 'package:novel_flutter_bit/widget/special_text_span_builder.dart';

@RoutePage()
class BookPage extends StatefulWidget {
  const BookPage({super.key, required this.name});
  final String name;
  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  /// 创建viewModel
  late BookViewModel _bookViewModel;
  final NovleSpecialTextSpanBuilder _builder = NovleSpecialTextSpanBuilder();
  @override
  void initState() {
    super.initState();
    _bookViewModel = BookViewModel(widget.name);
    _bookViewModel.getData();
  }

  @override
  Widget build(BuildContext context) {
    final MyColorsTheme myColors =
        Theme.of(context).extension<MyColorsTheme>()!;
    return Scaffold(
        appBar: AppBar(title: Text(widget.name)),
        body: ProviderConsumer<BookViewModel>(
            viewModel: _bookViewModel,
            builder:
                (BuildContext context, BookViewModel value, Widget? child) {
              if (value.bookState.netState == NetState.loadingState) {
                return const LoadingBuild();
              }

              if (value.bookState.netState == NetState.emptyDataState) {
                return const EmptyBuild();
              }
              return _buildSuccess(value, myColors: myColors);
            }));
  }

  /// 成功 构建器
  _buildSuccess(BookViewModel value, {required MyColorsTheme myColors}) {
    return DefaultTextStyle(
      style: TextStyle(color: myColors.bookTitleColor, fontSize: 16),
      child: Padding(
        padding: 20.padding,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("站源", style: TextStyle(fontSize: 20)),
          30.verticalSpace,
          _buildList(value, myColors: myColors)
        ]),
      ),
    );
  }

  /// list
  _buildList(BookViewModel value, {required MyColorsTheme myColors}) {
    return Expanded(
      child: ListView.separated(
        itemCount: value.bookState.bookEntry?.data?.length ?? 0,
        itemBuilder: (context, index) {
          return _buildItem(value.bookState.bookEntry?.data?[index],
              myColors: myColors);
        },
        separatorBuilder: (BuildContext context, int index) {
          return 20.verticalSpace;
        },
      ),
    );
  }

  /// item
  _buildItem(BookDatum? data, {required MyColorsTheme myColors}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(children: [
            const TextSpan(text: "来源"),
            const TextSpan(text: "："),
            TextSpan(
                text: "${data?.name}",
                style: TextStyle(color: myColors.bookBodyColor, fontSize: 17))
          ]),
        ),
        Text.rich(
          TextSpan(children: [
            const TextSpan(text: "最新章节"),
            const TextSpan(text: "："),
            TextSpan(
                text: "${data?.datumNew}",
                style: TextStyle(color: myColors.bookTitleColor, fontSize: 17))
          ]),
        ),
      ],
    );
  }

  /// 富文本Demo
  _buildDemoExtendedText({required String title, required String body}) {
    return ExtendedText.rich(
      gradientConfig: GradientConfigClass.config,
      TextSpan(
        children: [
          IgnoreGradientTextSpan(
            text: title,
          ),
          _builder.build("123"),
          IgnoreGradientTextSpan(
            text: body,
          ),
        ],
      ),
    );
  }
}
