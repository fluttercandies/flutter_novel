// To parse this JSON data, do
//
//     final novleHistoryEntry = novleHistoryEntryFromJson(jsonString);

// ignore_for_file: non_nullable_equals_parameter

import 'dart:convert';

List<CollectNovelEntry> novelHistoryEntryFromJson(String str) =>
    List<CollectNovelEntry>.from(
        json.decode(str).map((x) => CollectNovelEntry.fromJson(x)));

String novelHistoryEntryToJson(List<CollectNovelEntry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CollectNovelEntry {
  String? name;
  String? imageUrl;
  String? readUrl;
  String? readChapter;
  String? datumNew;
  CollectNovelEntry({
    this.name,
    this.imageUrl,
    this.readUrl,
    this.readChapter,
    this.datumNew,
  });

  factory CollectNovelEntry.fromJson(Map<String, dynamic> json) =>
      CollectNovelEntry(
        name: json["name"],
        imageUrl: json["imageUrl"],
        readUrl: json["readUrl"],
        readChapter: json["readChapter"],
        datumNew: json["datumNew"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
        "readUrl": readUrl,
        "readChapter": readChapter,
        "datumNew": datumNew,
      };

  @override
  bool operator ==(dynamic other) {
    if (other is CollectNovelEntry) {
      return readUrl == other.readUrl;
    }
    return false;
  }

  @override
  int get hashCode => readUrl.hashCode;
}
