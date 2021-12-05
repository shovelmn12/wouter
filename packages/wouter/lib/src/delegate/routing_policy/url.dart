import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

import '../../models/models.dart';
import 'routing_policy.dart';

class URLRoutingPolicy<T extends RouteEntry>
    implements RoutingPolicy<List<T>> {
  @override
  final String initial;

  const URLRoutingPolicy({
    this.initial = '/',
  });

  @override
  String removeBase(String base, String path) {
    if (path.startsWith(base)) {
      final next = path.substring(base.length);

      if (next.isEmpty) {
        return initial;
      }

      return next;
    }

    return path;
  }

  @override
  String buildPath(String base, String path) {
    if (path.startsWith(".") || path.startsWith("/")) {
      return path;
    } else if (path.isEmpty) {
      return base;
    } else {
      return "$base/$path";
    }
  }

  @override
  String pushPath(String current, String path) {
    if (path.startsWith(".")) {
      return normalize("$current/$path");
    } else if (path.startsWith("/")) {
      return path;
    } else if (path.isEmpty) {
      return initial;
    } else {
      return "$current/$path";
    }
  }

  @override
  String popPath(String path) {
    final parts = path.split('/');
    final newPath = parts.sublist(0, parts.length - 1).join('/');

    if (newPath.isNotEmpty) {
      return newPath;
    }

    return initial;
  }

  @override
  List<String> createStack(String path) {
    final next = pushPath("", path);

    if (next.isEmpty || next == initial) {
      return [
        initial,
      ];
    }

    return [
      ...createStack(popPath(next)),
      next,
    ];
  }

  @override
  List<T> onPush<R>(String path, List<T> state, [ValueSetter<R>? onResult]) {
    final nextStack = List<T>.of(state);

    nextStack.add(RouteEntry<R>(
      path: path,
      onResult: onResult,
    ) as T);

    return List<T>.unmodifiable(nextStack);
  }

  @override
  List<T> onPop(List<T> state, [dynamic result]) {
    final nextStack = List<T>.of(state);

    if (nextStack.isNotEmpty) {
      nextStack.removeLast().onResult?.call(result);
    }

    return List<T>.unmodifiable(nextStack);
  }

  @override
  List<T> onReset(String current, String path) {
    final next = pushPath(current, path);

    if (next.isEmpty || next == initial) {
      return <T>[
        RouteEntry(
          path: initial,
        ) as T,
      ];
    }

    return [
      ...onReset("", popPath(next)),
      RouteEntry(
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
