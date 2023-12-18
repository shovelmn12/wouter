import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:wouter/wouter.dart';
import 'package:path/path.dart';

class StackPolicy {
  final PathBuilder pathBuilder;

  const StackPolicy({
    this.pathBuilder = defaultPathBuilder,
  });

  static String defaultPathBuilder(String current, String path) {
    if (path.isEmpty) {
      return "/";
    } else if (path.startsWith("/")) {
      return normalize(path);
    } else {
      return normalize("$current/$path");
    }
  }

  (WouterState, Future<R?>) push<R>(
    WouterState state,
    PushPredicate predicate,
    String path,
  ) {
    final next = pathBuilder(state.fullPath, path);

    if (!predicate(next)) {
      return (state, Future<R>.value());
    }

    final completer = Completer<R?>();

    return (
      state.copyWith(
        canPop: state.stack.isNotEmpty,
        stack: List<RouteEntry>.unmodifiable([
          ...state.stack,
          RouteEntry<R>(
            path: next,
            onResult: (R? value) {
              if (completer.isCompleted) {
                return;
              }

              completer.complete(value);
            },
          ),
        ]),
      ),
      completer.future,
    );
  }

  (WouterState, bool) pop(
    WouterState state,
    PopPredicate predicate, [
    dynamic result,
  ]) {
    if (!predicate(state.fullPath, result)) {
      return (state, true);
    }

    if (state.stack.isEmpty) {
      return (state, false);
    }

    final next = List<RouteEntry>.of(state.stack);

    if (next.isNotEmpty) {
      next.removeLast().onResult?.call(result);
    }

    return (
      state.copyWith(
        canPop: next.length > 1,
        stack: List<RouteEntry>.unmodifiable(next),
      ),
      true,
    );
  }
}
