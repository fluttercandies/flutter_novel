// To parse this JSON data, do
//
//     final searchEntry = searchEntryFromJson(jsonString);

import 'dart:convert';

SearchEntry searchEntryFromJson(String str) =>
    SearchEntry.fromJson(json.decode(str));

String searchEntryToJson(SearchEntry data) => json.encode(data.toJson());

class SearchEntry {
  List<Datum>? data;

  SearchEntry({
    this.data,
  });

  factory SearchEntry.fromJson(Map<String, dynamic> json) => SearchEntry(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? img;
  String? desc;
  String? name;
  String? type;
  String? author;
  List<Book>? book;

  Datum({
    this.img,
    this.desc,
    this.name,
    this.type,
    this.author,
    this.book,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        img: json["img"],
        desc: json["desc"],
        name: json["name"],
        type: json["type"],
        author: json["author"],
        book: json["book"] == null
            ? []
            : List<Book>.from(json["book"]!.map((x) => Book.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "desc": desc,
        "name": name,
        "type": type,
        "author": author,
        "book": book == null
            ? []
            : List<dynamic>.from(book!.map((x) => x.toJson())),
      };
}

class Book {
  String? name;
  String? url;
  String? bookNew;
  String? newurl;

  Book({
    this.name,
    this.url,
    this.bookNew,
    this.newurl,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        name: json["name"],
        url: json["url"],
        bookNew: json["new"],
        newurl: json["newurl"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "new": bookNew,
        "newurl": newurl,
      };
}
