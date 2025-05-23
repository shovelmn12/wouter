import 'package:flutter/material.dart';
import 'package:wouter/wouter.dart';

/// A widget that displays one of a set of child widgets based on the
/// current Wouter navigation path.
///
/// `WouterSwitch` acts like a traditional "switch" statement for routes:
/// it iterates through its defined `routes` and renders the widget corresponding
/// to the first path pattern that matches the current Wouter path segment
/// relevant to this `WouterSwitch` instance.
///
/// It uses a [WouterNavigator] internally to handle the route matching and
/// to provide a scoped [WouterStateStreamable] to the matched child widget.
/// This allows the matched child widget to further participate in routing
/// (e.g., by containing another `WouterSwitch` or `WouterNavigator` for
/// nested routes).
///
/// If no route matches the current path and a [fallback] widget is provided,
/// the [fallback] widget is displayed. Otherwise, if no route matches and no
/// fallback is provided, it renders an empty container (or a container with
/// the specified [background] color).
class WouterSwitch extends StatelessWidget {
  /// A map defining the routes this switch can handle.
  /// Keys are route path patterns (e.g., "/profile", "/settings/*").
  /// Values are [WouterWidgetBuilder] functions that build the widget for
  /// the matched route. The `WouterSwitch` will render the widget for the
  /// first pattern that matches the current Wouter path.
  final WouterRoutes routes;

  /// An optional background color for the container that wraps the matched
  /// child widget or the fallback widget.
  /// If `null`, it defaults to `Theme.of(context).scaffoldBackgroundColor`.
  final Color? background;

  /// An optional widget to display if none of the defined `routes` match
  /// the current Wouter path.
  final Widget? fallback;

  /// An optional builder function to wrap the matched route's widget before
  /// it's displayed.
  /// Defaults to [WouterNavigator.defaultEntryBuilder], which typically wraps
  /// the route widget in a [RepaintBoundary].
  final WouterEntryBuilder entryBuilder;

  /// Creates a [WouterSwitch].
  ///
  /// - [key]: An optional key for the widget.
  /// - [routes]: Required. The map of route patterns to widget builders.
  /// - [background]: Optional background color.
  /// - [fallback]: Optional widget to display when no route matches.
  /// - [entryBuilder]: Optional builder to wrap the matched route's widget.
  const WouterSwitch({
    super.key,
    required this.routes,
    this.background,
    this.fallback,
    this.entryBuilder = WouterNavigator.defaultEntryBuilder,
  });

  /// Internal builder function passed to the underlying [WouterNavigator].
  ///
  /// It receives a `stack` of widgets from the [WouterNavigator]. For
  /// `WouterSwitch` behavior (where routes are typically exclusive and matched
  /// fully), this `stack` will usually contain zero or one widget.
  ///
  /// - If `stack` is empty and [fallback] is provided, it renders the [fallback].
  /// - Otherwise, it renders the `stack` (expected to be the single matched widget)
  ///   within a [Container] having the specified [background] color.
  ///   A [Stack] widget is used as the immediate child to display the content,
  ///   though for switch-like behavior, it typically holds only one visible item.
  Widget _builder(
    BuildContext context,
    List<Widget>
        stack, // Widgets from WouterNavigator, expected to be 0 or 1 for Switch
  ) {
    if (stack.isEmpty && fallback != null) {
      return fallback!;
    }

    // The WouterNavigator is expected to provide at most one widget in the 'stack'
    // for a WouterSwitch if route patterns are exclusive.
    return Container(
      color: background ?? Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        // Using Stack to display the single matched widget or an empty space.
        // Alignment.center is a default, might not be visually relevant if only one child.
        alignment: Alignment.center,
        children:
            stack, // Contains the matched widget (if any) from WouterNavigator
      ),
    );
  }

  /// Builds the [WouterSwitch] by configuring and returning a [WouterNavigator].
  ///
  /// The [WouterNavigator] is provided with this switch's `routes`, the
  /// internal `_builder` function for rendering, and the `entryBuilder`.
  @override
  Widget build(BuildContext context) => WouterNavigator(
        routes: routes,
        builder: _builder, // Uses the custom builder defined above
        entryBuilder: entryBuilder,
      );
}
