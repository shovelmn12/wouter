import 'package:wouter/wouter.dart';

/// Extends [WouterAction] with methods to replace the current route with a new one.
extension ReplaceWouterActionsExtension on WouterAction {
  /// Internal helper function to perform the replace operation.
  /// It first pops the current route and then pushes the new route.
  ///
  /// - Generic Type `<R>`: The expected result type of the new pushed route.
  /// - [actions]: The [ActionBuilder] providing `pop` and `push` functionalities.
  /// - [state]: The current [WouterState] before any operations.
  /// - [path]: The absolute path of the new route to push.
  /// - [result]: An optional result to pass to the route being popped.
  ///
  /// Returns a record `(WouterState, Future<R?>)`:
  ///   - The final [WouterState] after both pop and push.
  ///   - A `Future<R?>` for the result of the newly pushed route.
  (WouterState, Future<R?>) _replace<R>(
    ActionBuilder actions,
    WouterState state,
    String path, [
    dynamic result,
  ]) {
    // Pop the current route, potentially passing a result.
    // `prev` is the WouterState after the pop.
    // `popped` is a boolean indicating if the pop was successful (not used here).
    final (prev, _) = actions.pop(state, result);

    // Push the new route onto the state resulting from the pop.
    return actions.push<R>(prev, path);
  }

  /// Replaces the current route with a new route specified by [path].
  ///
  /// This operation is equivalent to a pop followed immediately by a push.
  /// The [path] can be absolute or relative. If relative, it's resolved
  /// against the current `state.fullPath` *before* the pop operation.
  ///
  /// - Generic Type `<T>`: Represents the potential type of the result that
  ///   might be returned when the new (replacing) route is eventually popped.
  /// - [path]: The path of the new route to navigate to.
  /// - [result]: An optional dynamic value to pass as the result to the
  ///   route that is being replaced (i.e., the route being popped).
  ///
  /// Returns a `Future<T?>` that will complete with the result when the
  /// new (replacing) route is popped.
  ///
  /// Example:
  /// ```dart
  /// // Replace the current page with '/home'
  /// context.wouter.actions.replace<void>('/home');
  ///
  /// // Replace the current page with '/login', passing a result to the replaced page
  /// context.wouter.actions.replace<void>('/login', 'SessionExpired');
  ///
  /// // Replace and await a result from the new page
  /// String? newUserData = await context.wouter.actions.replace<String>('/edit-profile');
  /// ```
  Future<T?> replace<T>(String path, [dynamic result]) =>
      // `this` refers to the WouterAction instance.
      // It invokes the WouterAction dispatcher with a handler function.
      this((actions, state) {
        // Resolve the provided path against the current full path *before* any pop.
        final resolvedPath = actions.pathBuilder(state.fullPath, path);

        // Call the internal _replace helper with the resolved path.
        return _replace<T>(
          actions,
          state,
          resolvedPath,
          result,
        );
      });
}
