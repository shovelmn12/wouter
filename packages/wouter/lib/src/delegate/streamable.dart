import 'dart:async';

import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

/// An abstract class providing access to the current [WouterState] both
/// synchronously via the [state] getter and asynchronously via the [stream].
///
/// This allows different parts of an application to either get the current
/// routing state on demand or subscribe to changes in the routing state.
///
/// It also includes factory constructors for creating default instances and
/// "child" instances, which represent a scoped view of a parent's routing state,
/// typically used for nested routing.
abstract class WouterStateStreamable {
  /// A stream that emits the [WouterState] whenever it changes.
  /// Implementations typically ensure that only distinct states are emitted.
  Stream<WouterState> get stream;

  /// Gets the current [WouterState] synchronously.
  WouterState get state;

  /// Internal constructor for subclasses.
  const WouterStateStreamable._();

  /// Creates a default instance of [WouterStateStreamable].
  ///
  /// - [source]: The primary stream of [WouterState] changes.
  /// - [state]: The initial [WouterState].
  ///
  /// This factory delegates to [_WouterStateStreamableImpl].
  factory WouterStateStreamable({
    required Stream<WouterState> source,
    required WouterState state,
  }) = _WouterStateStreamableImpl;

  /// Creates a "child" [WouterStateStreamable] that represents a scoped view
  /// of a parent's routing state, relative to a given [base] path.
  ///
  /// This is useful for nested routing scenarios where a child router only
  /// needs to be aware of routes that fall under its specific [base] path.
  ///
  /// - [base]: The base path for this child scope. Routes in the parent's
  ///   stack will be filtered and transformed relative to this base.
  /// - [source]: The parent's stream of [WouterState].
  /// - [state]: The parent's initial [WouterState].
  ///
  /// The resulting stream and state will have:
  /// - Their `base` property prefixed with the parent's `base` and then this [base].
  /// - Their `stack` filtered to include only entries starting with [base] (relative
  ///   to the parent's effective base), and the paths of these entries will be
  ///   made relative to this new child [base].
  factory WouterStateStreamable.child({
    required String base,
    required Stream<WouterState> source,
    required WouterState state,
  }) =>
      WouterStateStreamable(
        source: source.map((currentState) => currentState.copyWith(
              // Filter and transform stack relative to the new child base
              stack: _buildStack(base, currentState.stack),
              // Prepend the new base to the existing base
              base: "${currentState.base}$base",
            )),
        state: state.copyWith(
          stack: _buildStack(base, state.stack),
          base: "${state.base}$base",
        ),
      );

  /// A comparison function used to determine if two [WouterState] instances
  /// are different, primarily for use with `Stream.distinct()`.
  ///
  /// It considers two states different if:
  /// - The sequence of paths in their `stack` is different (using deep equality).
  /// - OR their `base` paths are different.
  ///
  /// This helps in preventing unnecessary updates if only superficial aspects
  /// of the state (not affecting routing decisions like stack paths or base) change.
  static bool _byState(WouterState prev, WouterState next) =>
      const DeepCollectionEquality().equals(
        prev.stack.map((e) => e.path).toList(),
        next.stack.map((e) => e.path).toList(),
      ) &&
      prev.base != next.base;

  /// Filters and transforms a parent's [stack] of [RouteEntry]s to be
  /// relative to a new [base] path for a child scope.
  ///
  /// 1. Finds the first entry in the parent [stack] whose path starts with [base].
  /// 2. If no such entry is found, returns an empty list.
  /// 3. Otherwise, takes all subsequent entries from the parent [stack] as long
  ///    as their paths continue to start with [base].
  /// 4. For each of these selected entries, it creates a new [RouteEntry] where
  ///    the `path` is made relative to [base] (i.e., [base] is stripped from
  ///    the beginning of the path). If the resulting path is empty, it's set to "/".
  ///
  /// - [base]: The base path for the child scope.
  /// - [stack]: The parent's list of [RouteEntry]s.
  ///
  /// Returns a new list of [RouteEntry]s suitable for the child scope.
  static List<RouteEntry> _buildStack(String base, List<RouteEntry> stack) {
    // Find the starting index of the segment relevant to this base.
    final start = stack.indexWhere((entry) => entry.path.startsWith(base));

    if (start < 0) {
      // If the base path is not found in the current stack, the child has an empty stack.
      return const [];
    }

    // Take entries from the start index that are under the base path,
    // and make their paths relative to this base.
    return stack
        .sublist(start)
        .takeWhile((entry) => entry.path.startsWith(base))
        .map((entry) {
      // Remove the base prefix from the path.
      final path = entry.path.replaceRange(0, base.length, "");

      // Return a new entry with the relative path.
      // If the path becomes empty, it means it's the root of this child scope.
      return entry.copyWith(
        path: path.isEmpty ? "/" : path,
      );
    }).toList();
  }

  /// Disposes of any resources held by the streamable object, such as
  /// stream subscriptions or subjects.
  ///
  /// The default implementation is a no-op, but concrete classes like
  /// [_WouterStateStreamableImpl] override this to perform actual cleanup.
  FutureOr<void> dispose() {}

  /// Returns a string representation of the current [WouterState].
  @override
  String toString() => "$state";
}

/// The default concrete implementation of [WouterStateStreamable].
///
/// It uses a [BehaviorSubject] to hold and broadcast the current [WouterState].
/// It subscribes to a `source` stream, applying a `distinct` operator
/// (using [WouterStateStreamable._byState]) to filter out consecutive
/// identical states, and updates its internal [BehaviorSubject] with new states.
class _WouterStateStreamableImpl extends WouterStateStreamable {
  /// The [BehaviorSubject] that holds the current state and broadcasts changes.
  final BehaviorSubject<WouterState> _subject;

  /// The stream of distinct [WouterState] changes.
  @override
  Stream<WouterState> get stream => _subject.stream.distinct();

  /// The subscription to the `source` stream.
  late final StreamSubscription<WouterState> _subscription;

  /// The current [WouterState].
  @override
  WouterState get state => _subject.value;

  /// Creates an instance of [_WouterStateStreamableImpl].
  ///
  /// - [source]: The primary stream of [WouterState] changes to listen to.
  /// - [state]: The initial [WouterState].
  ///
  /// It initializes its internal [BehaviorSubject] with the [state] and
  /// subscribes to the [source] stream. Only distinct states (determined by
  /// [WouterStateStreamable._byState]) from the [source] are propagated
  /// to the internal subject.
  _WouterStateStreamableImpl({
    required Stream<WouterState> source,
    required WouterState state,
  })  : _subject = BehaviorSubject.seeded(state),
        super._() {
    _subscription =
        source.distinct(WouterStateStreamable._byState).listen(_subject.add);
  }

  /// Disposes of the streamable state.
  ///
  /// This involves cancelling the subscription to the `source` stream and
  /// closing the internal [BehaviorSubject] to release resources.
  @override
  Future<void> dispose() async {
    await _subscription.cancel();
    await _subject.close();
  }
}
