import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

export 'stack_policy.dart';
export 'streamable.dart';

part 'delegate.actions.dart';
part 'delegate.actions_scope.dart';

/// The core [RouterDelegate] for the Wouter routing system.
///
/// This delegate interfaces with Flutter's `Router` widget to manage the
/// navigation state based on Wouter's internal logic. It handles:
/// - Reporting the current route configuration ([currentConfiguration]).
/// - Responding to new route paths set by the platform ([setNewRoutePath]).
/// - Handling system pop events ([popRoute]).
/// - Building the widget tree that displays the current route.
///
/// It utilizes [BehaviorSubject] to manage and stream the [WouterState] and
/// [WouterActionsCallbacks], allowing various parts of the application to react
/// to navigation changes and register action interceptors.
///
/// Navigation actions (push, pop, replace, reset) are exposed via a
/// [WouterAction] function, which is made available to the widget tree
/// through a [Provider]. Similarly, the current [WouterStateStreamable]
/// (providing access to the current state and its stream) and a [PathMatcher]
/// are also provided.
class WouterRouterDelegate extends RouterDelegate<String> with ChangeNotifier {
  /// Subject that holds and broadcasts the current [WouterState].
  final BehaviorSubject<WouterState> _stateSubject;

  /// Subject that holds and broadcasts the registered [WouterActionsCallbacks]
  /// for push and pop operations.
  final BehaviorSubject<WouterActionsCallbacks> _actionsCallbacksSubject =
      BehaviorSubject.seeded((
    push: [], // Initial empty list of push callbacks
    pop: [], // Initial empty list of pop callbacks
  ));

  /// The main widget builder function provided by the user to build the
  /// application's UI based on the current Wouter state.
  final WidgetBuilder builder;

  /// A streamable wrapper around the Wouter state, providing both synchronous
  /// access to the current state and a stream of state changes.
  late final WouterStateStreamable _streamable = WouterStateStreamable(
    source: _stateSubject.stream,
    state: _stateSubject.value,
  );

  /// The central function for dispatching Wouter navigation actions.
  /// This is created by `_createActions` (defined in 'delegate.actions.dart').
  late final WouterAction _actions = _createActions(
    const StackPolicy(), // Default stack manipulation policy
    () => _state, // Getter for the current WouterState
    _stateSubject.add, // Function to update the WouterState
    () => _callbacks, // Getter for the current action callbacks
  );

  /// Gets the current [WouterState].
  WouterState get _state => _streamable.state;

  /// Gets the current registered [WouterActionsCallbacks].
  WouterActionsCallbacks get _callbacks => _actionsCallbacksSubject.value;

  /// Provides the current route configuration (full path) to Flutter's Router.
  /// This is used for tasks like saving and restoring the navigation state.
  @override
  String get currentConfiguration => _state.fullPath;

  /// Creates a [WouterRouterDelegate].
  ///
  /// - [matcher]: An optional [PathMatcherBuilder] to customize how route
  ///   patterns are matched against paths. If `null`, a default matcher is used.
  /// - [base]: An optional base path for all routes managed by this delegate.
  ///   Defaults to an empty string (`''`).
  /// - [initial]: The initial path to display when the app starts.
  ///   Defaults to `'/'`.
  /// - [builder]: Required. A [WidgetBuilder] function that builds the UI.
  ///   It typically uses routing widgets like [Wouter] or [Switch] to display
  ///   content based on the current route.
  WouterRouterDelegate({
    PathMatcherBuilder?
        matcher, // Note: matcher is not directly used in this snippet, but might be by _createActions or PathMatchers
    String base = '',
    String initial = '/',
    required this.builder,
  }) : _stateSubject = BehaviorSubject.seeded(WouterState(
          base: base,
          canPop:
              false, // Initially, we assume we can't pop further from the root
          stack: [
            if (initial.isNotEmpty) // Add initial route to the stack
              RouteEntry(
                path: initial,
                onResult: (_) {}, // Placeholder for result callback
              ),
          ],
        )) {
    // Listen to distinct full path changes in the WouterState
    // and notify Flutter's Router that the configuration has changed.
    _streamable.stream
        .map((state) => state.fullPath)
        .distinct()
        .listen((path) => notifyListeners());
  }

