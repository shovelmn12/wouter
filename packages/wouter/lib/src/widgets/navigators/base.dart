import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

/// A type alias for a map defining routes for a [WouterNavigator].
///
/// Keys are route path patterns (e.g., "/users/:id", "/settings/*"), and
/// values are [WouterWidgetBuilder] functions that build the widget for
/// the matched route, receiving context and extracted arguments.
typedef WouterRoutes = Map<String, WouterWidgetBuilder>;

/// A builder function responsible for constructing the UI that displays
/// the stack of active route widgets managed by a [WouterNavigator].
///
/// - [context]: The build context.
/// - `List<Widget>`: A list of widgets, where each widget represents an
///   active route in the navigator's current stack. The order typically
///   reflects the navigation hierarchy.
///
/// This allows for custom layouts of the navigation stack, such as using
/// Flutter's [Stack], [PageView], or custom transition widgets.
typedef WouterStackBuilder = Widget Function(BuildContext, List<Widget>);

/// A builder function that wraps each individual route's widget before it's
/// added to the list passed to [WouterStackBuilder].
///
/// - `WidgetBuilder`: A builder for the actual content widget of a specific route.
///
/// This can be used to apply common wrappers to all route widgets, such as
/// [RepaintBoundary], [KeyedSubtree], or route-specific providers.
/// See [WouterNavigator.defaultEntryBuilder].
typedef WouterEntryBuilder = Widget Function(WidgetBuilder);

/// Internal type: Represents a processed entry in the [WouterNavigator]'s
/// conceptual stack, derived from the parent Wouter's state.
///
/// - [key]: The route pattern string (from [WouterNavigator.routes]) that
///   this entry corresponds to.
/// - [state]: A [WouterState] scoped specifically for this entry, containing
///   the relevant segment of the parent's navigation stack and a base path
///   reflecting its position within the [WouterNavigator].
typedef _Entry = ({
  String key,
  WouterState state,
});

/// Internal type: Represents a successful match of a path segment against
/// one of the [WouterNavigator]'s defined routes.
///
/// - [key]: The route pattern string (from [WouterNavigator.routes]) that matched.
/// - [builder]: The [WidgetBuilder] (derived from [WouterWidgetBuilder] with
///   arguments applied) responsible for building the UI for this matched route.
typedef _EntryMatch = ({
  String key,
  WidgetBuilder builder,
});

/// A navigator widget that manages a stack of child routes based on the
/// Wouter navigation state from a parent Wouter context.
///
/// `WouterNavigator` enables hierarchical or nested routing within a Wouter
/// application. It listens to changes in the parent [WouterState] (typically
/// obtained via `context.wouter`) and, based on its own `routes` configuration,
/// builds a stack of widgets.
///
/// Key features:
/// - **Route Matching**: Uses a [PathMatcher] to match segments of the parent
///   Wouter stack against its local `routes`.
/// - **Scoped State**: For each active route it manages, `WouterNavigator`
///   provides a new, scoped [WouterStateStreamable] down the widget tree. This
///   allows child routes and subsequent nested `WouterNavigator`s to operate
///   on a relevant subsection of the overall navigation state.
/// - **Stack Building**: Utilizes a [WouterStackBuilder] to render the visual
///   representation of its active routes, allowing for flexible UI (e.g.,
///   Flutter's `Stack`, `PageView`, or custom animated transitions).
/// - **Entry Wrapping**: Uses a [WouterEntryBuilder] to wrap each route's widget,
///   enabling common functionalities like [RepaintBoundary] or route-specific setup.
/// - **Dynamic Updates**: Reacts to changes in both the parent Wouter state and
///   its own `routes` property.
///
/// It's designed to be placed within a widget tree where a parent Wouter setup
/// (e.g., [WouterRouterDelegate]) has already provided the necessary
/// [WouterStateStreamable] and [PathMatcher].
class WouterNavigator extends StatefulWidget {
  /// An optional [PathMatcher] to use for matching routes.
  /// If `null`, it attempts to read a [PathMatcher] from the [BuildContext]
  /// (e.g., one provided by a parent [WouterRouterDelegate] or another [WouterNavigator]).
  final PathMatcher? matcher;

