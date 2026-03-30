import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

/// Callback invoked when a route is popped with an optional result.
///
/// Uses [Object?] as the parameter type so routes that logically return a
/// concrete type (for example [Pet]?) can be represented on one stack without
/// forcing handlers to be typed as `void Function(dynamic)`—the erased value
/// is recovered with `as R?` only where the [Future] from [StackPolicy.push]
/// is completed.
typedef RouteResultCallback = void Function(Object?);

/// Represents an entry in the Wouter navigation stack.
///
/// Each [RouteEntry] typically corresponds to a specific path that has been
/// navigated to. It holds the `path` string and a callback (`onResult`)
/// to handle any result that might be passed back when this route is popped
/// from the stack.
///
/// This class uses the `freezed` package for generating immutable data class
/// boilerplate.
@freezed
sealed class RouteEntry with _$RouteEntry {
  /// Creates an instance of [RouteEntry], specifically a [PathRouteEntry].
  ///
  /// - [path]: The path string associated with this route entry (e.g., "/users/123").
  ///   This is the path that was used to navigate to this entry.
  /// - [onResult]: Invoked when this entry is popped. The value is typed as
  ///   [Object?] at the stack layer; callers that pushed with a typed result
  ///   should cast inside their completer logic (see [StackPolicy.push]).
  const factory RouteEntry({
    required String path,
    required RouteResultCallback onResult,
  }) = PathRouteEntry;
}
