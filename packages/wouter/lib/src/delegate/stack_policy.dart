import 'dart:async';

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
    String path,
  ) {
    final completer = Completer<R?>();

    return (
      state.copyWith(
        canPop: state.stack.isNotEmpty,
        stack: List<RouteEntry>.unmodifiable([
          ...state.stack,
          RouteEntry<R>(
            path: path,
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

  /// returns [WouterState] with popped stack and if stack can be popped again
  (WouterState, bool) pop(
    WouterState state, [
    dynamic result,
  ]) {
    if (!state.canPop) {
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
      next.isNotEmpty,
    );
  }
}
