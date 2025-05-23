import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

/// A mixin for [State] classes that need to access and react to the
/// [WouterStateStreamable] provided by a parent Wouter scope.
///
/// This mixin simplifies obtaining the Wouter state stream from the [BuildContext]
/// and ensures that the stream reference is updated if the provided
/// [WouterStateStreamable] instance changes (e.g., due to a parent [Wouter]
/// widget rebuilding with a different base path).
///
/// It exposes a `wouter` getter, which is a [Stream<WouterState>] that
/// emits the current Wouter state from the appropriate parent scope. This stream
/// intelligently switches to the new `WouterStateStreamable.stream` if the
/// instance provided by `context.watch<WouterStateStreamable>()` changes.
mixin WouterParentMixin<T extends StatefulWidget> on State<T> {
  /// A [BehaviorSubject] that holds the current [WouterStateStreamable] instance
  /// obtained from the widget tree via `Provider`.
  ///
  /// It's seeded with the initially read [WouterStateStreamable].
  late final BehaviorSubject<WouterStateStreamable> _wouterSubject =
      BehaviorSubject.seeded(context.read<WouterStateStreamable>());

  /// A [Stream<WouterState>] that provides the Wouter navigation state.
  ///
  /// This stream is derived by `switchMap`-ping over the `_wouterSubject`.
  /// Whenever `_wouterSubject` emits a new [WouterStateStreamable] instance
  /// (because the one provided by the context has changed), this stream
  /// unsubscribes from the old `WouterStateStreamable.stream` and subscribes
  /// to the new one. This ensures that listeners always receive state updates
  /// from the correct, currently relevant Wouter scope.
  Stream<WouterState> get wouter =>
      _wouterSubject.stream.switchMap((streamable) => streamable.stream);

  /// Called when a dependency of this [State] object changes.
  ///
  /// This method is used to detect if the [WouterStateStreamable] instance
  /// available in the [BuildContext] (via `context.watch`) has changed.
  /// If it has, the `_wouterSubject` is updated with the new instance,
  /// causing the `wouter` stream to switch to the new source.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Watch for changes in the WouterStateStreamable provided by an ancestor.
    final currentStreamable = context.watch<WouterStateStreamable>();

    // If the instance has changed, update our subject.
    if (currentStreamable != _wouterSubject.value) {
      _wouterSubject.add(currentStreamable);
    }
  }

  /// Called when this [State] object is removed from the tree permanently.
  ///
  /// It closes the `_wouterSubject` to release its resources and prevent
  /// memory leaks.
  @override
  void dispose() {
    _wouterSubject.close();

    super.dispose();
  }
}
