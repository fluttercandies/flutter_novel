import 'package:auto_route/auto_route.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novel_flutter_bit/n_pages/history/entry/history_entry.dart';
import 'package:novel_flutter_bit/n_pages/history/state/history_state.dart';
import 'package:novel_flutter_bit/n_pages/history/view_model/history_view_model.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/loading.dart';
import 'package:novel_flutter_bit/widget/net_state_tools.dart';

@RoutePage()
class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    final historyViewModel = ref.watch(historyViewModelProvider);
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        title: const Text("阅读记录"),
      ),
      body: switch (historyViewModel) {
        AsyncData(:final value) => Builder(builder: (_) {
            Widget? child =
                NetStateTools.getWidget(value.netState, msg: "还没有历史记录哦！");
            if (child != null) {
              return child;
            }
            return _buildSuccess(value);
          }),
        AsyncError() => EmptyBuild(),
        _ => const LoadingBuild(),
      },
    );
  }

  Widget _buildSuccess(HistoryState value) {
    return DefaultTextStyle(
      style: const TextStyle(
          overflow: TextOverflow.ellipsis,
          color: Colors.black54,
          fontSize: 14,
          fontWeight: FontWeight.w300),
      child: ListView.builder(
        padding: 20.padding,
        itemBuilder: (c, i) {
          return _buildItem(value.historyList![i]);
        },
        itemCount: value.historyList?.length,
      ),
    );
  }

  _buildItem(HistoryEntry entry) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: const BoxDecoration(),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            child: ExtendedImage.network(
              entry.searchEntry?.coverUrl ?? "",
              width: 35,
              height: 35,
              fit: BoxFit.cover,
            ),
          ),
          15.horizontalSpace,
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text((entry.searchEntry?.name ?? "") * 2,
                  style: const TextStyle(fontSize: 16, color: Colors.black87)),
              5.verticalSpace,
              Text(entry.chapter?.chapterName ?? ""),
            ],
          )),
        ],
      ),
    );
  }
}
