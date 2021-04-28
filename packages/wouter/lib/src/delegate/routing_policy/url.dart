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

  String _normalize(String base, String current, String path) {
    if (path.startsWith(".")) {
      return normalize("$current/$path");
    } else if (path.startsWith("/")) {
      return path;
    } else {
      return "$base/$path";
    }
  }

  @override
  String pushPath(String base, String current, String next) {
    if (next == initial || next.isEmpty) {
      return initial;
    }

    final path = _removeBaseFromPath(
      base,
      _normalize(base, current, next),
    );

    if (path.endsWith('/')) {
      return path.substring(0, path.length - 1);
    }

    return path;
  }

  @override
  T onPush<R>(String path, T state, [ValueSetter<R>? onResult]) {
    final nextStack = List<RouteHistory>.of(state.stack);

    nextStack.add(RouteHistory<R>(
      path: path,
      stack: [
        if (nextStack.isNotEmpty) ...nextStack.last.stack,
        path,
      ],
      onResult: onResult,
    ));

    return state.copyWith.call(
      path: path,
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
}
