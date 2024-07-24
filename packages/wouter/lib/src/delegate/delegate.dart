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

class WouterRouterDelegate extends RouterDelegate<String> with ChangeNotifier {
  late final WouterStateStreamable _streamable;

  final BehaviorSubject<WouterState> _stateSubject = BehaviorSubject();

  final BehaviorSubject<WouterActionsCallbacks> _actionsCallbacksSubject =
      BehaviorSubject.seeded((
    push: [],
    pop: [],
  ));

  final WidgetBuilder builder;

  late final WouterAction _actions = _createActions(
    const StackPolicy(),
    () => _state,
    _stateSubject.add,
    () => _callbacks,
  );

  WouterState get _state => _streamable.state;

  WouterActionsCallbacks get _callbacks => _actionsCallbacksSubject.value;

  @override
  String get currentConfiguration => _state.fullPath;

  WouterRouterDelegate({
    PathMatcherBuilder? matcher,
    String base = '',
    String initial = '/',
    required this.builder,
  }) {
    _streamable = WouterStateStreamable.root(
      base: base,
      source: _stateSubject.stream,
      initial: initial,
    );
    _streamable.stream
        .map((state) => state.fullPath)
        .distinct()
        .listen((path) => notifyListeners());
  }

  @override
  void dispose() {
    _streamable.dispose();
    _actionsCallbacksSubject.close();

    super.dispose();
  }

  @override
  Future<bool> popRoute() => SynchronousFuture(_actions.pop());

  @override
  Future<void> setNewRoutePath(String configuration) {
    if (configuration != _state.fullPath) {
      _actions.reset([
        "/",
        if (configuration.isNotEmpty && configuration != "/") configuration,
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
        child: Provider<WouterStateStreamable>.value(
          value: _streamable,
          child: Provider<PathMatcher>.value(
            value: PathMatchers.cachedRegexp(),
            updateShouldNotify: (prev, next) => false,
            child: Provider<WouterAction>.value(
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
}
