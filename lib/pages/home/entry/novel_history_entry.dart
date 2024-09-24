// To parse this JSON data, do
//
//     final novleHistoryEntry = novleHistoryEntryFromJson(jsonString);

// ignore_for_file: non_nullable_equals_parameter

import 'dart:convert';

List<NovelHistoryEntry> novleHistoryEntryFromJson(String str) =>
    List<NovelHistoryEntry>.from(
        json.decode(str).map((x) => NovelHistoryEntry.fromJson(x)));

String novleHistoryEntryToJson(List<NovelHistoryEntry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NovelHistoryEntry {
  String? name;
  String? imageUrl;
  String? readUrl;
  String? readChapter;
  String? datumNew;
  NovelHistoryEntry({
    this.name,
    this.imageUrl,
    this.readUrl,
    this.readChapter,
    this.datumNew,
  });

  factory NovelHistoryEntry.fromJson(Map<String, dynamic> json) =>
      NovelHistoryEntry(
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
    if (other is NovelHistoryEntry) {
      return readUrl == other.readUrl;
    }
    return false;
  }

  @override
  int get hashCode => readUrl.hashCode;
}
