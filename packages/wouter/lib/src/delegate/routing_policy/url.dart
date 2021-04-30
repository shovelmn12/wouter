import 'dart:async';

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
  String removeBase(String base, String path) {
    if (base.isEmpty || !path.startsWith(base)) {
      return path;
    }

    final newPath = path.substring(base.length);

    if (newPath.isEmpty) {
      return initial;
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
  String pushPath(String base, String current, String path) {
    if (path == initial || path.isEmpty) {
      return initial;
    }

    final nextPath = _normalize(base, current, path);

    if (nextPath.endsWith('/')) {
      return path.substring(0, nextPath.length - 1);
    }

    return nextPath;
  }

  @override
  T onPush<R>(String path, T state, [ValueSetter<R>? onResult]) {
    final nextStack = List<RouteHistory>.of(state.stack);

    nextStack.add(RouteHistory<R>(
      path: path,
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

    if (nextStack.isNotEmpty) {
      nextStack.removeLast().onResult?.call(result);
    }

    return state.copyWith.call(
      path: nextStack.isEmpty ? "" : nextStack.last.path,
      stack: List<RouteHistory>.unmodifiable(nextStack),
    ) as T;
  }

  @override
  bool isCurrentPath(T state, String path) =>
      state.fullPath == path && state.path.isNotEmpty;

  @override
  ValueSetter<R?> buildSetter<R>(Completer<R?> completer) => (R? value) {
      if (completer.isCompleted) {
        return;
      }

      completer.complete(value);
    };
}
