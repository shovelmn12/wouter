import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:wouter/wouter.dart';

/// A function that builds [RegexpData] from a route pattern string.
///
/// - [pattern]: The string pattern to be compiled into a regular expression.
/// - [caseSensitive]: Whether the regular expression should be case-sensitive.
/// - [prefix]: Whether the pattern should only match the prefix of a path.
///
/// Returns [RegexpData] which likely encapsulates a [RegExp] and other
/// metadata derived from the pattern.
typedef RegexpBuilder = RegexpData Function(
  String pattern, {
  bool caseSensitive,
  bool prefix,
});

/// A function that constructs a new path string, typically by combining a
/// [current] path with a relative [path] segment.
///
/// This is useful for resolving relative navigation paths.
///
/// - [current]: The current absolute path.
/// - [path]: The path segment to append or resolve against the [current] path.
///
/// Returns the resolved absolute path string.
typedef PathBuilder = String Function(String current, String path);

/// A predicate function used to determine if a "push" navigation action
/// to a given [path] should be allowed or processed.
///
/// - [path]: The target path for the push operation.
///
/// Returns `true` if the push action should proceed, `false` otherwise.
/// This can be used for implementing navigation guards or pre-navigation checks.
typedef PushPredicate = bool Function(String path);

/// A predicate function used to determine if a "pop" navigation action
/// from a given [path] (with an optional [result]) should be allowed or processed.
///
/// - [path]: The path of the route being popped.
/// - [result]: An optional result being passed back from the popped route.
///
/// Returns `true` if the pop action should proceed, `false` otherwise.
/// This can be used for implementing navigation guards (e.g., "are you sure
/// you want to leave?") or pre-pop checks.
typedef PopPredicate = bool Function(String path, [dynamic result]);

/// A builder function that creates a widget for a specific route.
///
/// - [context]: The build context for the widget.
/// - [arguments]: A map of dynamic arguments extracted from the route path
///   or passed during navigation. These often include path parameters
///   (e.g., `/users/:id` would provide `id` in the arguments).
///
/// Returns the [Widget] to be displayed for the matched route.
typedef WouterWidgetBuilder = Widget Function(
  BuildContext context,
  Map<String, dynamic> arguments,
);

/// A factory function that creates an instance of a [PathMatcher].
///
/// This allows for different path matching strategies to be provided or configured.
/// Returns a [PathMatcher] instance.
typedef PathMatcherBuilder = PathMatcher Function();

/// A function that attempts to match a given [path] against a specified [pattern].
///
/// - [path]: The actual URL path string to be matched.
/// - [pattern]: The route pattern (e.g., `/users/:id`, `/products/*`)
///   against which the [path] is compared.
/// - [prefix]: If `true`, the [pattern] should match only the beginning of the [path].
///   If `false` (default), the [pattern] must match the entire [path].
///
/// Returns [MatchData] if the [path] matches the [pattern], otherwise `null`.
/// [MatchData] would typically contain extracted path parameters.
typedef PathMatcher = MatchData? Function(
  String path,
  String pattern, {
  bool prefix,
});

/// A builder function for creating a widget that responds to changes in a listenable [T].
///
/// - [BuildContext]: The build context.
/// - [T]: The current value of the listenable.
/// - `List<Widget>`: A list of child widgets, often used in layouts like
///   [TabBarView] where children correspond to different states of the listenable.
///
/// Returns the [Widget] to be built based on the listenable's state and children.
/// This is commonly used for integrating with `Listenable` objects to rebuild
/// parts of the UI when the listenable notifies its listeners, for example,
/// managing the active tab in a `TabBar` and `TabBarView` setup.
typedef WouterListenableWidgetBuilder<T> = Widget Function(
  BuildContext,
  T,
  List<Widget>,
);

/// A function that creates and returns a listenable object of type [T].
///
/// - [context]: The build context, potentially used for accessing dependencies
///   or theme information during creation.
/// - [int]: An integer, often representing an initial index or state for the
///   listenable (e.g., initial tab index).
///
/// Returns an instance of [T], which should be a `Listenable`.
typedef CreateListenable<T> = T Function(BuildContext, int);

/// A function responsible for disposing of a listenable object [T]
/// when it's no longer needed.
///
/// - [context]: The build context.
/// - [T]: The listenable object to be disposed.
///
/// This is crucial for releasing resources and preventing memory leaks.
typedef DisposeListenable<T> = void Function(BuildContext, T);

/// A function that retrieves an index (or a similar representative integer value)
/// from a listenable object [T].
///
/// - [T]: The listenable object.
///
/// Returns an `int?` representing the current index or state. This is often
/// used to synchronize the listenable's state (e.g., a `TabController`'s index)
/// with the router's state.
typedef OnGetListenableIndex<T> = int? Function(T);

/// A callback function that is invoked when the route associated with a
/// listenable [T] (at a given [int] index) changes.
///
/// - [T]: The listenable object whose associated route has changed.
/// - [int]: The new index or state reflecting the route change.
///
/// Returns a [FutureOr<void>], allowing for asynchronous operations upon
/// a route change. This can be used to trigger side effects or update
/// other parts of the application in response to navigation.
typedef OnRouteChanged<T> = FutureOr<void> Function(T, int);

/// A callback function to convert an [index] and a [base] path into a full
/// route path string, considering a list of available [routes].
///
/// This is typically used in indexed navigation scenarios (e.g., tabs, bottom
/// navigation bars) to determine the URL path corresponding to a selected index.
///
/// - [index]: The numerical index of the desired route.
/// - [base]: The base path for the indexed routes (e.g., `/settings`).
/// - [path]: The specific path segment for the given [index] from the [routes] list.
/// - [routes]: A list of path segments corresponding to each index.
///
/// Returns the fully resolved path string (e.g., `/settings/profile` if base is
/// `/settings` and the route for the index is `profile`), or `null` if
/// a path cannot be determined.
typedef ToPathCallback = String? Function(
  int index,
  String base,
  String path,
  List<String> routes,
);

/// A callback function to convert a full [path] string back into an [index],
/// given a [base] path and a list of known [routes].
///
/// This is the inverse of [ToPathCallback] and is used to determine which
/// index (e.g., which tab) corresponds to the current URL path.
///
/// - [base]: The base path for the indexed routes.
/// - [path]: The current full path string to be resolved to an index.
/// - [routes]: A list of path segments corresponding to each index.
///
/// Returns the `int?` index if the [path] matches one of the [routes]
/// under the [base] path, or `null` if no match is found.
typedef ToIndexCallback = int? Function(
  String base,
  String path,
  List<String> routes,
);
