import 'package:novel_flutter_bit/base/base_state.dart';
import 'package:novel_flutter_bit/pages/home/entry/novel_hot_entry.dart';
import 'package:novel_flutter_bit/pages/home/entry/novle_history_entry.dart';

class HomeState extends BaseState {
  NovelHot? novelHot;

  List<NovleHistoryEntry>? dataHistory;
}
