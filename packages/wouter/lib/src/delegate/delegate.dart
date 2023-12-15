import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

export 'functions.dart';

part 'delegate.actions_scope.dart';

class WouterRouterDelegate extends RouterDelegate<String> with ChangeNotifier {
  final BehaviorSubject<WouterState> _stateSubject;
  final BehaviorSubject<WouterActionsCallbacks> _actionsCallbacksSubject =
      BehaviorSubject.seeded((
    push: [],
    pop: [],
  ));

  final WidgetBuilder builder;

  late final WouterActions _actions = _createActions(
    () => _state,
    () => _callbacks,
  );

  WouterState get _state => _stateSubject.value;

  WouterActionsCallbacks get _callbacks => _actionsCallbacksSubject.value;

  @override
  String get currentConfiguration => _state.fullPath;

  WouterRouterDelegate({
    PathMatcherBuilder? matcher,
    RoutingPolicy policy = const URLRoutingPolicy(),
    String base = '',
    String initial = '/',
    required this.builder,
  }) : _stateSubject = BehaviorSubject.seeded(WouterState(
          matcher: matcher?.call() ?? PathMatchers.regexp(),
          policy: policy,
          base: '',
          stack: [
            if (initial.isNotEmpty)
              RouteEntry(
                path: initial,
              ),
          ],
        )) {
    _stateSubject
        .map((state) => state.fullPath)
        .distinct()
        .listen((path) => notifyListeners());
  }

  @override
  void dispose() {
    _stateSubject.close();
    _actionsCallbacksSubject.close();

    super.dispose();
  }

  @override
  Future<bool> popRoute() => SynchronousFuture(_actions.pop());

  @override
  Future<void> setNewRoutePath(String configuration) =>
      SynchronousFuture(_action(
        () => _reset(
          _state,
          <T>(state, path) => _push<T>(state, (path) => true, path),
          (state, [result]) => _pop(state, (state, [result]) => true, result),
          configuration.isEmpty ? "/" : configuration,
        ),
      ));

  @override
  Widget build(BuildContext context) => _WouterActionsScope(
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
        child: StreamProvider<WouterState>.value(
          value: _stateSubject,
          initialData: _state,
          updateShouldNotify: (prev, next) =>
              prev.fullPath != next.fullPath ||
              !const DeepCollectionEquality().equals(
                  prev.stack.map((e) => e.path),
                  next.stack.map(
                    (e) => e.path,
                  )),
          child: Provider<WouterActions>.value(
            key: ValueKey(hashCode),
            value: _actions,
            child: Navigator(
              onPopPage: (route, result) =>
                  route.didPop(result) || _actions.pop(result),
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
        ),
      );

  /// Push a [path].
  ///
  /// Returns a Future that completes to the result value passed to pop when the pushed route is popped off the navigator.
  ///
  ///The T type argument is the type of the return value of the route.
  (WouterState, Future<R?>) _push<R>(
    WouterState state,
    bool Function(String) predicate,
    String path,
  ) {
    if (!predicate(path)) {
      return (state, Future.value());
    }

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
  (WouterState, bool) _pop(
    WouterState state,
    bool Function(String, [dynamic]) predicate, [
    dynamic result,
  ]) {
    if (!predicate(state.fullPath, result)) {
      return (state, true);
    }

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
  (WouterState, void) _reset(
    WouterState state,
    (WouterState, Future<T?>) Function<T>(WouterState, String) push,
    (WouterState, bool) Function(WouterState, [dynamic]) pop, [
    String path = "/",
  ]) {
    if (state.canPop) {
      final (prev, popped) = pop(state);

      if (popped) {
        return _reset(prev, push, pop, path);
      }

      return (state, null);
    }

    return (
      state.policy.createStack(path).fold(
            state,
            (state, path) => push(state, path).$1,
          ),
      null,
    );
  }

  (WouterState, Future<T?>) _replace<T>(
    WouterState state,
    (WouterState, Future<T?>) Function<T>(WouterState, String) push,
    (WouterState, bool) Function(WouterState, [dynamic]) pop,
    String path, [
    dynamic result,
  ]) {
    final (prev, popped) = pop(state, result);

    if (popped) {
      return push<T>(prev, path);
    }

    return (state, Future<T>.value());
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

  WouterActions _createActions(
    ValueGetter<WouterState> getter,
    ValueGetter<WouterActionsCallbacks> getCallbacks,
  ) {
    push<T>(WouterState state, String path) => _push<T>(
          state,
          (path) => getCallbacks()
              .push
              .fold(true, (acc, callback) => acc && callback(path)),
          path,
        );
    pop(WouterState state, [dynamic result]) => _pop(
          state,
          (path, [result]) => getCallbacks()
              .pop
              .fold(true, (acc, callback) => acc && callback(path, result)),
          result,
        );

    return (
      push: <T>(path) => _action(() => push<T>(
            getter(),
            path,
          )),
      pop: ([result]) => _action(() => pop(
            getter(),
            result,
          )),
      reset: ([path = "/"]) => _action(() => _reset(
            getter(),
            push,
            pop,
            path,
          )),
      replace: <T>(path, [result]) => _action(() => _replace<T>(
            getter(),
            push,
            pop,
            path,
          )),
      update: (update) => _action(() => _update(
            getter(),
            update,
          )),
    );
  }
}
