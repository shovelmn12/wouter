import 'dart:async';

import 'package:wouter/wouter.dart';
import 'package:path/path.dart';

/// Defines a policy for managing the navigation stack in Wouter.
///
/// This class provides the core logic for how routes are added (pushed)
/// onto the stack, removed (popped) from the stack, and how relative
/// paths are resolved.
///
/// It's designed to be a foundational piece that can be extended or replaced
/// if different stack management behaviors are required, though the default
/// implementation covers common use cases.
class StackPolicy {
  /// A function used to resolve and build absolute paths from potentially
  /// relative path segments.
  ///
  /// See [defaultPathBuilder] for the default implementation details.
  final PathBuilder pathBuilder;

  /// Creates a [StackPolicy].
  ///
  /// - [pathBuilder]: An optional [PathBuilder] function to customize path
  ///   resolution. If not provided, [defaultPathBuilder] is used.
  const StackPolicy({
    this.pathBuilder = defaultPathBuilder,
  });

  /// The default path resolution logic used by [StackPolicy].
  ///
  /// It handles various path formats:
  /// - If [path] is empty, it returns `"/"` (root path).
  /// - If [path] starts with `/`, it's treated as an absolute path and returned as is.
  /// - If [path] starts with `.#` or `.?` (e.g., `.#fragment`, `.?query=value`),
  ///   it appends the part after the `.` (e.g., `#fragment`, `?query=value`)
  ///   to the [current] path. This is useful for adding fragments or query parameters
  ///   to the current path.
  /// - Otherwise, it treats [path] as a relative segment and joins it with the
  ///   [current] path, then normalizes the result using `normalize` from
  ///   the `package:path/path.dart`. For example, if `current` is `/a/b` and
  ///   `path` is `../c`, the result would be `/a/c`.
  ///
  /// - [current]: The current absolute path.
  /// - [path]: The path segment to resolve.
  ///
  /// Returns the resolved absolute path string.
  static String defaultPathBuilder(String current, String path) {
    if (path.isEmpty) {
      return "/";
    } else if (path.startsWith("/")) {
      return path;
    } else if (path.startsWith(".#") || path.startsWith(".?")) {
      // For paths like ".#hash" or ".?query", append to current path.
      return "$current${path.substring(1)}";
    } else {
      // For relative paths, join and normalize.
      return normalize("$current/$path");
    }
  }

  /// Pushes a new route entry onto the navigation stack.
  ///
  /// It creates a new [RouteEntry] for the given [path] and adds it to a
  /// copy of the current [state.stack]. A [Completer] is created to allow
  /// the pushed route to return a result when it's eventually popped.
  ///
  /// - [state]: The current [WouterState].
  /// - [path]: The path string for the new route to be pushed.
  /// - Generic [R]: The expected type of the result that the pushed route might return.
  ///
  /// Returns a record `(WouterState, Future<R?>)` containing:
  ///   - The new [WouterState] with the updated stack and `canPop` status.
  ///     `canPop` will be true if the stack was not empty before this push.
  ///   - A `Future<R?>` that completes with the result when the pushed route is popped.
  (WouterState, Future<R?>) push<R>(
    WouterState state,
    String path,
  ) {
    final completer = Completer<R?>();

    return (
      state.copyWith(
        // canPop is true if there's at least one item already in the stack,
        // meaning the *new* state (after this push) will definitely be poppable.
        canPop: state.stack.isNotEmpty,
        stack: List<RouteEntry>.unmodifiable([
          ...state.stack,
          RouteEntry<R>(
            path: path,
            onResult: (R? value) {
              if (completer.isCompleted) {
                return; // Avoid completing more than once
              }
              completer.complete(value);
            },
          ),
        ]),
      ),
      completer.future,
    );
  }

  /// Pops the top-most route entry from the navigation stack.
  ///
  /// If the stack is not empty, it removes the last [RouteEntry] and invokes
  /// its `onResult` callback, passing the provided [result].
  ///
  /// - [state]: The current [WouterState].
  /// - [result]: An optional dynamic value to be passed as the result to the
  ///   popped route's `onResult` callback.
  ///
  /// Returns a record `(WouterState, bool)` containing:
  ///   - The new [WouterState] with the updated stack and `canPop` status.
  ///     `canPop` will be true if the new stack contains more than one entry
  ///     (implying it can still be popped further).
  ///   - A `bool` indicating whether the stack was non-empty *after* the pop
  ///     operation (i.e., if `next.isNotEmpty`). This effectively means if there
  ///     are still routes on the stack.
  (WouterState, bool) pop(
    WouterState state, [
    dynamic result,
  ]) {
    // Create a mutable copy of the stack.
    final next = List<RouteEntry>.of(state.stack);

    if (next.isNotEmpty) {
      // Remove the last entry and call its onResult callback.
      next.removeLast().onResult(result);
    }

    return (
      state.copyWith(
        // The state can be popped again if the resulting stack has more than one item.
        // (Assuming the root item isn't considered "poppable" in the same way)
        // Or, more simply, if there's more than one route remaining to show a "back" gesture.
        canPop: next.length > 1,
        stack: List<RouteEntry>.unmodifiable(next),
      ),
      // Returns true if the stack is still not empty after the pop,
      // indicating a route was successfully processed (even if it was the last one).
      next.isNotEmpty,
    );
  }
}
