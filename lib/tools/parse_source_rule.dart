import 'dart:convert';

import 'package:flutter_gbk2utf8/flutter_gbk2utf8.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';

/// 解析规则
/// 工具
/// 时间 2024-9-29
/// 7-bit
class ParseSourceRule {
  /// 解析所有匹配项
  /// 解析所有匹配项
  /// 解析所有匹配项
  static List<String?> parseAllMatches({
    required String rule,
    required String htmlData,
    String? rootSelector, // 根节点选择器
  }) {
    if (rule.isEmpty) {
      return [];
    }

    // 解析 HTML 数据
    Document document = parse(htmlData);

    // 选择根节点
    List<Element> rootNodes = [];
    if (rootSelector != null) {
      if (rootSelector.startsWith('class.')) {
        String className = rootSelector.split('.')[1];
        rootNodes = document.getElementsByClassName(className).toList();
      } else if (rootSelector.startsWith('#')) {
        String idSelector = rootSelector.substring(1);
        rootNodes = document.querySelectorAll('#$idSelector').toList();
      } else {
        rootNodes = document.getElementsByTagName(rootSelector).toList();
      }
    } else {
      rootNodes = [document.documentElement!]; // 默认根节点为文档根
    }

    // 解析规则字符串
    List<String> parts = rule.split('@');
    String rootPart = parts[0];
    List<Element> elements = [];

    // 处理根部分的标签选择器
    for (var rootNode in rootNodes) {
      List<Element> tempElements = [];
      if (rootPart.startsWith('class.')) {
        String className = rootPart.split('.')[1];
        tempElements.addAll(rootNode.getElementsByClassName(className));
      } else if (rootPart.startsWith('#')) {
        String idSelector = rootPart.substring(1);
        var element = rootNode.querySelector('#$idSelector');
        if (element != null) {
          tempElements.add(element);
        }
      } else if (rootPart.startsWith('id.')) {
        String idSelector = rootPart.split('.')[1];
        var element = rootNode.querySelector('#$idSelector');
        if (element != null) {
          tempElements.add(element);
        }
      } else {
        if (rootPart.startsWith(".")) {
          tempElements.addAll(rootNode.getElementsByTagName(rootPart));
        } else if (rootPart.contains('.')) {
          final data = rootPart.split(".");
          final element = rootNode
              .getElementsByTagName(data[0])[int.tryParse((data[1])) ?? 0];
          tempElements.add(element);
        } else {
          tempElements.addAll(rootNode.getElementsByTagName(rootPart));
        }
      }
      elements.addAll(tempElements); // 合并所有匹配的元素
    }

    if (elements.isEmpty) {
      LoggerTools.looger.i('Root element not found for $rootPart');
      return []; // 找不到元素时返回空数组
    }

    // 逐步解析标签和属性
    for (int i = 1; i < parts.length; i++) {
      String part = parts[i];
      List<Element> newElements = [];

      if (part.contains('>')) {
        // 处理子元素选择器
        List<String> directParts = part.split('>');
        String parentSelector = directParts[0].trim();
        String childTag = directParts[1].trim();

        for (var element in elements) {
          var parentElements = element.getElementsByTagName(parentSelector);
          for (var parent in parentElements) {
            newElements.addAll(parent.getElementsByTagName(childTag));
          }
        }
        elements = newElements;
      } else if (part.startsWith('tag.')) {
        String tagName = part.split('.')[1];
        for (var element in elements) {
          newElements.addAll(element.getElementsByTagName(tagName));
        }
        elements = newElements;
      } else if (part.startsWith('text')) {
        return elements.map((e) => e.text.trim()).toList();
      } else if (part.contains('href') || part.contains('src')) {
        final data = elements.map((e) {
          // 处理 a.0@href 格式
          if (part.startsWith('a.')) {
            var parts = part.split('.');
            if (parts.length == 2) {
              int index = int.parse(parts[1]);
              var aElements = e.getElementsByTagName('a');
              if (aElements.length > index) {
                return aElements[index].attributes['href'] ?? '';
              }
            }
          }
          return e.attributes[part] ?? e.attributes['src-data'];
        }).toList();
        return data.where((url) => url != null && url.isNotEmpty).toList();
      } else if (part.contains('img')) {
        final data = elements.map((e) {
          // 处理 img 格式

          var parts = part.split('||');

          return e.attributes[parts[0]] ??
              e.attributes[parts.length > 1 ? parts[1] : "src"];
        }).toList();
        return data.where((url) => url != null && url.isNotEmpty).toList();
      } else if (part == "content") {
        final data = elements.map((e) {
          // 处理 content 内容 格式
          return e.attributes["content"];
        }).toList();
        return data.where((text) => text != null && text.isNotEmpty).toList();
      }

      // 如果没有找到新元素，直接返回空数组
      if (elements.isEmpty) {
        return [];
      }
    }

    return elements.map((e) => e.text.trim()).toList();
  }

