import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novel_flutter_bit/n_pages/history/entry/history_entry.dart';
import 'package:novel_flutter_bit/n_pages/history/state/history_state.dart';
import 'package:novel_flutter_bit/n_pages/history/view_model/history_view_model.dart';
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
    return ListView.builder(
      itemBuilder: (c, i) {
        return _buildItem(value.historyList![i]);
      },
      itemCount: value.historyList?.length,
    );
  }

  _buildItem(HistoryEntry entry) {
    return Text(entry.chapter?.chapterName ?? "");
  }
}
