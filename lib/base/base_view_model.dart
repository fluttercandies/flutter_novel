import 'package:flutter/material.dart';

/// ViewModel基类
abstract class BaseViewModel extends ChangeNotifier {
  /// 刷新
  Future<bool> onRefresh();
}

/// ViewModel基类
abstract class BaseViewModelImplements {
  /// 刷新
  Future<bool> onRefresh();
}
