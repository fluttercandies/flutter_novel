// To parse this JSON data, do
//
//     final novleHistoryEntry = novleHistoryEntryFromJson(jsonString);

// ignore_for_file: non_nullable_equals_parameter

import 'dart:convert';

List<NovleHistoryEntry> novleHistoryEntryFromJson(String str) =>
    List<NovleHistoryEntry>.from(
        json.decode(str).map((x) => NovleHistoryEntry.fromJson(x)));

String novleHistoryEntryToJson(List<NovleHistoryEntry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NovleHistoryEntry {
  String? name;
  String? imageUrl;
  String? readUrl;
  String? readChapter;
  String? datumNew;
  NovleHistoryEntry({
    this.name,
    this.imageUrl,
    this.readUrl,
    this.readChapter,
    this.datumNew,
  });

  factory NovleHistoryEntry.fromJson(Map<String, dynamic> json) =>
      NovleHistoryEntry(
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
    if (other is NovleHistoryEntry) {
      return readUrl == other.readUrl;
    }
    return false;
  }

  @override
  int get hashCode => readUrl.hashCode;
}
