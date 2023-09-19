// import 'package:flutter/widgets.dart';
//
// mixin StateChangeNotifier<T> on ChangeNotifier {
//   T get state;
//
//   @protected
//   set state(T state);
//
//   @protected
//   bool shouldNotify(T prev, T next) => prev != next;
//
//   @protected
//   void onStateChanged(T prev, T next) {
//     if (shouldNotify(prev, next)) {
//       notifyListeners();
//     }
//   }
// }
//
// mixin ValueStateChangeNotifier<T> on StateChangeNotifier<T> {
//   T? _state;
//
//   T get initialState;
//
//   @override
//   T get state => _state ?? initialState;
//
//   @override
//   set state(T state) {
//     final prev = this.state;
//
//     _state = state;
//
//     onStateChanged(prev, state);
//   }
// }