  /// Cleans up resources when the delegate is disposed.
  /// Closes the [_streamable] (which in turn closes `_stateSubject` if it owns it)
  /// and `_actionsCallbacksSubject`.
  @override
  void dispose() {
    _streamable
        .dispose(); // Disposes the WouterStateStreamable and underlying state subject
    _actionsCallbacksSubject.close(); // Closes the actions callbacks subject

    super.dispose();
  }

  /// Handles system pop events (e.g., Android back button).
  ///
  /// Delegates the pop action to Wouter's internal `_actions.pop()` method.
  /// Returns a [Future<bool>] indicating whether the pop was handled
  /// (i.e., if a route was successfully popped).
  @override
  Future<bool> popRoute() => SynchronousFuture(_actions.pop());

  /// Called by Flutter's Router when the platform reports a new route path
  /// (e.g., from a deep link or browser URL change).
  ///
  /// If the [configuration] (new path) is different from the current path,
  /// it resets Wouter's navigation stack to this new path.
  /// The root path `'/'` is always included.
  @override
  Future<void> setNewRoutePath(String configuration) {
    if (configuration != _state.fullPath) {
      // Reset the navigation stack to the new configuration.
      // Ensures the root path "/" is always present.
      _actions.reset([
        "/",
        if (configuration.isNotEmpty && configuration != "/") configuration,
      ]);
    }

    return SynchronousFuture(null); // Parsing is synchronous
  }

  /// Builds the widget tree for the current navigation state.
  ///
  /// It sets up [Provider]s for [WouterStateStreamable], [PathMatcher],
  /// and [WouterAction] so they can be accessed by Wouter widgets
  /// deeper in the tree (e.g., [Wouter], [Switch], [Route], [Link]).
  ///
  /// An `_WouterActionsScope` is used to allow descendant widgets to register
  /// or unregister push/pop interceptor callbacks.
  ///
  /// A [Navigator] is used to manage the pages, though in this basic setup,
  /// it primarily serves to host the `MaterialPage` containing the user's UI.
  /// The `PopScope` with `canPop: false` ensures that `popRoute` is called,
  /// allowing Wouter to manage its own stack.
  @override
  Widget build(BuildContext context) => _WouterActionsScope(
        // Callbacks to add/remove push/pop interceptors to/from _actionsCallbacksSubject
        addPop: (pop) => _actionsCallbacksSubject.add((
          pop: [
            ..._callbacks.pop,
            pop,
          ],
          push: _callbacks.push,
        )),
        removePop: (pop) => _actionsCallbacksSubject.add((
          pop: _callbacks.pop.where((cb) => cb != pop).toList(),
          push: _callbacks.push,
        )),
        addPush: (push) => _actionsCallbacksSubject.add((
          pop: _callbacks.pop,
          push: [
            ..._callbacks.push,
            push,
          ],
        )),
        removePush: (push) => _actionsCallbacksSubject.add((
          pop: _callbacks.pop,
          push: _callbacks.push.where((cb) => cb != push).toList(),
        )),
        child: Provider<WouterStateStreamable>.value(
          value: _streamable,
          child: Provider<PathMatcher>.value(
            // Provides a default cached RegExp-based path matcher.
            // updateShouldNotify is false as the matcher instance itself doesn't change.
            value: PathMatchers.cachedRegexp(),
            updateShouldNotify: (prev, next) => false,
            child: Provider<WouterAction>.value(
              // Keyed to ensure it's correctly updated if the delegate itself is replaced.
              key: ValueKey(hashCode),
              value: _actions,
              child: Navigator(
                // onDidRemovePage is a no-op as Wouter manages its stack internally.
                onDidRemovePage: (page) {},
                pages: [
                  MaterialPage(
                    child: PopScope(
                      // Prevents immediate pop, deferring to `popRoute()`
                      canPop: false,
                      child: Container(
                        // Provides a default background color matching scaffold.
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Builder(
                          // Invokes the user-provided builder function.
                          builder: builder,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