  /// A map defining the routes this navigator can handle.
  /// Keys are route patterns, and values are [WouterWidgetBuilder] functions.
  final WouterRoutes routes;

  /// A required builder function that takes the current list of active route
  /// widgets and constructs the UI to display them.
  final WouterStackBuilder builder;

  /// An optional builder function to wrap each individual route's widget.
  /// Defaults to [WouterNavigator.defaultEntryBuilder], which wraps the route
  /// in a [RepaintBoundary].
  final WouterEntryBuilder entryBuilder;

  /// Creates a [WouterNavigator].
  ///
  /// - [key]: An optional key for the widget.
  /// - [matcher]: Optional custom path matcher.
  /// - [routes]: Required. The route definitions for this navigator.
  /// - [builder]: Required. The builder for the stack of route widgets.
  /// - [entryBuilder]: Optional. The builder to wrap individual route widgets.
  const WouterNavigator({
    super.key,
    this.matcher,
    required this.routes,
    required this.builder,
    this.entryBuilder = defaultEntryBuilder,
  });

  /// The default [WouterEntryBuilder] function.
  /// It wraps the provided [builder] (for a route's content) in a
  /// [RepaintBoundary] and a [Builder]. The [RepaintBoundary] can help
  /// optimize rendering by isolating repaints of individual routes.
  static Widget defaultEntryBuilder(WidgetBuilder builder) => RepaintBoundary(
        child: Builder(
          builder: builder,
        ),
      );

  @override
  State<WouterNavigator> createState() => WouterNavigatorState();
}

