import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:novel_flutter_bit/pages/category/enum/category_enum.dart';
import 'package:novel_flutter_bit/pages/category/view_model/category_view_model.dart';
import 'package:novel_flutter_bit/tools/padding_extension.dart';
import 'package:novel_flutter_bit/tools/size_extension.dart';
import 'package:novel_flutter_bit/widget/empty.dart';
import 'package:novel_flutter_bit/widget/loading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoryPage extends ConsumerStatefulWidget {
  const CategoryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends ConsumerState<CategoryPage> {
  /// 分类列表
  final List<CategoryEnum> _categoryList = CategoryEnum.values;

  /// 当前选中的索引
  int _currentIndex = 0;

  late ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    final categoryViewModel = ref.watch(
        categoryViewModelProvider(categoryEnum: _categoryList[_currentIndex]));
    _theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('分类列表')),
      body: CustomScrollView(slivers: [
        _buildCateGoryList(),
        SliverPadding(
            padding: 10.padding,
            sliver: const SliverToBoxAdapter(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('全网最热-分类', style: TextStyle(fontSize: 16)),
                Icon(Icons.chevron_right)
              ],
            ))),
      ]),
      // switch (categoryViewModel) {
      //   AsyncData(:final value) => Builder(builder: (BuildContext context) {
      //       //LoggerTools.looger.e(value.netState);
      //       return NetStateTools.getWidget(value.netState) ??
      //           _buildSuccess(value: value);
      //     }),
      //   AsyncError() => const EmptyBuild(),
      //   _ => const LoadingBuild(),
      // }
    );
  }

  /// 构建分类列表
  SliverPadding _buildCateGoryList() {
    return SliverPadding(
      padding: 10.padding,
      sliver: SliverToBoxAdapter(
        child: MasonryGridView.count(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: _categoryList.length,
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 8,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                });
              },
              child: _buildCateGoryItem(_categoryList[index]),
            );
          },
        ),
      ),
    );
  }

  ///  构建分类列表 item
  Widget _buildCateGoryItem(CategoryEnum categoryEnum) {
    Color color = const Color.fromARGB(255, 243, 243, 243);
    Color? textColor = _theme.textTheme.bodyLarge?.color?.withOpacity(.4);
    if (_categoryList[_currentIndex] == categoryEnum) {
      color = _theme.primaryColor;
      textColor = Colors.white;
    }
    return AnimatedContainer(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color), //_theme.primaryColor.withOpacity()
      duration: Durations.short2,
      child: Text(categoryEnum.name, style: TextStyle(color: textColor)),
    );
  }
}
