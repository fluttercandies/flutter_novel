// To parse this JSON data, do
//
//     final novelDetail = novelDetailFromJson(jsonString);

import 'dart:convert';

DetailNovel novelDetailFromJson(String str) =>
    DetailNovel.fromJson(json.decode(str));

String novelDetailToJson(DetailNovel data) => json.encode(data.toJson());

class DetailNovel {
  NovelDetailData? data;

  DetailNovel({
    this.data,
  });

  factory DetailNovel.fromJson(Map<String, dynamic> json) => DetailNovel(
        data: json["data"] == null
            ? null
            : NovelDetailData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class NovelDetailData {
  String? img;
  String? desc;
  String? name;
  String? type;
  String? author;
  List<ListElement>? list;

  NovelDetailData({
    this.img,
    this.desc,
    this.name,
    this.type,
    this.author,
    this.list,
  });

  factory NovelDetailData.fromJson(Map<String, dynamic> json) =>
      NovelDetailData(
        img: json["img"],
        desc: json["desc"],
        name: json["name"],
        type: json["type"],
        author: json["author"],
        list: json["list"] == null
            ? []
            : List<ListElement>.from(
                json["list"]!.map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "desc": desc,
        "name": name,
        "type": type,
        "author": author,
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class ListElement {
  String? name;
  String? url;

  ListElement({
    this.name,
    this.url,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
