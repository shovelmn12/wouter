import 'package:wouter/wouter.dart';

/// Extends [WouterAction] with a method to replace a segment of the
/// navigation stack with a new route.
///
/// This operation first pops routes from the top of the stack until a specified
/// [predicate] is met, then pushes a new [path] onto the modified stack.
extension ReplaceUntilWouterActionExtension on WouterAction {
  /// Pops routes from the navigation stack until a route satisfying the [predicate]
  /// is reached, and then pushes the new [path] onto the stack.
  ///
  /// This is effectively a "pop until then push" operation. The route that
  /// satisfies the [predicate] will become the route below the newly pushed route.
  ///
  /// - Generic Type `<R>`: Represents the potential type of the result that
  ///   might be returned when the newly pushed route (specified by [path])
  ///   is eventually popped.
  /// - [path]: The path of the new route to push after the pop operations.
  ///   This path is resolved relative to the path of the state *after* all
  ///   pop operations have completed.
  /// - [predicate]: A function `bool Function(String)` that takes the path of
  ///   a [RouteEntry] and returns `true` if this is the route to stop popping at.
  ///   Popping will cease *before* this route is popped.
  /// - [result]: An optional function `dynamic Function(String)?` that can
  ///   provide a result for each route being popped during the "pop until" phase.
  ///   This function is called with the `path` of each route being popped.
  ///
  /// Returns a `Future<R?>` that will complete with the result when the
  /// newly pushed route (specified by [path]) is popped.
  ///
  /// Example:
  /// ```dart
  /// // Imagine stack: /a -> /b -> /c -> /d
  /// // Replace /c and /d with /e, stopping before /b
  /// context.wouter.actions.replaceUntil<void>(
  ///   '/e',
  ///   (routePath) => routePath == '/b'
  /// );
  /// // New stack: /a -> /b -> /e
  ///
  /// // Provide results for popped routes
  /// context.wouter.actions.replaceUntil<void>(
  ///   '/new-checkout',
  ///   (routePath) => routePath == '/cart',
  ///   (poppedPath) {
  ///     if (poppedPath == '/checkout/shipping') return 'ShippingCancelled';
  ///     return null;
  ///   }
  /// );
  /// ```
  Future<R?> replaceUntil<R>(
    String path,
    bool Function(String) predicate, [
    dynamic Function(String)? result,
  ]) =>
      this(
        (actions, state) {
          // Phase 1: Pop routes until the predicate is met.
          // `state.stack.reversed.takeWhile(...)` collects routes to be popped.
          final stateAfterPops = state.stack.reversed
              .takeWhile((entry) => !predicate(entry.path))
              .fold(
            // Initial accumulator: (current WouterState, a boolean success flag from pop)
            (state, true),
            (acc, entryToPop) => actions.pop(
              acc.$1, // The WouterState from the previous pop or initial state
              result
                  ?.call(entryToPop.path), // Result for the route being popped
            ),
          ).$1; // Extract the WouterState from the tuple returned by fold.

          // Phase 2: Push the new path.
          // The new path is resolved relative to the fullPath of the state *after*
          // the pop operations have completed.
          return actions.push<R>(
            stateAfterPops,
            actions.pathBuilder(stateAfterPops.fullPath, path),
          );
        },
      );
}
