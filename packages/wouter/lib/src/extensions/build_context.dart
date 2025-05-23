import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wouter/wouter.dart';

/// Provides convenient extension methods on [BuildContext] for accessing
/// Wouter's core functionalities like state, streams, and actions.
///
/// This extension makes it easier to interact with the Wouter routing system
/// from within widgets without needing to explicitly use `Provider.of<T>(context)`.
extension WouterBuildContextExtensions on BuildContext {
  /// Accessor for Wouter functionalities through a [WouterSelector].
  ///
  /// Example:
  /// ```dart
  /// // Get current Wouter state
  /// final currentState = context.wouter.state;
  ///
  /// // Listen to Wouter state changes
  /// context.wouter.stream.listen((newState) {
  ///   // Handle state change
  /// });
  ///
  /// // Perform a navigation action
  /// context.wouter.actions.push('/new-route');
  /// ```
  ///
  /// This relies on [WouterStateStreamable] and [WouterAction] being available
  /// in the widget tree via [Provider]. If they are not provided higher up
  /// in the tree, using this getter will result in a [ProviderNotFoundException].
  WouterSelector get wouter => WouterSelector._(this);
}

/// A selector class that provides convenient access to Wouter's core components
/// like [WouterStateStreamable], the current [WouterState], the [Stream] of
/// state changes, and [WouterAction]s.
///
/// Instances of this class are typically obtained via the `context.wouter`
/// extension getter.
class WouterSelector {
  /// The [BuildContext] used to access Wouter components from the widget tree.
  final BuildContext _context;

  /// Private constructor to create a [WouterSelector].
  /// Used by the `WouterBuildContextExtensions.wouter` getter.
  const WouterSelector._(this._context);

  /// Retrieves the [WouterStateStreamable] instance from the [BuildContext]
  /// using `Provider.of<WouterStateStreamable>(context, listen: false)`
  /// (internally via `context.read`).
  ///
  /// Throws a [ProviderNotFoundException] if [WouterStateStreamable] is not
  /// found in the widget tree.
  WouterStateStreamable get _streamable =>
      _context.read<WouterStateStreamable>();

  /// Provides a [Stream] of [WouterState] changes.
  ///
  /// This allows widgets to reactively rebuild or perform actions when the
  /// Wouter navigation state changes.
  ///
  /// Equivalent to `context.read<WouterStateStreamable>().stream`.
  Stream<WouterState> get stream => _streamable.stream;

  /// Gets the current [WouterState] synchronously.
  ///
  /// This provides immediate access to the router's current path, stack,
  /// base path, etc.
  ///
  /// Equivalent to `context.read<WouterStateStreamable>().state`.
  WouterState get state => _streamable.state;

  /// Retrieves the [WouterAction] dispatcher function from the [BuildContext]
  /// using `Provider.of<WouterAction>(context, listen: false)`
  /// (internally via `context.read`).
  ///
  /// This function is used to perform navigation actions like push, pop,
  /// replace, etc.
  ///
  /// Example:
  /// ```dart
  /// context.wouter.actions.push('/details');
  /// context.wouter.actions.pop();
  /// ```
  ///
  /// Throws a [ProviderNotFoundException] if [WouterAction] is not
  /// found in the widget tree.
  WouterAction get actions => _context.read<WouterAction>();
}
