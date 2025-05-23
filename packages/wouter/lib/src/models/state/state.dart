import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wouter/wouter.dart';

part 'state.freezed.dart';

/// Represents the current state of the Wouter router.
///
/// This immutable data class holds all essential information about the
/// current navigation state, including whether a "pop" operation is possible,
/// the base path for the current routing scope, and the stack of active
/// [RouteEntry] instances.
///
/// It uses the `freezed` package for generating boilerplate code such as
/// `copyWith`, `==`, `hashCode`, and `toString`.
@freezed
sealed class WouterState with _$WouterState {
  /// Creates an instance of [WouterState].
  ///
  /// - [canPop]: A boolean indicating whether the current navigation stack
  ///   can be popped. This is typically `true` if there is more than one
  ///   entry in the stack or if defined otherwise by the [StackPolicy].
  /// - [base]: The base path for the current routing context. For top-level
  ///   routing, this might be an empty string or "/". For nested routers,
  ///   this would be the path segment that leads to the nested router.
  ///   All paths in the [stack] are typically relative to this [base] or
  ///   are constructed considering it.
  /// - [stack]: An immutable list of [RouteEntry] objects representing the
  ///   current navigation stack. The last entry in the list is considered
  ///   the currently active route.
  const factory WouterState({
    required bool canPop,
    required String base,
    required List<RouteEntry> stack,
  }) = _WouterState; // Refers to the concrete class generated by Freezed
}

/// Extension on [WouterState] to provide convenient access to the path
/// of the currently active route.
extension WouterStatePathExtension on WouterState {
  /// Gets the path of the currently active route entry (the last entry in the stack).
  ///
  /// Returns the `path` property of the last [RouteEntry] in the [stack].
  /// If the stack is empty, it returns an empty string (`""`).
  String get path => stack.lastOrNull?.path ?? "";
}

/// Extension on [WouterState] to provide convenient access to the full,
/// absolute path of the currently active route.
extension WouterStateFullPathExtension on WouterState {
  /// Gets the full, absolute path of the currently active route.
  ///
  /// This is constructed by concatenating the [base] path of the [WouterState]
  /// with the [path] of the currently active route entry (obtained from
  /// the `WouterStatePathExtension.path` getter).
  ///
  /// For example, if `base` is `"/app"` and `path` is `"/settings"`,
  /// `fullPath` will be `"/app/settings"`.
  String get fullPath => '$base$path';
}
