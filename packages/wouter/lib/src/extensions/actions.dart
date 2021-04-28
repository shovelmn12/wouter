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

  Future<T> popAndPush<T>(String path, [dynamic? result]) {
    if (hasParent) {
      return parent!.popAndPush(path, result);
    }

    final completer = Completer<T>();

    update((state) {
      final prevState = policy.onPop(state, result);

      return policy.onPush(path, prevState, completer.complete);
    });

    return completer.future;
  }
}
