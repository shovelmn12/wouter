import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

mixin RouterState<T> on ChangeNotifier {
  T get state;

  @protected
  set state(T state);

  @protected
  bool shouldNotify(T prev, T next) => prev != next;

  @protected
  void onStateChanged(T prev, T next) {
    if (shouldNotify(prev, next)) {
      notifyListeners();
    }
  }
}

mixin StreamRouterState<T> on RouterState<T> {
  final _subject = BehaviorSubject<T>();

  Stream<T> get stream => _subject.stream;

  @override
  T get state => _subject.value;

  @override
  set state(T state) {
    final prev = _subject.valueOrNull;

    _subject.add(state);

    if (prev != null) {
      onStateChanged(prev, state);
    } else {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subject.close();

    super.dispose();
  }
}
