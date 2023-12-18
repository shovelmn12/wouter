import 'dart:async';

import 'package:wouter/wouter.dart';

typedef _PushAction = (WouterState, Future<R?>) Function<R>(
    WouterState, String);

typedef _PopAction = (WouterState, bool) Function(WouterState, [dynamic]);

typedef _Actions = ({
  _PushAction push,
  _PopAction pop,
  PathBuilder pathBuilder,
});

typedef WouterActions = R Function<R>(
  (WouterState, R) Function(_Actions, WouterState),
);

typedef WouterActionsCallbacks = ({
  List<bool Function(String)> push,
  List<bool Function(String, [dynamic])> pop,
});

extension WouterReplaceActionExtension on WouterActions {
  Future<R?> push<R>(String path) => this((actions, state) => actions.push<R>(
        state,
        actions.pathBuilder(state.fullPath, path),
      ));

  bool pop([dynamic result]) => this((actions, state) {
        if (state.canPop) {
          return actions.pop(state);
        }

        return (state, false);
      });

  (WouterState, void) _reset(
    _Actions actions,
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
    _Actions actions,
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
