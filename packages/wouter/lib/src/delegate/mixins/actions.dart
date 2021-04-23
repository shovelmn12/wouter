import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../models/models.dart';
import '../delegate.dart';

mixin RoutingActions<T extends WouterDelegateState> on BaseRouterDelegate<T> {
  String? get tag;

  RoutingPolicy<T> get policy;

  WouterBaseRouterDelegate? get parent;

  void update(T? Function(T state) callback) {
    try {
      final nextState = callback(state);

      if (nextState == null) {
        return;
      }

      state = nextState;
    } catch (e, stack) {
      print(e);
      print(stack);

      rethrow;
    }
  }

  @protected
  void onParentPathUpdated(String path) {
    if (policy.isCurrentPath(state, path)) {
      return;
    }

    reset(path);
  }

  @override
  Future<R?> push<R>(String path) {
    try {
      final nextPath = policy.constructPath(state.base, state.path, path);

      if (parent == null) {
        final completer = Completer<R?>();

        state = policy.onPush(
          _removeBaseFromPath(state.base, nextPath),
          state,
          completer.complete,
        );

        return completer.future;
      } else {
        return parent!.push<R>(nextPath);
      }
    } catch (e, stack) {
      print(e);
      print(stack);

      rethrow;
    }
  }

  @override
  bool pop([dynamic? result]) {
    if (parent == null) {
      if (state.canPop) {
        state = policy.onPop(state, result);

        return true;
      }

      return false;
    } else {
      return parent!.pop(result);
    }
  }

  String _removeBaseFromPath(String base, String path) {
    if (base.isEmpty || !path.startsWith(base)) {
      return path;
    }

    final newPath = path.substring(base.length);

    if (newPath.isEmpty) {
      return '/';
    }

    return newPath;
  }

  @override
  void reset(String path) {
    state.stack.forEach((route) => route.onResult?.call(null));

    state = policy.onReset(state.base, _removeBaseFromPath(state.base, path));
  }
}
