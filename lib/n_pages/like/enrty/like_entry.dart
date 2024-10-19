import 'package:novel_flutter_bit/n_pages/detail/entry/detail_book_entry.dart';
import 'package:novel_flutter_bit/n_pages/search/entry/search_entry.dart';

/// 收藏
// To parse this JSON data, do
//
//     final likeEntry = likeEntryFromJson(jsonString);

import 'dart:convert';

LikeEntry likeEntryFromJson(String str) => LikeEntry.fromJson(json.decode(str));

String likeEntryToJson(LikeEntry data) => json.encode(data.toJson());

class LikeEntry {
  SearchEntry? searchEntry;
  Chapter? chapter;

  LikeEntry({
    this.searchEntry,
    this.chapter,
  });

  factory LikeEntry.fromJson(Map<String, dynamic> json) => LikeEntry(
        searchEntry: json["searchEntry"] == null
            ? null
            : SearchEntry.fromJson(json["searchEntry"]),
        chapter:
            json["Chapter"] == null ? null : Chapter.fromJson(json["Chapter"]),
      );

  Map<String, dynamic> toJson() => {
        "searchEntry": searchEntry?.toJson(),
        "Chapter": chapter?.toJson(),
      };
}
