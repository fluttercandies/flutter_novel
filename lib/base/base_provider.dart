import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderConsumer<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final T viewModel;
  final Widget? child;
  final Function(T)? onReady;

  /// ChangeNotifierProvider 在某种场景下,程序热启动时会失效,但是ChangeNotifierProvider<T>.value会一直保持状态
  final bool? isValue;
  const ProviderConsumer(
      {super.key,
      required this.viewModel,
      this.child,
      this.onReady,
      required this.builder,
      this.isValue});

  @override
  State<ProviderConsumer> createState() => _ProviderConsumerState<T>();
}

class _ProviderConsumerState<T extends ChangeNotifier>
    extends State<ProviderConsumer<T>> {
  @override
  void initState() {
    super.initState();
    if (widget.onReady != null) {
      widget.onReady!(widget.viewModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isValue == true) {
      return ChangeNotifierProvider<T>.value(
        value: widget.viewModel,
        child: Consumer<T>(
          builder: widget.builder,
          child: widget.child,
        ),
      );
    } else {
      return ChangeNotifierProvider<T>(
        create: (_) => widget.viewModel,
        child: Consumer<T>(
          builder: widget.builder,
          child: widget.child,
        ),
      );
    }
  }
}
