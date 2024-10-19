import 'package:novel_flutter_bit/entry/book_source_entry.dart';

/// 搜索结果
/// 时间 2024-9-29
/// 7-bit
class SearchEntry {
  String? author;
  String? url;
  String? name;
  String? lastChapter;
  String? bookAll;
  String? coverUrl;
  String? kind;
  BookSourceEntry? bookSourceEntry;

  SearchEntry({
    this.author,
    this.url,
    this.name,
    this.lastChapter,
    this.bookAll,
    this.coverUrl,
    this.kind,
    this.bookSourceEntry,
  });

  factory SearchEntry.fromJson(Map<String, dynamic> json) => SearchEntry(
        author: json["author"],
        url: json["url"],
        name: json["name"],
        lastChapter: json["lastChapter"],
        bookAll: json["bookAll"],
        coverUrl: json["coverUrl"],
        kind: json["kind"],
        bookSourceEntry: json["BookSourceEntry"] == null
            ? null
            : BookSourceEntry.fromJson(json["BookSourceEntry"]),
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "url": url,
        "name": name,
        "lastChapter": lastChapter,
        "bookAll": bookAll,
        "coverUrl": coverUrl,
        "kind": kind,
        "BookSourceEntry": bookSourceEntry?.toJson(),
      };
}
