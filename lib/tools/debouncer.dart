import 'dart:async';

class Debouncer {
  Timer? _timer;

  Debouncer();

  void debounce(Function() callback, Duration delay) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }
}
