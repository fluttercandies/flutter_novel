// To parse this JSON data, do
//
//     final novleHistoryEntry = novleHistoryEntryFromJson(jsonString);

// ignore_for_file: non_nullable_equals_parameter

import 'dart:convert';

List<CollectNovleEntry> novleHistoryEntryFromJson(String str) =>
    List<CollectNovleEntry>.from(
        json.decode(str).map((x) => CollectNovleEntry.fromJson(x)));

String novleHistoryEntryToJson(List<CollectNovleEntry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CollectNovleEntry {
  String? name;
  String? imageUrl;
  String? readUrl;
  String? readChapter;
  String? datumNew;
  CollectNovleEntry({
    this.name,
    this.imageUrl,
    this.readUrl,
    this.readChapter,
    this.datumNew,
  });

  factory CollectNovleEntry.fromJson(Map<String, dynamic> json) =>
      CollectNovleEntry(
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
    if (other is CollectNovleEntry) {
      return readUrl == other.readUrl;
    }
    return false;
  }

  @override
  int get hashCode => readUrl.hashCode;
}
