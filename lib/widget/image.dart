// ignore_for_file: must_be_immutable

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

/// 图片 加载
class ExtendedImageBuild extends StatelessWidget {
  ExtendedImageBuild(
      {super.key,
      required this.url,
      this.width = 120,
      this.height = 150,
      this.fit = BoxFit.cover,
      this.isJoinUrl = false});
  late String url;
  late bool isJoinUrl;
  late double width;
  late double? height;
  late BoxFit? fit;
  //final _joinStr = "https://api.book.bbdaxia.com/";
  @override
  Widget build(BuildContext context) {
    // if (isJoinUrl) {
    //   url = _joinStr + url;
    // }
    return ExtendedImage.network(
      url,
      cache: true,
      width: width,
      fit: fit,
      height: height,
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return const Center(child: CircularProgressIndicator());
          case LoadState.completed:
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ExtendedRawImage(
                  image: state.extendedImageInfo?.image, fit: fit),
            );
          case LoadState.failed:
            return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return const Center(child: Text("加载失败"));
            });
        }
      },
    );
  }
}
