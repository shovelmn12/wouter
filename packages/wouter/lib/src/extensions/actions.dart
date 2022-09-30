import 'dart:async';

import 'package:wouter/wouter.dart';

extension BaseWouterExtensions on WouterState {
  List<T> _popUntil<T extends RouteEntry>(
    List<T> state,
    PopPredicate<String> predicate,
  ) {
    if (predicate(state.last.path)) {
      return state;
    }

    return _popUntil(policy.onPop(state), predicate);
  }

  void popUntil(PopPredicate<String> predicate) => type.map(
        root: (wouter) => wouter.delegate.update(
          (state) => _popUntil(policy.onPop(state), predicate),
        ),
        child: (wouter) => wouter.parent.popUntil(predicate),
      );

  void popTo(String path) => type.map(
        root: (wouter) {
          final next = wouter.policy.pushPath(
            wouter.path,
            base,
            path,
          );

          return popUntil((current) => next == current);
        },
        child: (wouter) => wouter.parent.popTo(
          wouter.policy.pushPath(
            wouter.policy.initial,
            base,
            path,
          ),
        ),
      );

  Future<T> replace<T>(String path, [dynamic result]) => type.map(
        root: (wouter) {
          final completer = Completer<T>();

          print('current ${wouter.delegate.state}');
          print('removing ${policy.onPop(wouter.delegate.state, result)}');
          print('pushing ${wouter.policy.pushPath(
            wouter.path,
            base,
            path,
          )}');

          wouter.delegate.update((state) => policy.onPush(
                wouter.policy.pushPath(
                  wouter.path,
                  base,
                  path,
                ),
                policy.onPop(state, result),
                policy.buildOnResultCallback(completer),
              ));

          return completer.future;
        },
        child: (wouter) => wouter.parent.replace(
          wouter.policy.pushPath(
            wouter.policy.initial,
            base,
            path,
          ),
          result,
        ),
      );
}
