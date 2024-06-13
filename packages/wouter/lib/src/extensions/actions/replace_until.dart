import 'package:wouter/wouter.dart';

extension ReplaceUntilWouterActionExtension on WouterAction {
  Future<R?> replaceUntil<R>(
    String path,
    bool Function(String) predicate, [
    dynamic Function(String)? result,
  ]) =>
      this(
        (actions, state) {
          final popped = state.stack.reversed
              .takeWhile((entry) => !predicate(entry.path))
              .fold(
            (state, true),
            (acc, entry) => actions.pop(
              acc.$1,
              result?.call(entry.path),
            ),
          ).$1;

          return actions.push<R>(
            popped,
            actions.pathBuilder(popped.fullPath, path),
          );
        },
      );
}
