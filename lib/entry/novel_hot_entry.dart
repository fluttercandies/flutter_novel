// To parse this JSON data, do
//
//     final novelHot = novelHotFromJson(jsonString);

import 'dart:convert';

NovelHot novelHotFromJson(String str) => NovelHot.fromJson(json.decode(str));

String novelHotToJson(NovelHot data) => json.encode(data.toJson());

class NovelHot {
  int? code;
  List<Datum>? data;
  String? msg;

  NovelHot({
    this.code,
    this.data,
    this.msg,
  });

  factory NovelHot.fromJson(Map<String, dynamic> json) => NovelHot(
        code: json["code"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
      };
}

class Datum {
  String? img;
  String? desc;
  String? hot;
  String? name;
  Type? type;
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
        type: typeValues.map[json["type"]]!,
        author: json["author"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "desc": desc,
        "hot": hot,
        "name": name,
        "type": typeValues.reverse[type],
        "author": author,
      };
}

enum Type { XH, LS, QH, KH, DS, JS, YX }

final typeValues = EnumValues({
  "玄幻": Type.XH,
  "历史": Type.LS,
  "奇幻": Type.QH,
  "科幻": Type.KH,
  "都市": Type.DS,
  "军事": Type.JS,
  "游戏": Type.YX
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
