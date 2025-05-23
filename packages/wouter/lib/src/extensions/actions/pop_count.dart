import 'package:wouter/wouter.dart';

/// Extends [WouterAction] with a convenient method to pop multiple routes
/// from the navigation stack at once.
extension PopCountWouterActionExtension on WouterAction {
  /// Pops a specified number of routes from the top of the navigation stack.
  ///
  /// This method provides a way to go back multiple steps in the navigation
  /// history with a single call.
  ///
  /// - [times]: The number of routes to pop. This value is clamped to be
  ///   between 0 and the current stack depth. If `times` is 0, no routes
  ///   are popped. If `times` is greater than the stack depth, all
  ///   routes up to the root will be popped.
  /// - [result]: An optional function that can provide a result for each
  ///   route being popped. This function is called with the `path` of the
  ///   route being popped and its return value is passed as the result
  ///   for that specific pop operation. If `null`, no result is passed
  ///   for the pop operations.
  ///
  /// This method dispatches a sequence of individual pop actions using the
  /// underlying [WouterAction] mechanism.
  ///
  /// Example:
  /// ```dart
  /// // Pop the last 2 routes
  /// context.wouter.actions.popCount(2);
  ///
  /// // Pop 3 routes, providing a specific result for each popped route
  /// context.wouter.actions.popCount(3, (path) {
  ///   if (path == '/checkout/payment') {
  ///     return 'PaymentCancelled';
  ///   }
  ///   return null;
  /// });
  /// ```
  void popCount(
    int times, [
    dynamic Function(String)? result,
  ]) =>
      // `this` refers to the WouterAction instance.
      // It invokes the WouterAction dispatcher with a handler function.
      this((actions, state) {
        // Determine the actual number of routes to pop, clamped to the stack size.
        final popOperations = times.clamp(
          0,
          state.stack.length, // Cannot pop more items than are on the stack.
        );

        // Get the sublist of RouteEntrys that will be popped.
        // This sublist starts from (stack.length - popOperations) up to the end.
        final entriesToPop = state.stack.sublist(
          state.stack.length - popOperations,
        );

        // Use fold to sequentially apply pop actions.
        // The initial accumulator `acc` is a tuple: (currentState, successFlag).
        // The successFlag from `actions.pop` is not explicitly used here to change
        // control flow, as popCount aims to pop a specific number if possible.
        return entriesToPop.fold(
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
          // Here, R is void (or technically the bool from the last pop, but
          // popCount itself is void).
          // The result of the fold is (WouterState_after_all_pops, bool_from_last_pop).
          // We only care about the final state and don't return a specific result for popCount.
        );
      });
}
