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

part 'delegate.streamable.dart';

class WouterRouterDelegate extends RouterDelegate<String> with ChangeNotifier {
  final _WouterStateStreamableImpl _streamable;

  BehaviorSubject<WouterState> get _stateSubject => _streamable._subject;

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
  }) : _streamable = _WouterStateStreamableImpl(
          base: base,
          initial: initial,
        ) {
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
          updateShouldNotify: (prev, next) => false,
          child: Provider<WouterStateStreamable>.value(
            value: _streamable,
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
        ),
      );
}
