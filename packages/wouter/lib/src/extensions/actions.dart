import 'dart:async';

import 'package:wouter/wouter.dart';

extension BaseWouterExtensions on BaseWouter {
  // List<T> _popUntil<T extends RouteEntry>(
  //   List<T> state,
  //   PopPredicate<String> predicate,
  // ) {
  //   if (predicate(state.last.path)) {
  //     return state;
  //   }

  //   return _popUntil(policy.onPop(state), predicate);
  // }

  // void popUntil(PopPredicate<String> predicate) {
  //   parent?.popUntil(predicate) ??
  //       update((state) => _popUntil(policy.onPop(state), predicate));
  // }

  // void popTo(String path) => type.map(
  //       root: (wouter) {
  //         final next = wouter.policy.pushPath(
  //           wouter.path,
  //           wouter.policy.buildPath(base, path),
  //         );
  //
  //         return popUntil((current) => next == current);
  //       },
  //       child: (wouter) => wouter.parent.popTo(
  //         wouter.policy.buildPath(base, path),
  //       ),
  //     );

  Future<T> replace<T>(String path, [dynamic result]) {
    Future<T> _replace(String path, [dynamic result]) {
      final completer = Completer<T>();

      update((state) => policy.onPush(
            policy.pushPath(
              path,
              policy.buildPath(base, path),
            ),
            policy.onPop(state, result),
            policy.buildOnResultCallback(completer),
          ));

      return completer.future;
    }

    return parent?.replace<T>(path, result) ?? _replace(path, result);
  }
}
