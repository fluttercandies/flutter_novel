// To parse this JSON data, do
//
//     final novel = novelFromJson(jsonString);

import 'dart:convert';

Novel novelFromJson(String str) => Novel.fromJson(json.decode(str));

String novelToJson(Novel data) => json.encode(data.toJson());

class Novel {
  NovelData? data;

  Novel({
    this.data,
  });

  factory Novel.fromJson(Map<String, dynamic> json) => Novel(
        data: json["data"] == null ? null : NovelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class NovelData {
  String? name;
  String? text;
  String? next;
  String? up;

  NovelData({
    this.name,
    this.text,
    this.next,
    this.up,
  });

  factory NovelData.fromJson(Map<String, dynamic> json) => NovelData(
        name: json["name"],
        text: json["text"],
        next: json["next"],
        up: json["up"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "text": text,
        "next": next,
        "up": up,
      };
}
