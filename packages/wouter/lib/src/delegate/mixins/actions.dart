import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../models/models.dart';
import '../delegate.dart';

mixin RoutingActions<T extends WouterDelegateState> on BaseRouterDelegate<T> {
  String? get tag;

  RoutingPolicy<T> get policy;

  WouterBaseRouterDelegate? get parent;

  bool get hasParent;

  void update(T? Function(T state) callback) {
    final nextState = callback(state);

    if (nextState == null) {
      return;
    }

    state = nextState;
  }

  @protected
  void onParentPathUpdated(String path) {
    if (policy.isCurrentPath(state, path)) {
      return;
    }

    state = policy.onPush(
      policy.removeBase(state.base, path),
      state.stack.isEmpty ? state : policy.onPop(state),
    );
  }

  @override
  Future<R?> push<R>(String path) {
    if (hasParent) {
      return parent!.push<R>(
        policy.pushPath(
          state.base,
          state.fullPath,
          path,
        ),
      );
    }

    final completer = Completer<R?>();

    state = policy.onPush(
      policy.removeBase(state.base, path),
      state,
      policy.buildSetter(completer),
    );

    print(state);

    return completer.future;
  }

  @override
  bool pop([dynamic? result]) {
    if (hasParent) {
      return parent!.pop(result);
    } else if (state.canPop) {
      state = policy.onPop(state, result);

      return true;
    }

    return false;
  }

  @override
  void reset(String path) {
    state.stack.forEach((route) => route.onResult?.call(null));

    if (hasParent) {
      return parent!.reset(path);
    }

    if (path == state.fullPath) {
      return;
    }

    state = policy.onReset(
      state.base,
      policy.pushPath(state.base, state.fullPath, path),
    );
  }
}
