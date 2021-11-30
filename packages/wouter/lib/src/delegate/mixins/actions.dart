import 'dart:async';

import '../../models/models.dart';
import '../delegate.dart';

mixin DelegateRoutingActions<T extends RouteHistory> on BaseRouterDelegate<T> {
  RoutingPolicy<List<T>> get policy;

  void update(List<T> Function(List<T> state) callback) =>
      state = callback(state);

  @override
  Future<R?> push<R>(String path) {
    final completer = Completer<R?>();

    state = policy.onPush(
      path,
      state,
      policy.buildOnResultCallback(completer),
    );

    return completer.future;
  }

  @override
  bool pop([dynamic result]) {
    if (state.isNotEmpty) {
      state = policy.onPop(state, result);

      return true;
    }

    return false;
  }

  @override
  void reset(String path) {
    state.forEach((route) => route.onResult?.call(null));

    state = policy.onPush(
      path,
      <T>[],
    );
  }
}
