import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

import '../../models/models.dart';
import 'routing_policy.dart';

class URLRoutingPolicy<T extends WouterDelegateState>
    implements RoutingPolicy<T> {
  final String initial;

  const URLRoutingPolicy({
    this.initial = '/',
  });

  @override
  T onReset(String base, String path) {
    if (path == initial) {
      return onPush(
        path,
        WouterDelegateState(
          base: base,
        ) as T,
      );
    }

    final prevPath = popPath(path);
    final prevState = onReset(base, prevPath);

    return onPush(path, prevState);
  }

  @override
  String pushPath(String next) {
    if (next == initial || next.isEmpty) {
      return initial;
    } else if (next.endsWith('/')) {
      return next.substring(0, next.length - 1);
    }

    return next;
  }

  @override
  T onPush<R>(String path, T state, [ValueSetter<R>? onResult]) {
    final nextPath = pushPath(path);
    final nextStack = List<RouteHistory>.of(state.stack);

    nextStack.add(RouteHistory<R>(
      path: nextPath,
      stack: [
        if (nextStack.isNotEmpty) ...nextStack.last.stack,
        nextPath,
      ],
      onResult: onResult,
    ));

    return state.copyWith.call(
      path: nextPath,
      stack: List<RouteHistory>.unmodifiable(nextStack),
    ) as T;
  }

  @override
  String popPath(String path) {
    final parts = path.split('/');
    final newPath = parts.sublist(0, parts.length - 1).join('/');

    if (newPath.isEmpty) {
      return initial;
    }

    return newPath;
  }

  @override
  T onPop(T state, [dynamic? result]) {
    final nextStack = List<RouteHistory>.of(state.stack);
    final route = nextStack.removeLast();

    route.onResult?.call(result);

    return state.copyWith.call(
      path: nextStack.last.path,
      stack: List<RouteHistory>.unmodifiable(nextStack),
    ) as T;
  }

  @override
  bool isCurrentPath(T state, String path) =>
      state.fullPath == path && state.path.isNotEmpty;

  @override
  String constructPath(String base, String current, String path) {
    if (path.isEmpty) {
      return '$base/$current';
    } else if (path.startsWith('/')) {
      return path;
    } else if (path.startsWith('.')) {
      return normalize('$base$current/$path');
    } else {
      return normalize('$base/$path');
    }
  }
}
