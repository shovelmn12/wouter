import 'package:wouter/wouter.dart';

/// Extends [WouterAction] with methods to reset the navigation stack to a
/// specified new stack of routes.
extension ResetWouterActionExtension on WouterAction {
  /// Internal recursive helper function to perform the reset operation.
  ///
  /// It first pops all routes from the current [state]'s stack. Once the
  /// stack is empty (or cannot be popped further), it then pushes each path
  /// from the target [stack] (which should contain absolute paths at this point)
  /// to form the new navigation history.
  ///
  /// - [actions]: The [ActionBuilder] providing `pop` and `push` functionalities.
  /// - [state]: The current [WouterState] during the recursive popping or building phase.
  /// - [stack]: The list of absolute paths to form the new navigation stack.
  ///
  /// Returns a record `(WouterState, void)`:
  ///   - The final [WouterState] after all pops and subsequent pushes.
  ///   - `null` (void) as the result of the reset operation.
  (WouterState, void) _reset(
    ActionBuilder actions,
    WouterState state, [
    List<String> stack = const ["/"],
  ]) {
    // Try to pop from the current state.
    // `prev` is the state after the pop attempt.
    // `canStillPop` indicates if a route was successfully popped (or if popping is still possible).
    final (prev, canStillPop) = actions.pop(state);

    if (canStillPop && prev.stack.isNotEmpty) {
      // If a route was popped and the stack is not yet empty,
      // recurse to continue popping.
      return _reset(actions, prev, stack);
    }

    // If no more routes can be popped (stack is effectively cleared or at its base):
    // Rebuild the stack by pushing each path from the target `stack`.
    // `prev` here is the state after all possible pops (e.g., an empty stack state).
    return (
      stack.fold(
        prev, // Start with the state after all pops.
        (currentState, path) => actions
            .push(currentState, path)
            .$1, // Push path, take the new state.
      ),
      null, // Void result for the reset operation.
    );
  }

  /// Resets the navigation stack to a new state defined by the provided [stack]
  /// of paths.
  ///
  /// This operation effectively clears the current navigation history and
  /// establishes a new one. All existing routes are popped, and then the
  /// routes specified in the [stack] parameter are pushed in order.
  ///
  /// The paths in the [stack] parameter can be relative or absolute. They
  /// will be resolved against the `state.fullPath` (the full path *before*
  /// any reset operations begin) using the `actions.pathBuilder`.
  ///
  /// - [stack]: A list of path strings that will form the new navigation
  ///   stack. Defaults to `["/"]`, which means if called without arguments,
  ///   it resets the navigation to the root page.
  ///
  /// Example:
  /// ```dart
  /// // Reset to the home page
  /// context.wouter.actions.reset();
  ///
  /// // Reset to a specific deep link stack
  /// context.wouter.actions.reset(['/', '/users', '/users/123/profile']);
  ///
  /// // Reset to a new stack, potentially using relative paths from current location
  /// context.wouter.actions.reset(['../dashboard', 'overview']);
  /// ```
  void reset([
    List<String> stack = const ["/"],
  ]) =>
      // `this` refers to the WouterAction instance.
      // It invokes the WouterAction dispatcher with a handler function.
      this((actions, state) {
        // Resolve each path in the input `stack` against the current fullPath.
        // This ensures that if relative paths are provided, they are interpreted
        // correctly based on the state *before* the reset starts.
        final resolvedStack = stack
            .map((path) => actions.pathBuilder(state.fullPath, path))
            .toList();

        // Call the internal _reset helper with the resolved stack.
        return _reset(
          actions,
          state,
          resolvedStack,
        );
      });
}
