import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wouter/wouter.dart';

/// A widget that establishes a nested Wouter routing scope with a specific
/// base path.
///
/// The `Wouter` widget is a fundamental building block for creating hierarchical
/// or nested routing structures. It takes a [base] path and makes a new,
/// scoped [WouterStateStreamable] available to its [child] widget tree via [Provider].
///
/// This scoped [WouterStateStreamable] will:
/// 1.  Have its `base` path be the concatenation of the parent's base path
///     and the [base] path provided to this `Wouter` widget.
/// 2.  Have its `stack` (list of [RouteEntry]s) filtered and transformed to
///     only include routes relevant to this new, more specific base path.
///     Paths within this scoped stack will be relative to the new base.
///
/// This allows widgets within the [child] tree (like [WouterSwitch],
/// [WouterNavigator], or another `Wouter` widget) to operate with paths
/// relative to this `Wouter` widget's [base], simplifying route definitions
/// and logic in nested scenarios.
///
/// It requires a parent Wouter setup (e.g., from [WouterRouterDelegate] or
/// another `Wouter` widget) to provide the initial [WouterStateStreamable].
class Wouter extends StatefulWidget {
  /// The base path segment for this nested routing scope.
  /// This path will be appended to the parent's base path to form the
  /// full base path for the scope created by this widget.
  /// Defaults to an empty string, meaning it creates a scope that might
  /// not change the base path but could still be used for logical grouping
  /// or providing a fresh `WouterStateStreamable.child` instance.
  ///
  /// Example: If parent base is `/app` and this `Wouter` has `base: '/settings'`,
  /// the new scope's base will be `/app/settings`.
  final String base;

  /// The child widget that will be part of this nested routing scope.
  /// Widgets within this child tree can access the scoped [WouterStateStreamable]
  /// (e.g., via `context.wouter`).
  final Widget child;

  /// Creates a [Wouter] widget.
  ///
  /// - [key]: An optional key for the widget.
  /// - [base]: The base path for this nested scope. Defaults to `''`.
  /// - [child]: Required. The widget tree under this scope.
  const Wouter({
    super.key,
    this.base = '',
    required this.child,
  });

  @override
  State<Wouter> createState() => _WouterState();
}

class _WouterState extends State<Wouter> with WouterParentMixin {
  /// Builds the widget tree.
  ///
  /// It uses a [Provider] to make a new `WouterStateStreamable.child` instance
  /// available to its descendants. This child streamable is configured with
  /// the `widget.base` path and derives its source state from the parent
  /// Wouter context (accessed via the `wouter` getter from `WouterParentMixin`).
  ///
  /// A [ValueKey] incorporating `widget.base` is used for the [Provider]. This
  /// can help Flutter correctly update or replace the provider if the `base`
  /// path changes, ensuring the correct scoped streamable is provided.
  @override
  Widget build(BuildContext context) => Provider<WouterStateStreamable>(
        // Keying the provider with the base path helps ensure it's correctly
        // managed if the Wouter widget is rebuilt with a different base.
        key: ValueKey("wouter-base-${widget.base}"),
        create: (context) => WouterStateStreamable.child(
          base: widget.base,
          source:
              wouter, // `wouter` stream from WouterParentMixin (parent's WouterStateStreamable.stream)
          state: context.wouter
              .state, // Initial state from parent's WouterStateStreamable
        ),
        dispose: (context, streamable) => streamable.dispose(),
        child: widget.child,
      );
}
