import 'package:wouter/wouter.dart';

extension PopCountWouterActionExtension on WouterAction {
  void popCount(
    int times, [
    dynamic Function(String)? result,
  ]) =>
      this((actions, state) => state.stack
              .sublist(
            state.stack.length -
                times.clamp(
                  0,
                  state.stack.length,
                ),
          )
              .fold(
            (state, true),
            (acc, entry) => actions.pop(
              acc.$1,
              result?.call(entry.path),
            ),
          ));
}
