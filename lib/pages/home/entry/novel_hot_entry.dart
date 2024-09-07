// To parse this JSON data, do
//
//     final novelHot = novelHotFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

NovelHot novelHotFromJson(String str) => NovelHot.fromJson(json.decode(str));

String novelHotToJson(NovelHot data) => json.encode(data.toJson());

class NovelHot {
  List<Datum>? data;

  NovelHot({this.data});

  @override
  factory NovelHot.fromJson(Map<String, dynamic> json) => NovelHot(
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
  String? hot;
  String? name;
  String? type;
  String? author;

  Datum({
    this.img,
    this.desc,
    this.hot,
    this.name,
    this.type,
    this.author,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        img: json["img"],
        desc: json["desc"],
        hot: json["hot"],
        name: json["name"],
        type: json["type"],
        author: json["author"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "desc": desc,
        "hot": hot,
        "name": name,
        "type": type,
        "author": author,
      };
}
