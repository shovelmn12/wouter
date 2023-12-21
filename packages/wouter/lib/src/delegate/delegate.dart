import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

export 'stack_policy.dart';

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
    const StackPolicy(),
    () => _state,
    _stateSubject.add,
    () => _callbacks,
  );

  WouterState get _state => _stateSubject.value;

  WouterActionsCallbacks get _callbacks => _actionsCallbacksSubject.value;

  @override
  String get currentConfiguration => _state.fullPath;

  WouterRouterDelegate({
    PathMatcherBuilder? matcher,
    String base = '',
    String initial = '/',
    required this.builder,
  }) : _stateSubject = BehaviorSubject.seeded(WouterState(
          base: '',
          canPop: false,
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
  Future<void> setNewRoutePath(String configuration) {
    if (configuration != _state.fullPath) {
      _actions.reset([
        configuration.isEmpty ? "/" : configuration,
      ]);
    }

    return SynchronousFuture(null);
  }

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
                next.stack.map((e) => e.path),
              ),
          child: Provider<PathMatcher>.value(
            value: PathMatchers.regexp(),
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
        ),
      );

  WouterActions _createActions(
    StackPolicy policy,
    ValueGetter<WouterState> getter,
    ValueSetter<WouterState> setter,
    ValueGetter<WouterActionsCallbacks> getCallbacks,
  ) {
    push<R>(WouterState state, String path) {
      final predicate = (path) => getCallbacks()
          .push
          .fold(true, (acc, callback) => acc && callback(path));

      if (!predicate(path)) {
        return (state, Future<R>.value());
      }

      return policy.push<R>(
        state,
        path,
      );
    }

    pop(WouterState state, [dynamic result]) {
      final predicate = (path, [result]) => getCallbacks()
          .pop
          .fold(true, (acc, callback) => acc && callback(path, result));

      if (!predicate(state.path)) {
        return (state, true);
      }

      return policy.pop(
        state,
        result,
      );
    }

    return <R>(action) {
      final (next, result) = action(
        (
          push: push,
          pop: pop,
          pathBuilder: policy.pathBuilder,
        ),
        getter(),
      );

      setter(next);

      return result;
    };
  }
}
