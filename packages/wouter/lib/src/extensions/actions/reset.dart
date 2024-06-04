import 'package:wouter/wouter.dart';

extension ResetWouterActionExtension on WouterAction {
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
}
