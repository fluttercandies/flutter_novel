![示例图片](https://m.qpic.cn/psc?/V13kbO6L1NnSEN/LiySpxowE0yeWXwBdXN*STQ.Aqq*ouV8lzjkVT0hQzfHSa8Cw3Teo5Lt5YnKhxap1gzFFdwJHMxLJRyCdr4KIhlvFs0Hri7JBdfKPDOubiQ!/b&bo=AAqQAQAKkAEFFzQ!&rf=viewer_4)

<p align="center">
    <a href='https://github.com/7-bit11/novel_flutter_bit'><img alt="Github stars" src="https://img.shields.io/github/stars/7-bit11/novel_flutter_bit?logo=github"></a>
    <a href='https://github.com/7-bit11/novel_flutter_bit'><img alt="Github stars" src="https://img.shields.io/github/forks/7-bit11/novel_flutter_bit?logo=github"></a>
    <a target="_blank" href="https://jq.qq.com/?_wv=1027&k=5bcc0gy"><img border="0" src="https://pub.idqqimg.com/wpa/images/group.png" alt="flutter-candies" title="flutter-candies">FlutterCandies糖果技术交流</a>
    <a target="_blank" href="https://qm.qq.com/cgi-bin/qm/qr?k=mYfvheURi3cqPskrWXaLddE5MyslIIy8&jump_from=webapi&authKey=pGJ8ddoO9qrnRY0AKs7pEML06J4s02WaJRs0KDJsDQju9kw8GYX0WevrACX96c8o"><img border="0" src="//pub.idqqimg.com/wpa/images/group.png" alt="造物主动态桌面Ⅰ群" title="造物主动态桌面Ⅰ群">造物主动态桌面Ⅰ群</a>
</p>

## 项目介绍

novel_flutter_app 《爱看》是一款开源的阅读APP，拥有功能。热门推荐、小说排行、全网搜索、小说分类、关键字查询、收藏小说、本地历史阅读记录、主题设置、阅读定位。功能持续更新中。

## 项目地址

暂定xxx

## 项目结构

```
lib
├── base -- 请求状态、页面状态
├── db -- 数据缓存
├── icons -- 图标
├── net -- 网络请求、网络状态
└── pages
    ├── home -- 首页
    ├── novel -- 小说阅读
    ├── search -- 全网搜索
    ├── category -- 小说分类
    ├── detail_novel -- 小说详情
    ├── book_novel -- 书架、站源
    └── collect_novel -- 小说收藏
├── route -- 路由
└── theme -- 主题管理
    └── themes -- 主题颜色-9种颜色
├── tools -- 工具类 、日志、防抖。。。
└── widget -- 自定义组件、工具 、加载、状态、图片 等。。。。。。
```

## 使用框架

|                                | 版本
|------------------------------- | ---------------------------
| FlutterSDK                     |  3.24.0
| DartSDK                        |  3.5.0
| logger                         |  日志插件^1.0.8
| auto_route                     |  路由^9.2.2 
| dio                            |  网络请求^5.7.0
| pull_to_refresh_notification   |  刷新^3.1.0
| extended_image                 |  图片^8.2.1
| flutter_svg                    |  SVG^2.0.10+1
| extended_text                  |  文本^14.1.0
| flutter_staggered_grid_view    |  瀑布流^0.4.1
| shared_preferences             |  本地存储^2.3.2
| flutter_smart_dialog           |  弹窗提示^4.9.8+1
| flutter_riverpod               |  状态管理^2.5.1
| riverpod_annotation            |  ^2.3.5
| syncfusion_flutter_sliders     |  滑动选择器 ^26.2.14
| sliver_head_automatic_adsorption| 自动吸附Sliver ^1.0.8
