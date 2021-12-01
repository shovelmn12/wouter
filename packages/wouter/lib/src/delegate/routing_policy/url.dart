import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

import '../../models/models.dart';
import 'routing_policy.dart';

class URLRoutingPolicy<T extends RouteHistory>
    implements RoutingPolicy<List<T>> {
  final String initial;

  const URLRoutingPolicy({
    this.initial = '/',
  });

  // @override
  // String removeBase(String base, String path) {
  //   if (base.isEmpty || !path.startsWith(base)) {
  //     return path;
  //   }
  //
  //   final nextPath = path.substring(base.length);
  //
  //   if (nextPath.isEmpty) {
  //     return initial;
  //   }
  //
  //   return nextPath;
  // }

  String _normalize(String current, String path) {
    if (path.startsWith(".")) {
      return normalize("$current/$path");
    } else if (path.startsWith("/")) {
      return path;
    } else {
      return path;
    }
  }

  @override
  String pushPath(String current, String path) {
    if (path == initial || path.isEmpty) {
      return path;
    }

    final nextPath = _normalize(current, path);

    if (nextPath.isEmpty) {
      return initial;
    } else if (nextPath.endsWith('/')) {
      return path.substring(0, nextPath.length - 1);
    }

    return nextPath;
  }

  @override
  List<T> onPush<R>(String path, List<T> state, [ValueSetter<R>? onResult]) {
    final nextStack = List<T>.of(state);

    nextStack.add(RouteHistory<R>(
      path: path,
      onResult: onResult,
    ) as T);

    return List<T>.unmodifiable(nextStack);
  }

  String popPath(String path) {
    final parts = path.split('/');
    final newPath = parts.sublist(0, parts.length - 1).join('/');

    if (newPath.isNotEmpty) {
      return newPath;
    }

    return initial;
  }

  bool canPop(String path) => path.isNotEmpty && path != initial;

  @override
  List<T> onPop(List<T> state, [dynamic result]) {
    final nextStack = List<T>.of(state);

    if (nextStack.isNotEmpty) {
      nextStack.removeLast().onResult?.call(result);
    }

    return List<T>.unmodifiable(nextStack);
  }

  @override
  List<T> onReset(String path) {
    if (path.isEmpty) {
      return <T>[
        RouteHistory(
          path: initial,
        ) as T,
      ];
    }

    final parts = path.split("/");

    return [
      if (path != initial)
        ...onReset(parts.sublist(0, parts.length - 1).join("/")),
      RouteHistory(
        path: path,
      ) as T,
    ];
  }

  @override
  ValueSetter<R?> buildOnResultCallback<R>(Completer<R?> completer) =>
      (R? value) {
        if (completer.isCompleted) {
          return;
        }

        completer.complete(value);
      };
}
