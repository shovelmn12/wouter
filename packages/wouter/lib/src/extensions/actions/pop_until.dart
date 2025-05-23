import 'package:wouter/wouter.dart';

/// Extends [WouterAction] with a method to pop routes from the navigation stack
/// until a route satisfying a given predicate is reached.
extension PopUntilWouterActionExtension on WouterAction {
  /// Pops routes from the top of the navigation stack until a route is found
  /// whose path satisfies the given [predicate].
  ///
  /// The route that satisfies the [predicate] will become the new current route
  /// (i.e., it will not be popped). All routes above it in the stack will be popped.
  ///
  /// If no route satisfies the predicate, all routes will be popped until only
  /// the initial route remains (or the stack becomes empty if that's possible
  /// according to the stack policy, though typically the root route is preserved).
  ///
  /// - [predicate]: A function `bool Function(String)` that takes the path of
  ///   a [RouteEntry] and returns `true` if this is the route to stop at.
  ///   Popping will cease *before* this route is popped.
  /// - [result]: An optional function `dynamic Function(String)?` that can
  ///   provide a result for each route being popped. This function is called
  ///   with the `path` of the route being popped, and its return value is
  ///   passed as the result for that specific pop operation. If `null`, no
  ///   result is passed for the pop operations.
  ///
  /// This method dispatches a sequence of individual pop actions.
  ///
  /// Example:
  /// ```dart
  /// // Pop until the '/home' route is reached
  /// context.wouter.actions.popUntil((path) => path == '/home');
  ///
  /// // Pop until a route named '/settings' is reached, providing results
  /// context.wouter.actions.popUntil(
  ///   (path) => path == '/settings',
  ///   (poppedPath) {
  ///     if (poppedPath == '/settings/profile/edit') {
  ///       return 'ChangesDiscarded';
  ///     }
  ///     return null;
  ///   }
  /// );
  /// ```
  void popUntil(
    bool Function(String) predicate, [
    dynamic Function(String)? result,
  ]) =>
      // `this` refers to the WouterAction instance.
      // It invokes the WouterAction dispatcher with a handler function.
      this((actions, state) {
        // Iterate through the stack in reverse order (from top to bottom).
        // `takeWhile` collects routes as long as the predicate is *not* met
        // for the current route's path. This means it collects all routes
        // that should be popped. The iteration stops when `predicate(entry.path)`
        // becomes true, and that route (the one satisfying the predicate)
        // is *not* included in the `routesToPop` collection.
        final routesToPop = state.stack.reversed
            .takeWhile((entry) => !predicate(entry.path))
            .toList(); // Convert to list to ensure order for fold.

        // Use fold to sequentially apply pop actions for each route in `routesToPop`.
        // The initial accumulator `acc` is a tuple: (currentState, successFlag).
        return routesToPop.fold(
          (state, true), // Initial state and a placeholder boolean.
          (acc, entry) {
            // `acc.$1` is the WouterState from the previous pop operation (or initial state).
            // `entry.path` is the path of the current route being popped.
            // `result?.call(entry.path)` calls the result function if provided.
            return actions.pop(
              acc.$1, // The current state after previous pops.
              result?.call(entry.path), // The result for this specific pop.
            );
          },
          // The WouterAction handler expects (WouterState, R) to be returned.
          // Here, R is void. The result of the fold is
          // (WouterState_after_all_pops, bool_from_last_pop).
        );
      });
}
