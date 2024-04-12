import 'dart:async';

import 'package:wouter/wouter.dart';

typedef PushAction = (WouterState, Future<R?>) Function<R>(WouterState, String);

typedef PopAction = (WouterState, bool) Function(WouterState, [dynamic]);

typedef ActionBuilder = ({
  PushAction push,
  PopAction pop,
  PathBuilder pathBuilder,
});

typedef WouterAction = R Function<R>(
  (WouterState, R) Function(ActionBuilder, WouterState),
);

typedef WouterActionsCallbacks = ({
  List<bool Function(String)> push,
  List<bool Function(String, [dynamic])> pop,
});

extension WouterActionsExtension on WouterAction {
  Future<R?> push<R>(String path) => this((actions, state) => actions.push<R>(
        state,
        actions.pathBuilder(state.fullPath, path),
      ));

  bool pop([dynamic result]) => this((actions, state) => actions.pop(state));

  (WouterState, void) _reset(
    ActionBuilder actions,
    WouterState state, [
    List<String> stack = const ["/"],
  ]) {
    final (prev, canPop) = actions.pop(state);

    if (canPop) {
      return _reset(actions, prev, stack);
    }

    return (
      stack.fold(
        prev,
        (state, path) => actions.push(state, path).$1,
      ),
      null,
    );
  }

  /// Resets the state as if only [path] been pushed.
  void reset([
    List<String> stack = const ["/"],
  ]) =>
      this((actions, state) => _reset(
            actions,
            state,
            stack
                .map((path) => actions.pathBuilder(state.fullPath, path))
                .toList(),
          ));

  (WouterState, Future<R?>) _replace<R>(
    ActionBuilder actions,
    WouterState state,
    String path, [
    dynamic result,
  ]) {
    final (prev, popped) = actions.pop(state, result);

    if (popped) {
      return actions.push<R>(prev, path);
    }

    return (state, Future<R>.value());
  }

  Future<T?> replace<T>(String path, [dynamic result]) =>
      this((actions, state) => _replace(
            actions,
            state,
            actions.pathBuilder(state.fullPath, path),
            result,
          ));
}
