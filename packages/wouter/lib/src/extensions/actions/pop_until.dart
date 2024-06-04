import 'package:wouter/wouter.dart';

extension PopUntilWouterActionExtension on WouterAction {
  void popUntil(
    bool Function(String) predicate, [
    dynamic Function(String)? result,
  ]) =>
      this((actions, state) => state.stack.reversed
              .takeWhile((entry) => !predicate(entry.path))
              .fold(
            (state, true),
            (acc, entry) => actions.pop(
              acc.$1,
              result?.call(entry.path),
            ),
          ));
}
