import 'package:flutter/material.dart';
import 'package:novel_flutter_bit/entry/novel_hot_entry.dart';
import 'package:novel_flutter_bit/net/http_config.dart';
import 'package:novel_flutter_bit/net/novel_http.dart';
import 'package:novel_flutter_bit/net/service_result.dart';
import 'package:novel_flutter_bit/tools/logger_tools.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    ServiceResultData resultData =
        await NovelHttp().request('hot?category=全部', method: HttpConfig.get);
    LoggerTools.looger.d(resultData.msg);
    if (resultData.data case null) {
      return;
    }
    NovelHot novelHot = NovelHot.fromJson(resultData.data);
    LoggerTools.looger.d(novelHot);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('每日推荐')),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}
