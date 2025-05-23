import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

/// A widget that synchronizes a Flutter [Listenable] (e.g., a `TabController`,
/// `PageController`, or custom `ChangeNotifier`) with Wouter's navigation state.
///
/// `WouterListenable` is designed for scenarios where UI elements driven by a
/// `Listenable` (like tabs in a `TabBarView` or pages in a `PageView`) should
/// correspond to distinct routes in the Wouter system. It enables two-way
/// synchronization:
///
/// 1.  **Listenable to Wouter**: When the `Listenable` changes its state (e.g.,
///     user swipes to a new tab/page), `WouterListenable` updates Wouter's
///     current route (typically using a `replace` action) to reflect this change.
/// 2.  **Wouter to Listenable**: When Wouter's route changes (e.g., due to
///     browser back/forward buttons, or programmatic navigation), `WouterListenable`
///     updates the state of the `Listenable` (e.g., changing the active tab/page).
///
/// It requires several callback functions to bridge the gap between the
/// `Listenable`'s state (often represented by an index) and Wouter's path-based
/// routing.
///
/// The [builder] callback is used to construct the UI, typically passing the
/// [Listenable] instance and the list of child widgets (from [routes]) to
/// widgets like [TabBarView] or [PageView].
class WouterListenable<T extends Listenable> extends StatefulWidget {
  /// A function that creates the [Listenable] instance (`T`).
  /// It receives the [BuildContext] and an initial index derived from the
  /// current Wouter route.
  final CreateListenable<T> create;

  /// A function to dispose of the [Listenable] instance when this widget
  /// is removed from the tree.
  final DisposeListenable<T> dispose;

  /// A function that extracts an integer index (or a similar representative value)
  /// from the current state of the [Listenable] instance (`T`).
  /// This index is used to determine the corresponding route.
  final OnGetListenableIndex<T> index;

  /// A callback invoked when Wouter's route changes and the [Listenable] (`T`)
  /// needs to be updated to reflect the new route (represented by `int index`).
  /// This function is responsible for actually changing the `Listenable`'s state.
  final OnRouteChanged<T> onChanged;

  /// A map where keys are route path segments (relative to the WouterListenable's
  /// position in the routing tree) and values are the [Widget]s to be displayed
  /// for each corresponding state of the [Listenable].
  /// The order of `routes.values.toList()` is passed to the [builder].
  final Map<String, Widget> routes;

  /// A builder function that constructs the UI.
  /// It receives the [BuildContext], the [Listenable] instance (`T`), and a
  /// list of child widgets (derived from `widget.routes.values`).
  /// This is typically used to build widgets like `TabBar` + `TabBarView` or `PageView`.
  final WouterListenableWidgetBuilder<T> builder;

  /// A callback to convert an index (from the [Listenable]) into a full
  /// Wouter route path.
  /// It receives the `index`, the `base` Wouter path, the current Wouter `path`,
  /// and the list of route keys from `widget.routes`.
  final ToPathCallback toPath;

  /// A callback to convert a Wouter route path back into an index for the [Listenable].
  /// It receives the `base` Wouter path, the current Wouter `path`, and the
  /// list of route keys from `widget.routes`.
  final ToIndexCallback toIndex;

  /// Creates a [WouterListenable] widget.
  ///
  /// All parameters are required to establish the two-way binding between
  /// the [Listenable] and Wouter's navigation state.
  const WouterListenable({
    super.key,
    required this.create,
    required this.dispose,
    required this.index,
    required this.onChanged,
    required this.routes,
    required this.builder,
    required this.toPath,
    required this.toIndex,
  });

  @override
  State<WouterListenable<T>> createState() => _WouterListenableState<T>();
}

