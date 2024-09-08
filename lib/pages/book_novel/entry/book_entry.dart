// To parse this JSON data, do
//
//     final bookEntry = bookEntryFromJson(jsonString);

import 'dart:convert';

BookEntry bookEntryFromJson(String str) => BookEntry.fromJson(json.decode(str));

String bookEntryToJson(BookEntry data) => json.encode(data.toJson());

class BookEntry {
  List<BookDatum>? data;

  BookEntry({
    this.data,
  });

  factory BookEntry.fromJson(Map<String, dynamic> json) => BookEntry(
        data: json["data"] == null
            ? []
            : List<BookDatum>.from(
                json["data"]!.map((x) => BookDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BookDatum {
  String? name;
  String? url;
  String? datumNew;
  String? newurl;

  BookDatum({
    this.name,
    this.url,
    this.datumNew,
    this.newurl,
  });

  factory BookDatum.fromJson(Map<String, dynamic> json) => BookDatum(
        name: json["name"],
        url: json["url"],
        datumNew: json["new"],
        newurl: json["newurl"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "new": datumNew,
        "newurl": newurl,
      };
}