/// The state for [WouterNavigator].
///
/// This class manages the core logic of listening to parent Wouter state,
/// processing the route stack, and building the list of child route widgets.
class WouterNavigatorState extends State<WouterNavigator>
    with WouterParentMixin {
  // Assumes WouterParentMixin provides `Stream<WouterState> get wouter`
  /// A stream that processes the parent Wouter state and this navigator's routes
  /// to produce a list of `_Entry` objects. Each `_Entry` represents a
  /// segment of the parent stack matched by this navigator, along with a
  /// scoped [WouterState] for that segment.
  /// This stream is a hot, auto-connecting, and distinct stream.
  late final Stream<List<_Entry>> _base = Rx.combineLatest2(
    // Listen to distinct changes in the parent Wouter state's stack and base.
    wouter.distinct(
      (prev, next) =>
          const DeepCollectionEquality().equals(
            prev.stack.map((e) => e.path).toList(),
            next.stack.map((e) => e.path).toList(),
          ) &&
          prev.base != next.base,
    ),
    // Listen to distinct changes in this navigator's own route definitions.
    _routes.distinct(),
    // Combine parent state and local routes to create a list of `_Entry`s.
    (state, routes) => _createEntries(
      widget.matcher ?? context.read<PathMatcher>(),
      state,
      routes,
    ),
  )
      .distinct()
      .publishValue()
      .autoConnect(connection: (_) {}); // Added connection for autoConnect

  /// A stream that transforms the `_Entry` list from `_base` into a list of
  /// renderable `Widget`s. Each widget is constructed using `widget.entryBuilder`
  /// and includes a `Provider<WouterStateStreamable>` to scope the Wouter state
  /// for that specific route/layer.
  late final Stream<List<Widget>> _stream = _base
      // Only rebuild the widget list if the keys of the entries change.
      .distinct((prev, next) => const DeepCollectionEquality().equals(
            prev.map((e) => e.key),
            next.map((e) => e.key),
          ))
      .map((entries) => entries
          .mapIndexed((index, routeEntryMeta) => widget.entryBuilder(
                // routeEntryMeta is an _Entry
                (context) => Provider<WouterStateStreamable>(
                  // Unique key for the provider, ensuring proper state management.
                  key: ValueKey('${routeEntryMeta.key}-$index'),
                  create: (context) => WouterStateStreamable(
                    // Source stream for this scoped WouterStateStreamable.
                    // It filters `_base` to get updates relevant only to this specific entry.
                    source: _base
                        .where(
                            (currentEntries) => currentEntries.length > index)
                        .map((currentEntries) => currentEntries[index])
                        .map((entry) => entry
                            .state), // Extract the WouterState for this entry
                    state: routeEntryMeta.state, // Initial state for this scope
                  ),
                  dispose: (context, streamable) => streamable.dispose(),
                  // The actual content of the route.
                  child: Builder(
                    builder: (context) => StreamBuilder<_EntryMatch>(
                      // This inner StreamBuilder re-evaluates the specific widget to render
                      // for *this* route segment if the path *within its scope* changes.
                      stream: Rx.combineLatest2(
                        // Listen to the scoped Wouter state for path changes.
                        context.wouter
                            .stream // This context.wouter now reads the scoped WouterStateStreamable
                            .mapNotNull((state) => state.stack.lastOrNull)
                            .distinct(),
                        _routes, // Current routes of this WouterNavigator
                        // Match the current path within this scope against this navigator's routes.
                        (entry, routes) => _matchPathToRoute(
                          entry.path,
                          widget.matcher ?? context.read<PathMatcher>(),
                          routes,
                        )!,
                      ),
                      // Initial data for the StreamBuilder.
                      initialData: _matchPathToRoute(
                        context.wouter.state.stack.last
                            .path, // Uses scoped state here too
                        widget.matcher ?? context.read<PathMatcher>(),
                        _routes.value,
                      )!,
                      // Build the widget using the matched route's builder.
                      builder: (context, snapshot) =>
                          snapshot.requireData.builder(context),
                    ),
                  ),
                ),
              ))
          .toList());

  /// Subscription to the `_stream` to update `_stack`.
  late final StreamSubscription<List<Widget>> _subscription;

  /// BehaviorSubject holding the current list of widgets to be rendered by `widget.builder`.
  late final BehaviorSubject<List<Widget>> _stack = BehaviorSubject();

  /// BehaviorSubject holding the current list of route definitions for this navigator.
  late final BehaviorSubject<List<MapEntry<String, WouterWidgetBuilder>>>
      _routes = BehaviorSubject.seeded(
    List<MapEntry<String, WouterWidgetBuilder>>.unmodifiable(
      widget.routes.entries,
    ),
  );

  @override
  void initState() {
    super.initState();
    _subscription = _stream.listen(_stack.add);
  }

  @override
  void didUpdateWidget(covariant WouterNavigator oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the route patterns have changed, update the `_routes` subject.
    if (!const DeepCollectionEquality()
        .equals(oldWidget.routes.keys, widget.routes.keys)) {
      _routes.add(List<MapEntry<String, WouterWidgetBuilder>>.unmodifiable(
        widget.routes.entries,
      ));
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    _stack.close();
    _routes.close();
    // `_base` is a publish().autoConnect() stream, so its internal subject
    // might need explicit closing if not handled by RxDart automatically on
    // listener count drop to zero, or if `connection` parameter is used for manual control.
    // However, `publishValue().autoConnect()` usually handles this.
    super.dispose();
  }

  /// Processes the parent [WouterState]'s stack and this navigator's `routes`
  /// to create a list of `_Entry` objects.
  ///
  /// Each `_Entry` represents a matched segment of the parent stack, potentially
  /// grouping multiple parent [RouteEntry]s if they all fall under the same
  /// route pattern defined in this [WouterNavigator]. The `WouterState` within
  /// each `_Entry` is scoped to that segment.
  List<_Entry> _createEntries(
    PathMatcher matcher,
    WouterState parentState,
    List<MapEntry<String, WouterWidgetBuilder>> currentRoutes,
  ) =>
      parentState.stack.fold<List<_Entry>>(
        const <_Entry>[], // Initial list of entries for this navigator
        (navigatorEntries, parentRouteEntry) {
          final lastNavigatorEntry = navigatorEntries.lastOrNull;

          // Try to match the parent's route entry path against this navigator's routes.
          final matchResult = _matchPathToRoute(
            parentRouteEntry.path, // Path from parent's stack entry
            matcher,
            currentRoutes,
          );

          if (matchResult == null) {
            // If the parent's route entry doesn't match any of this navigator's routes,
            // ignore it for this navigator's stack.
            return navigatorEntries;
          }

          final (key: matchedRouteKey, builder: _) = matchResult;

          // Logic to group consecutive parent RouteEntrys under the same WouterNavigator route.
          if (lastNavigatorEntry != null &&
              lastNavigatorEntry.key == matchedRouteKey) {
            // The current parentRouteEntry matches the same navigator route key as the previous one.
            // Append it to the stack of the lastNavigatorEntry.
            return List<_Entry>.unmodifiable([
              if (navigatorEntries.length > 1)
                ...navigatorEntries.sublist(0, navigatorEntries.length - 1),
              (
                key: matchedRouteKey,
                state: WouterState(
                  // The stack for this navigator entry accumulates parent entries.
                  stack: List<RouteEntry>.unmodifiable([
                    ...lastNavigatorEntry.state.stack,
                    parentRouteEntry, // Add the current parent entry
                  ]),
                  canPop:
                      parentState.canPop, // Inherit canPop from parent state
                  base: parentState.base, // Inherit base from parent state
                ),
              ),
            ]);
          } else {
            // This parentRouteEntry starts a new segment for this navigator.
            return List<_Entry>.unmodifiable([
              ...navigatorEntries,
              (
                key: matchedRouteKey,
                state: WouterState(
                  // Start a new stack for this navigator entry.
                  stack: List<RouteEntry>.unmodifiable([parentRouteEntry]),
                  canPop: parentState.canPop,
                  base: parentState.base,
                ),
              )
            ]);
          }
        },
      );

  /// Matches a given `path` against the `routes` of this [WouterNavigator].
  ///
  /// - [path]: The path segment to match (typically from a parent [RouteEntry]).
  /// - [matcher]: The [PathMatcher] to use.
  /// - [routes]: The list of route definitions for this navigator.
  ///
  /// Returns an `_EntryMatch` if a match is found, otherwise `null`.
  /// An `_EntryMatch` contains the matched route pattern (`key`) and a
  /// `WidgetBuilder` for the route's content (with arguments applied).
  _EntryMatch? _matchPathToRoute(
    String path,
    PathMatcher matcher,
    List<MapEntry<String, WouterWidgetBuilder>> routes,
  ) {
    for (final routeDefinition in routes) {
      // routeDefinition is a MapEntry<String, WouterWidgetBuilder>
      final matchData = matcher(
        path,
        routeDefinition.key, // The route pattern
        prefix: false, // Requires an exact match for this segment/pattern
      );

      if (matchData != null) {
        // If a match is found, create the widget builder with extracted arguments.
        return (
          key: routeDefinition.key,
          builder: (context) =>
              routeDefinition.value(context, matchData.arguments),
        );
      }
    }
    // No match found in this navigator's routes.
    return null;
  }

  /// Builds the widget tree for this navigator.
  ///
  /// It provides its [PathMatcher] down the tree and uses a [StreamBuilder]
  /// to listen to the `_stack` (the list of processed route widgets).
  /// The `widget.builder` ([WouterStackBuilder]) is then used to render these widgets.
  @override
  Widget build(BuildContext context) => Provider<PathMatcher>(
        create: (context) => widget.matcher ?? context.read<PathMatcher>(),
        child: StreamBuilder<List<Widget>>(
          stream: _stack, // Stream of fully prepared route widgets
          initialData: const [],
          builder: (context, snapshot) => widget.builder(
            context,
            snapshot
                .requireData, // Pass the list of widgets to the stack builder
          ),
        ),
      );
}