class _WouterListenableState<T extends Listenable>
    extends State<WouterListenable<T>> with WouterParentMixin {
  /// Composite subscription to manage all stream subscriptions.
  final _subscription = CompositeSubscription();

  /// A subject used as a flag to prevent feedback loops.
  /// When `true`, it indicates that a change originated from Wouter updating
  /// the Listenable, so the Listenable's subsequent change notification
  /// should not trigger a Wouter route update.
  final _changeSubject = BehaviorSubject.seeded(false);

  /// The [Listenable] instance managed by this widget.
  /// It's created using `widget.create`, with an initial index derived from
  /// the current Wouter path via `widget.toIndex`.
  late final T _listenable = widget.create(
    context,
    widget.toIndex(
          context.wouter.state.base, // Current Wouter base path from parent
          context.wouter.state.fullPath, // Current Wouter full path from parent
          widget.routes.keys
              .toList(), // List of route keys defined for this widget
        ) ??
        0, // Default to index 0 if no match
  );

  @override
  void initState() {
    super.initState();

    // Subscription 1: Listens to changes from the `_listenable` (e.g., user swipes a TabView).
    _subscription.add(
      _listenable
          .toStream<T>() // Convert Listenable changes to a stream
          .where((event) => !_changeSubject
              .value) // Only process if change isn't due to Wouter
          .mapNotNull(widget.index) // Get the current index from the Listenable
          .distinct() // Only process if the index has actually changed
          .map((index) => (
                index,
                widget.routes.keys.toList()
              )) // Pair index with route keys
          .distinct() // Ensure the pair is distinct (though index distinctness mostly covers this)
          .withLatestFrom(
              wouter,
              (data, state) =>
                  (data.$1, data.$2, state)) // Get latest Wouter state
          .mapNotNull((data) => widget.toPath(
                // Convert (index, Wouter state) to a new Wouter path
                data.$1, // index
                data.$3.base, // Wouter base path
                data.$3.fullPath, // Wouter full path
                data.$2, // route keys
              ))
          .listen(context.wouter.actions
              .replace), // Replace current Wouter route with the new path
    );

    // Subscription 2: Listens to changes from Wouter (e.g., browser back/forward).
    _subscription.add(
      wouter // Stream of WouterState from parent
          .distinct() // Process distinct Wouter states
          .map((state) =>
              (state.base, state.fullPath)) // Extract base and full path
          .distinct() // Process distinct (base, fullPath) pairs
          .mapNotNull((data) => widget.toIndex(
                // Convert Wouter path to an index for the Listenable
                data.$1, // Wouter base path
                data.$2, // Wouter full path
                widget.routes.keys.toList(), // route keys
              ))
          .distinct() // Only process if the derived index has changed
          .listen((index) async {
        // If the _changeSubject is still active (not closed)
        if (!_changeSubject.isClosed) {
          _changeSubject
              .add(true); // Set flag to prevent feedback loop from Listenable
        }

        // Call the onChanged callback to update the Listenable's state
        await widget.onChanged(_listenable, index);

        // If the _changeSubject is still active
        if (!_changeSubject.isClosed) {
          _changeSubject.add(false); // Reset flag
        }
      }),
    );
  }

  @override
  void dispose() {
    _subscription.dispose(); // Cancel all stream subscriptions
    _changeSubject.close(); // Close the feedback loop subject
    widget.dispose(context, _listenable); // Dispose the Listenable instance
    super.dispose();
  }

  /// Builds the UI using the `widget.builder`.
  /// Passes the context, the `_listenable` instance, and the list of
  /// widgets derived from `widget.routes.values`.
  @override
  Widget build(BuildContext context) => widget.builder(
        context,
        _listenable,
        widget.routes.values.toList(),
      );
}

/// Extension to convert a standard Flutter [Listenable] into a [Stream].
///
/// This allows using RxDart operators and patterns with `Listenable` objects.
extension _ListenableStreamExtension on Listenable {
  /// Converts this [Listenable] into a [Stream] that emits the [Listenable]
  /// itself whenever it notifies its listeners.
  ///
  /// The stream is a broadcast stream.
  /// It emits the current instance immediately upon listening.
  Stream<T> toStream<T extends Listenable>() {
    late final StreamController<T> controller;

    // Callback to be invoked when the Listenable changes.
    onChange() {
      if (!controller.isClosed) {
        controller.add(this as T); // Emit the Listenable instance
      }
    }

    controller = StreamController<T>.broadcast(
      onListen: () {
        addListener(onChange); // Register listener
        onChange(); // Emit current state immediately
      },
      onCancel: () => removeListener(onChange), // Unregister listener
    );

    return controller.stream;
  }
}
