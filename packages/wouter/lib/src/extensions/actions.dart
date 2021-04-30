import 'dart:async';

import '../delegate/delegate.dart';
import '../models/models.dart';

extension RoutingActionsExtensions<T extends WouterDelegateState>
    on RoutingActions<T> {
  void popUntil(PopPredicate<String> predicate) {
    if (hasParent) {
      return parent!.popUntil(predicate);
    }

    update((state) {
      var prevState;

      do {
        prevState = policy.onPop(state);
      } while (predicate(prevState.fullPath));

      return prevState;
    });
  }

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
          policy.buildSetter(completer),
        ));

    return completer.future;
  }
}
