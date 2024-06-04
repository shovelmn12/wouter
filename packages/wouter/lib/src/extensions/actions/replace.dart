import 'package:wouter/wouter.dart';

extension ReplaceWouterActionsExtension on WouterAction {
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
