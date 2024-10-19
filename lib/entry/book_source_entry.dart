// To parse this JSON data, do
//
//     final bookSourceEntry = bookSourceEntryFromJson(jsonString);

import 'dart:convert';

List<BookSourceEntry> bookSourceEntryFromJson(String str) =>
    List<BookSourceEntry>.from(
        json.decode(str).map((x) => BookSourceEntry.fromJson(x)));

String bookSourceEntryToJson(List<BookSourceEntry> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookSourceEntry {
  String? bookSourceComment;
  String? bookSourceGroup;
  String? bookSourceName;
  int? bookSourceType;
  String? bookSourceUrl;
  String? bookUrlPattern;
  int? customOrder;
  bool? enabled;
  bool? enabledCookieJar;
  bool? enabledExplore;
  String? header;
  String? lastUpdateTime;
  int? respondTime;
  Rule? ruleBookInfo;
  RuleContent? ruleContent;
  dynamic ruleExplore;
  Rule? ruleSearch;
  RuleToc? ruleToc;
  String? searchUrl;
  int? weight;
  String? exploreScreen;
  String? exploreUrl;
  List<dynamic>? ruleReview;

  BookSourceEntry({
    this.bookSourceComment,
    this.bookSourceGroup,
    this.bookSourceName,
    this.bookSourceType,
    this.bookSourceUrl,
    this.bookUrlPattern,
    this.customOrder,
    this.enabled,
    this.enabledCookieJar,
    this.enabledExplore,
    this.header,
    this.lastUpdateTime,
    this.respondTime,
    this.ruleBookInfo,
    this.ruleContent,
    this.ruleExplore,
    this.ruleSearch,
    this.ruleToc,
    this.searchUrl,
    this.weight,
    this.exploreScreen,
    this.exploreUrl,
    this.ruleReview,
  });

  factory BookSourceEntry.fromJson(Map<String, dynamic> json) =>
      BookSourceEntry(
        bookSourceComment: json["bookSourceComment"],
        bookSourceGroup: json["bookSourceGroup"],
        bookSourceName: json["bookSourceName"],
        bookSourceType: json["bookSourceType"],
        bookSourceUrl: json["bookSourceUrl"],
        bookUrlPattern: json["bookUrlPattern"],
        customOrder: json["customOrder"],
        enabled: json["enabled"],
        enabledCookieJar: json["enabledCookieJar"],
        enabledExplore: json["enabledExplore"],
        header: json["header"],
        lastUpdateTime: json["lastUpdateTime"],
        respondTime: json["respondTime"],
        ruleBookInfo: json["ruleBookInfo"] == null
            ? null
            : Rule.fromJson(json["ruleBookInfo"]),
        ruleContent: json["ruleContent"] == null
            ? null
            : RuleContent.fromJson(json["ruleContent"]),
        ruleExplore: json["ruleExplore"],
        ruleSearch: json["ruleSearch"] == null
            ? null
            : Rule.fromJson(json["ruleSearch"]),
        ruleToc:
            json["ruleToc"] == null ? null : RuleToc.fromJson(json["ruleToc"]),
        searchUrl: json["searchUrl"],
        weight: json["weight"],
        exploreScreen: json["exploreScreen"],
        exploreUrl: json["exploreUrl"],
        ruleReview: json["ruleReview"] == null
            ? []
            : List<dynamic>.from(json["ruleReview"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "bookSourceComment": bookSourceComment,
        "bookSourceGroup": bookSourceGroup,
        "bookSourceName": bookSourceName,
        "bookSourceType": bookSourceType,
        "bookSourceUrl": bookSourceUrl,
        "bookUrlPattern": bookUrlPattern,
        "customOrder": customOrder,
        "enabled": enabled,
        "enabledCookieJar": enabledCookieJar,
        "enabledExplore": enabledExplore,
        "header": header,
        "lastUpdateTime": lastUpdateTime,
        "respondTime": respondTime,
        "ruleBookInfo": ruleBookInfo?.toJson(),
        "ruleContent": ruleContent?.toJson(),
        "ruleExplore": ruleExplore,
        "ruleSearch": ruleSearch?.toJson(),
        "ruleToc": ruleToc?.toJson(),
        "searchUrl": searchUrl,
        "weight": weight,
        "exploreScreen": exploreScreen,
        "exploreUrl": exploreUrl,
        "ruleReview": ruleReview == null
            ? []
            : List<dynamic>.from(ruleReview!.map((x) => x)),
      };
}

class Rule {
  String? author;
  String? coverUrl;
  String? intro;
  String? kind;
  String? lastChapter;
  String? name;
  String? tocUrl;
  String? wordCount;
  String? bookList;
  String? bookUrl;
  String? checkKeyWord;

  Rule({
    this.author,
    this.coverUrl,
    this.intro,
    this.kind,
    this.lastChapter,
    this.name,
    this.tocUrl,
    this.wordCount,
    this.bookList,
    this.bookUrl,
    this.checkKeyWord,
  });

  factory Rule.fromJson(Map<String, dynamic> json) => Rule(
        author: json["author"],
        coverUrl: json["coverUrl"],
        intro: json["intro"],
        kind: json["kind"],
        lastChapter: json["lastChapter"],
        name: json["name"],
        tocUrl: json["tocUrl"],
        wordCount: json["wordCount"],
        bookList: json["bookList"],
        bookUrl: json["bookUrl"],
        checkKeyWord: json["checkKeyWord"],
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "coverUrl": coverUrl,
        "intro": intro,
        "kind": kind,
        "lastChapter": lastChapter,
        "name": name,
        "tocUrl": tocUrl,
        "wordCount": wordCount,
        "bookList": bookList,
        "bookUrl": bookUrl,
        "checkKeyWord": checkKeyWord,
      };
}

class RuleContent {
  String? content;
  String? replaceRegex;
  String? nextContentUrl;

  RuleContent({
    this.content,
    this.replaceRegex,
    this.nextContentUrl,
  });

  factory RuleContent.fromJson(Map<String, dynamic> json) => RuleContent(
        content: json["content"],
        replaceRegex: json["replaceRegex"],
        nextContentUrl: json["nextContentUrl"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "replaceRegex": replaceRegex,
        "nextContentUrl": nextContentUrl,
      };
}

class RuleToc {
  String? chapterList;
  String? chapterName;
  String? chapterUrl;
  String? nextTocUrl;
  String? formatJs;
  String? updateTime;

  RuleToc({
    this.chapterList,
    this.chapterName,
    this.chapterUrl,
    this.nextTocUrl,
    this.formatJs,
    this.updateTime,
  });

  factory RuleToc.fromJson(Map<String, dynamic> json) => RuleToc(
        chapterList: json["chapterList"],
        chapterName: json["chapterName"],
        chapterUrl: json["chapterUrl"],
        nextTocUrl: json["nextTocUrl"],
        formatJs: json["formatJs"],
        updateTime: json["updateTime"],
      );

  Map<String, dynamic> toJson() => {
        "chapterList": chapterList,
        "chapterName": chapterName,
        "chapterUrl": chapterUrl,
        "nextTocUrl": nextTocUrl,
        "formatJs": formatJs,
        "updateTime": updateTime,
      };
}
