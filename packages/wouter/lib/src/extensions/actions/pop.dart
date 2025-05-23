import 'package:wouter/wouter.dart';

/// Extends [WouterAction] with a simplified method for popping the current route.
extension PopWouterActionExtension on WouterAction {
  /// Pops the current route from the navigation stack.
  ///
  /// This method provides a convenient way to trigger a pop action. It first
  /// checks if the current [WouterState] `canPop`. If not, the action is
  /// a no-op and returns `false`. Otherwise, it delegates to the underlying
  /// `actions.pop` mechanism.
  ///
  /// - [result]: An optional dynamic value to pass back to the route that is
  ///   being revealed by this pop operation.
  ///   **Note**: In the current implementation of this specific extension method,
  ///   the provided `result` is not explicitly passed to `actions.pop(state)`.
  ///   If passing a result is intended, `actions.pop(state, result)` should be used
  ///   within the dispatcher.
  ///
  /// Returns `true` if a route was successfully popped (or at least if the
  /// underlying `actions.pop` indicated success), and `false` if `state.canPop`
  /// was `false` at the time of the call.
  ///
  /// Example:
  /// ```dart
  /// // Pop the current route
  /// bool didPop = context.wouter.actions.pop();
  ///
  /// // Pop the current route with a result
  /// bool didPopWithResult = context.wouter.actions.pop('dataFromPoppedRoute');
  /// ```
  bool pop([dynamic result]) =>
      // `this` refers to the WouterAction instance.
      // It invokes the WouterAction dispatcher with a handler function.
      this((actions, state) {
        // Check if the current state allows popping.
        if (!state.canPop) {
          // If cannot pop, return the current state and false (pop failed).
          return (state, false);
        }

        // If can pop, delegate to the ActionBuilder's pop method.
        // Note: The `result` parameter from the extension method is available here
        // but not explicitly passed to `actions.pop(state)` in this snippet.
        // To pass the result, it should be `actions.pop(state, result)`.
        return actions.pop(state, result); // Corrected to pass the result
      });
}