  /// 解析所有匹配项
  static List<String?> parseAllMatches1({
    required String rule,
    required String htmlData,
  }) {
    if (rule == "") {
      return [];
    }
    // 解析 HTML 数据
    Document document = parse(htmlData);

    // 解析规则字符串
    List<String> parts = rule.split('@');
    String rootPart = parts[0];
    List<Element>? elements = [];

    // 处理根部分的标签选择器
    if (rootPart.startsWith('class.')) {
      String className = rootPart.split('.')[1];
      elements = document.getElementsByClassName(className).toList();
    } else if (rootPart.startsWith('#')) {
      String idSelector = rootPart.substring(1);
      Element? element = document.getElementById(idSelector);
      if (element != null) {
        elements = [element];
      }
    } else {
      elements = document.getElementsByTagName(rootPart).toList();
    }

    if (elements.isEmpty) {
      LoggerTools.looger.i('Root element not found for $rootPart');
      return [];
    }

    // 逐步解析标签和属性
    for (int i = 1; i < parts.length; i++) {
      String part = parts[i];
      List<Element> newElements = [];

      if (part.startsWith('tag.')) {
        String tagName = part.split('.')[1];
        for (var element in elements!) {
          newElements.addAll(element.getElementsByTagName(tagName));
        }
        elements = newElements;
      } else if (part.startsWith('text')) {
        return elements!.map((e) => e.text.trim()).toList();
      } else if (part.contains('href') || part.contains('src')) {
        // if (part.contains('src')) {
        //   part = 'src';
        // } else {
        //   part = 'href';
        // }
        final data = elements!.map((e) {
          return e.attributes[part]; // 获取 href 属性值
        }).toList();
        return data.where((url) => url != null && url.isNotEmpty).toList();
      }
    }

    return elements!.map((e) => e.text.trim()).toList();
  }

  /// 搜索页url解析
  static String parseSearchUrl(
      {required String searchKey, required String searchUrl}) {
    // 从模板中提取 charset
    RegExp charsetPattern = RegExp(r'"charset":\s*"([^"]+)"');
    var match = charsetPattern.firstMatch(searchUrl);
    String charset =
        match != null ? match.group(1) ?? 'utf-8' : 'utf-8'; // 默认utf-8

    // 根据 charset 选择编码方式
    String encodedKey;
    if (charset.toLowerCase() == 'gbk') {
      encodedKey = _toGbkUrlEncoded(searchKey); // 使用 GBK 编码
    } else if (charset.toLowerCase() == 'utf-8') {
      encodedKey = _toUtf8UrlEncoded(searchKey); // 使用 UTF-8 编码
    } else {
      throw UnsupportedError('不支持的编码格式: $charset');
    }

    // 替换 searchUrl 中的 {{key}} 占位符
    String finalUrl = searchUrl.replaceAll('{{key}}', encodedKey);

    // 去掉 charset 部分
    String cleanUrl = finalUrl.split(',')[0]; // 只保留 "," 前面的部分
    // final Response<String> data =
    //     await _dio.get("${_sourceEntry.bookSourceUrl}$cleanUrl");
    return cleanUrl;
  }

  // 对字符串进行 GBK URL 编码
  static String _toGbkUrlEncoded(String input) {
    List<int> gbkBytes = gbk.encode(input); // 将字符串转换为GBK字节
    return gbkBytes
        .map((byte) =>
            '%${byte.toRadixString(16).padLeft(2, '0').toUpperCase()}')
        .join();
  }

// 对字符串进行 UTF-8 URL 编码
  static String _toUtf8UrlEncoded(String input) {
    List<int> utf8Bytes = utf8.encode(input); // 将字符串转换为UTF-8字节
    return utf8Bytes
        .map((byte) =>
            '%${byte.toRadixString(16).padLeft(2, '0').toUpperCase()}')
        .join();
  }

  /// 解析url
  static String parseUrl({
    required String bookSourceUrl,
    required String parseSearchUrl,
  }) {
    // 去除baseUrl末尾的斜杠（如果有）
    if (bookSourceUrl.endsWith('/')) {
      bookSourceUrl = bookSourceUrl.substring(0, bookSourceUrl.length - 1);
    }
    // 如果relativeUrl以斜杠开头，则去除
    if (parseSearchUrl.startsWith('/')) {
      parseSearchUrl = parseSearchUrl.substring(1);
    }
    return '$bookSourceUrl/$parseSearchUrl';
  }

  static String? parseCharset({
    required String htmlData,
  }) {
    // 解析 HTML 数据
    Document document = parse(htmlData);

    // 查找所有 <meta> 标签
    List<Element> metaTags = document.getElementsByTagName('meta').toList();

    // 遍历 <meta> 标签查找 charset 属性
    for (Element meta in metaTags) {
      String? charset = meta.attributes['charset'];
      if (charset != null) {
        return charset; // 如果找到 charset 属性则返回
      }
    }

    return null; // 如果未找到 charset 则返回 null
  }

  /// 解析html数据 解码 不同编码
  static String parseHtmlDecode(dynamic htmlData) {
    String resultData = gbk.decode(htmlData);
    final charset = ParseSourceRule.parseCharset(htmlData: resultData) ?? "gbk";
    if (charset.toLowerCase() == "utf-8" || charset.toLowerCase() == "utf8") {
      resultData = utf8.decode(htmlData);
    }
    return resultData;
  }
}
