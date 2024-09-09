import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/base/base_provider.dart';
import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/pages/book_novel/view_model/book_view_model.dart';
import 'package:novel_flutter_bit/style/theme.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';

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
                return _buildLoading();
              }
              return DefaultTextStyle(
                style: TextStyle(color: myColors.textColorHomePage),
                child: Padding(
                  padding: 20.padding,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("站源", style: TextStyle(fontSize: 20)),
                        20.verticalSpace,
                        Expanded(
                          child: ListView.separated(
                            itemCount:
                                value.bookState.bookEntry?.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "来源： ${value.bookState.bookEntry?.data?[index].name}"),
                                  Text(
                                      "最新章节 ${value.bookState.bookEntry?.data?[index].datumNew}")
                                ],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return 10.verticalSpace;
                            },
                          ),
                        )
                      ]),
                ),
              );
            }));
  }

  /// 加载中
  _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }
}
