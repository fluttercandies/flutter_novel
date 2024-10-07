// To parse this JSON data, do
//
//     final detailBookEntry = detailBookEntryFromJson(jsonString);

import 'dart:convert';

DetailBookEntry detailBookEntryFromJson(String str) =>
    DetailBookEntry.fromJson(json.decode(str));

String detailBookEntryToJson(DetailBookEntry data) =>
    json.encode(data.toJson());

class DetailBookEntry {
  String? author;
  String? coverUrl;
  String? intro;
  String? lastChapter;
  String? name;
  List<Chapter>? chapter;

  DetailBookEntry({
    this.author,
    this.coverUrl,
    this.intro,
    this.lastChapter,
    this.name,
    this.chapter,
  });

  factory DetailBookEntry.fromJson(Map<String, dynamic> json) =>
      DetailBookEntry(
        author: json["author"],
        coverUrl: json["coverUrl"],
        intro: json["intro"],
        lastChapter: json["lastChapter"],
        name: json["name"],
        chapter: json["chapter"] == null
            ? []
            : List<Chapter>.from(
                json["chapter"]!.map((x) => Chapter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "coverUrl": coverUrl,
        "intro": intro,
        "lastChapter": lastChapter,
        "name": name,
        "chapter": chapter == null
            ? []
            : List<dynamic>.from(chapter!.map((x) => x.toJson())),
      };
}

class Chapter {
  String? chapterUrl;
  String? chapterName;

  Chapter({
    this.chapterUrl,
    this.chapterName,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        chapterUrl: json["chapterUrl"],
        chapterName: json["chapterName"],
      );

  Map<String, dynamic> toJson() => {
        "chapterUrl": chapterUrl,
        "chapterName": chapterName,
      };
}
