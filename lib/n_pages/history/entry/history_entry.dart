import 'package:novel_flutter_bit/n_pages/detail/entry/detail_book_entry.dart';
import 'package:novel_flutter_bit/n_pages/search/entry/search_entry.dart';

/// 收藏
// To parse this JSON data, do
//
//     final likeEntry = likeEntryFromJson(jsonString);

import 'dart:convert';

HistoryEntry historyEntryFromJson(String str) =>
    HistoryEntry.fromJson(json.decode(str));

String historyEntryToJson(HistoryEntry data) => json.encode(data.toJson());

class HistoryEntry {
  SearchEntry? searchEntry;
  Chapter? chapter;
  String? dateTime;
  HistoryEntry({this.searchEntry, this.chapter, this.dateTime});

  factory HistoryEntry.fromJson(Map<String, dynamic> json) => HistoryEntry(
        searchEntry: json["searchEntry"] == null
            ? null
            : SearchEntry.fromJson(json["searchEntry"]),
        chapter:
            json["Chapter"] == null ? null : Chapter.fromJson(json["Chapter"]),
        dateTime: json["dateTime"],
      );

  Map<String, dynamic> toJson() => {
        "searchEntry": searchEntry?.toJson(),
        "Chapter": chapter?.toJson(),
        "dateTime": dateTime
      };
}
