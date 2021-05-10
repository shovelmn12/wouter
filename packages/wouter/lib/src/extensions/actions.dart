import 'dart:async';

import '../delegate/delegate.dart';
import '../models/models.dart';

extension RoutingActionsExtensions<T extends WouterDelegateState>
    on RoutingActions<T> {
  T _popUntil(T state, PopPredicate<String> predicate) {
    if (predicate(state.fullPath)) {
      return state;
    }

    return _popUntil(policy.onPop(state), predicate);
  }

  void popUntil(PopPredicate<String> predicate) {
    if (hasParent) {
      return parent!.popUntil(predicate);
    }

    update((state) => _popUntil(policy.onPop(state), predicate));
  }

  void popTo(String path) => popUntil((current) => path == current);

  Future<T> replace<T>(String path, [dynamic? result]) {
    if (hasParent) {
      return parent!.replace(
        policy.pushPath(
          state.base,
          state.fullPath,
          path,
        ),
        result,
      );
    }

    final completer = Completer<T>();

    update((state) => policy.onPush(
          policy.removeBase(state.base, path),
          state.stack.isEmpty ? state : policy.onPop(state, result),
          policy.buildOnResultCallback(completer),
        ));

    return completer.future;
  }
}
