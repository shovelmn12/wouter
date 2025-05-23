import 'package:wouter/wouter.dart';

/// Extends [WouterAction] with a convenient method for pushing a new route
/// onto the navigation stack.
extension PushWouterActionExtension on WouterAction {
  /// Pushes a new route specified by [path] onto the navigation stack.
  ///
  /// The [path] can be absolute (e.g., `"/users/123"`) or relative
  /// (e.g., `"details"`, `"../settings"`). If relative, it is resolved
  /// against the current full path (`state.fullPath`) using the
  /// `actions.pathBuilder` provided by the Wouter system.
  ///
  /// - Generic Type `<R>`: Represents the potential type of the result that
  ///   might be returned when the pushed route is eventually popped.
  /// - [path]: The path of the route to navigate to.
  ///
  /// Returns a `Future<R?>` that will complete with the result when the
  /// pushed route is popped. If the route is popped without a result, or if
  /// the navigation system doesn't support results for this push, it might
  /// complete with `null`.
  ///
  /// This method dispatches the push action through the underlying
  /// [WouterAction] mechanism.
  ///
  /// Example:
  /// ```dart
  /// // Push an absolute path
  /// Future<UserProfile?> userProfileResult = context.wouter.actions.push<UserProfile>('/users/profile');
  ///
  /// // Push a relative path
  /// context.wouter.actions.push('item-details');
  ///
  /// // Wait for a result from a pushed route
  /// String? result = await context.wouter.actions.push<String>('/settings/edit-name');
  /// if (result != null) {
  ///   // Do something with the result
  /// }
  /// ```
  Future<R?> push<R>(String path) =>
      // `this` refers to the WouterAction instance.
      // It invokes the WouterAction dispatcher with a handler function.
      this((actions, state) {
        // Delegate to the ActionBuilder's push method with the resolved path.
        return actions.push<R>(
          state,
          // Resolve the provided path against the current full path.
          actions.pathBuilder(state.fullPath, path),
        );
      });
}
