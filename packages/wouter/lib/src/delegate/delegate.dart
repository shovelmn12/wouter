import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

export 'functions.dart';

class WouterRouterDelegate extends RouterDelegate<String> with ChangeNotifier {
  final BehaviorSubject<WouterState> _stateSubject;

  final WidgetBuilder builder;

  late final WouterActions _actions = _createActions(() => _state);

  WouterState get _state => _stateSubject.value;

  @override
  String get currentConfiguration => _state.fullPath;

  WouterRouterDelegate({
    PathMatcherBuilder? matcher,
    RoutingPolicy policy = const URLRoutingPolicy(),
    String base = '',
    required this.builder,
  }) : _stateSubject = BehaviorSubject.seeded(WouterState(
          matcher: matcher?.call() ?? PathMatchers.regexp(),
          policy: policy,
          base: '',
          stack: const [],
        )) {
    _stateSubject
        .map((state) => state.fullPath)
        .distinct()
        .listen((path) => notifyListeners());
  }

  @override
  void dispose() {
    _stateSubject.close();

    super.dispose();
  }

  @override
  Future<bool> popRoute() => SynchronousFuture(_actions.pop());

  @override
  Future<void> setNewRoutePath(String configuration) => SynchronousFuture(
      _actions.reset(configuration.isEmpty ? "/" : configuration));

  @override
  Widget build(BuildContext context) => StreamProvider<WouterState>.value(
        value: _stateSubject,
        initialData: _state,
        child: Provider<WouterActions>.value(
          value: _actions,
          child: Navigator(
            onPopPage: (route, result) => false,
            pages: [
              MaterialPage(
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Builder(
                    builder: builder,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  /// Push a [path].
  ///
  /// Returns a Future that completes to the result value passed to pop when the pushed route is popped off the navigator.
  ///
  ///The T type argument is the type of the return value of the route.
  (WouterState, Future<R?>) _push<R>(WouterState state, String path) {
    final completer = Completer<R?>();

    return (
      state.copyWith(
        stack: state.policy.onPush(
          state.policy.pushPath(
            state.fullPath,
            state.policy.buildPath(state.base, path),
          ),
          state.stack,
          state.policy.buildOnResultCallback(completer),
        ),
      ),
      completer.future,
    );
  }

  /// Pop the history stack.
  /// Returns [canPop] before popping.
  (WouterState, bool) _pop(WouterState state, [dynamic result]) {
    if (state.canPop) {
      return (
        state.copyWith(
          stack: state.policy.onPop(state.stack, result),
        ),
        true,
      );
    }

    return (state, false);
  }

  /// Resets the state as if only [path] been pushed.
  (WouterState, void) _reset(WouterState state, [String path = "/"]) {
    state.stack.forEach((route) => route.onResult?.call(null));

    return (
      state.copyWith(
        stack: List.unmodifiable(state.policy.onReset(
          state.policy.pushPath(
            state.fullPath,
            state.policy.buildPath(state.base, path),
          ),
        )),
      ),
      null,
    );
  }

  (WouterState, Future<T>) _replace<T>(WouterState state, String path,
      [dynamic result]) {
    final completer = Completer<T>();

    return (
      state.copyWith(
        stack: state.policy.onPush(
          state.policy.pushPath(
            state.path,
            state.policy.buildPath(state.base, path),
          ),
          state.policy.onPop(state.stack, result),
          state.policy.buildOnResultCallback(completer),
        ),
      ),
      completer.future
    );
  }

  (WouterState, void) _update(
    WouterState state,
    WouterStateUpdateCallback update,
  ) =>
      (
        state.copyWith(
          stack: update(state.stack),
        ),
        null,
      );

  T _action<T>(ValueGetter<(WouterState, T)> action) {
    final (next, result) = action();

    _stateSubject.add(next);

    return result;
  }

  WouterActions _createActions(ValueGetter<WouterState> getter) => (
        push: <T>(path) => _action(() => _push<T>(
              getter(),
              path,
            )),
        pop: ([result]) => _action(() => _pop(
              getter(),
              result,
            )),
        reset: ([path = "/"]) => _action(() => _reset(
              getter(),
              path,
            )),
        replace: <T>(path, [result]) => _action(() => _replace<T>(
              getter(),
              path,
            )),
        update: (update) => _action(() => _update(
              getter(),
              update,
            )),
      );
}
