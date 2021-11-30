import 'dart:async';

import '../delegate/delegate.dart';
import '../models/models.dart';

extension DelegateRoutingActionsExtensions<T extends RouteHistory>
    on DelegateRoutingActions<T> {
  List<T> _popUntil(List<T> state, PopPredicate<String> predicate) {
    if (predicate(state.last.path)) {
      return state;
    }

    return _popUntil(policy.onPop(state), predicate);
  }

  void popUntil(PopPredicate<String> predicate) =>
      update((state) => _popUntil(policy.onPop(state), predicate));

  void popTo(String path) => popUntil((current) => path == current);

  Future<T> replace<T>(String path, [dynamic result]) {
    final completer = Completer<T>();

    update((state) => policy.onPush(
          path,
          policy.onPop(state, result),
          policy.buildOnResultCallback(completer),
        ));

    return completer.future;
  }
}
