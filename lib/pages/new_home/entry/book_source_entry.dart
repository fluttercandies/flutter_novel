// To parse this JSON data, do
//
//     final bookSourceEntry = bookSourceEntryFromJson(jsonString);

import 'dart:convert';

BookSourceEntry bookSourceEntryFromJson(String str) =>
    BookSourceEntry.fromJson(json.decode(str));

String bookSourceEntryToJson(BookSourceEntry data) =>
    json.encode(data.toJson());

class BookSourceEntry {
  /// 书籍源的注释
  String? bookSourceComment;

  /// 书籍源的分组
  String? bookSourceGroup;

  /// 书籍源的名称
  String? bookSourceName;

  /// 书籍源的类型
  int? bookSourceType;

  /// 书籍源的基础URL
  String? bookSourceUrl;

  /// 用于匹配书籍详细页面URL的正则表达式
  String? bookUrlPattern;

  /// 自定义排序
  int? customOrder;

  /// 是否启用这个书籍源
  bool? enabled;

  /// 是否启用Cookie管理
  bool? enabledCookieJar;

  /// 是否启用探索功能
  bool? enabledExplore;

  /// HTTP请求头信息
  String? header;

  /// 最后更新时间
  String? lastUpdateTime;

  /// 响应时间
  int? respondTime;

  /// 定义了如何从书籍信息页面提取信息的规则
  RuleBookInfo? ruleBookInfo;

  /// 定义了如何从内容页面提取文本内容的规则
  RuleContent? ruleContent;

  /// 定义了探索功能使用的规则
  List<dynamic>? ruleExplore;

  /// 定义了搜索功能使用的规则
  RuleSearch? ruleSearch;

  /// 定义了目录页面提取规则
  RuleToc? ruleToc;

  /// 搜索书籍时使用的URL模板
  String? searchUrl;

  /// 权重
  int? weight;

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
            : RuleBookInfo.fromJson(json["ruleBookInfo"]),
        ruleContent: json["ruleContent"] == null
            ? null
            : RuleContent.fromJson(json["ruleContent"]),
        ruleExplore: json["ruleExplore"] == null
            ? []
            : List<dynamic>.from(json["ruleExplore"]!.map((x) => x)),
        ruleSearch: json["ruleSearch"] == null
            ? null
            : RuleSearch.fromJson(json["ruleSearch"]),
        ruleToc:
            json["ruleToc"] == null ? null : RuleToc.fromJson(json["ruleToc"]),
        searchUrl: json["searchUrl"],
        weight: json["weight"],
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
        "ruleExplore": ruleExplore == null
            ? []
            : List<dynamic>.from(ruleExplore!.map((x) => x)),
        "ruleSearch": ruleSearch?.toJson(),
        "ruleToc": ruleToc?.toJson(),
        "searchUrl": searchUrl,
        "weight": weight,
      };
}

class RuleBookInfo {
  /// 作者
  String? author;

  /// 封面URL
  String? coverUrl;

  /// 简介
  String? intro;

  /// 类型、状态、更新时间
  String? kind;

  /// 最后更新章节
  String? lastChapter;

  /// 书名
  String? name;

  RuleBookInfo({
    this.author,
    this.coverUrl,
    this.intro,
    this.kind,
    this.lastChapter,
    this.name,
  });

  factory RuleBookInfo.fromJson(Map<String, dynamic> json) => RuleBookInfo(
        author: json["author"],
        coverUrl: json["coverUrl"],
        intro: json["intro"],
        kind: json["kind"],
        lastChapter: json["lastChapter"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "coverUrl": coverUrl,
        "intro": intro,
        "kind": kind,
        "lastChapter": lastChapter,
        "name": name,
      };
}

class RuleContent {
  /// 正文内容
  String? content;

  /// 替换正则表达式
  String? replaceRegex;

  RuleContent({
    this.content,
    this.replaceRegex,
  });

  factory RuleContent.fromJson(Map<String, dynamic> json) => RuleContent(
        content: json["content"],
        replaceRegex: json["replaceRegex"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "replaceRegex": replaceRegex,
      };
}

class RuleSearch {
  /// 作者
  String? author;

  /// 书籍列表选择器
  String? bookList;

  /// 书籍URL
  String? bookUrl;

  /// 封面URL
  String? coverUrl;

  /// 最新章节
  String? lastChapter;

  /// 书名
  String? name;

  RuleSearch({
    this.author,
    this.bookList,
    this.bookUrl,
    this.coverUrl,
    this.lastChapter,
    this.name,
  });

  factory RuleSearch.fromJson(Map<String, dynamic> json) => RuleSearch(
        author: json["author"],
        bookList: json["bookList"],
        bookUrl: json["bookUrl"],
        coverUrl: json["coverUrl"],
        lastChapter: json["lastChapter"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "bookList": bookList,
        "bookUrl": bookUrl,
        "coverUrl": coverUrl,
        "lastChapter": lastChapter,
        "name": name,
      };
}

class RuleToc {
  /// 章节列表
  String? chapterList;

  /// 章节名称
  String? chapterName;

  /// 章节URL
  String? chapterUrl;

  /// 下一目录页面的URL
  String? nextTocUrl;

  RuleToc({
    this.chapterList,
    this.chapterName,
    this.chapterUrl,
    this.nextTocUrl,
  });

  factory RuleToc.fromJson(Map<String, dynamic> json) => RuleToc(
        chapterList: json["chapterList"],
        chapterName: json["chapterName"],
        chapterUrl: json["chapterUrl"],
        nextTocUrl: json["nextTocUrl"],
      );

  Map<String, dynamic> toJson() => {
        "chapterList": chapterList,
        "chapterName": chapterName,
        "chapterUrl": chapterUrl,
        "nextTocUrl": nextTocUrl,
      };
}
