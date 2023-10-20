import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:wouter/wouter.dart';

class URLRoutingPolicy<T extends RouteEntry> implements RoutingPolicy<List<T>> {
  final Set<String> groups;

  const URLRoutingPolicy({
    this.groups = const {},
  });

  @override
  String removeBase(String base, String path) {
    if (path.startsWith(base)) {
      return path.substring(base.length);
    }

    return path;
  }

  @override
  String buildPath(String base, String path) {
    if (path.startsWith(".") || path.startsWith("/")) {
      return path;
    } else if (path.isEmpty && base.isEmpty) {
      return path;
    } else if (path.isEmpty) {
      if (base.startsWith("/")) {
        return base.substring(1);
      }

      return base;
    } else if (base.isEmpty) {
      if (path.startsWith("/")) {
        return path.substring(1);
      }

      return path;
    } else {
      if (base.startsWith("/")) {
        return "${base.substring(1)}/$path";
      }

      return "$base/$path";
    }
  }

  @override
  String pushPath(String current, String path) {
    if (path.startsWith(".")) {
      return normalize("$current/$path");
    } else if (path.startsWith("/")) {
      return normalize(path);
    } else if (path.isEmpty) {
      return "/";
    } else {
      return normalize("$current/$path");
    }
  }

  String _popPath(String path) {
    if (this.groups.isEmpty) {
      final parts = path.split("/");
      return parts.sublist(0, parts.length - 1).join('/');
    }

    final groups = this.groups.foldIndexed<Map<String, Pair<Match, String>>>(
      const {},
      (parentIndex, acc, pattern) => {
        ...acc,
        ...RegExp(pattern)
            .allMatches(path)
            .foldIndexed<Map<String, Pair<Match, String>>>(
                const <String, Pair<Match, String>>{},
                (index, acc, match) => {
                      ...acc,
                      "pattern-$parentIndex-match-$index": (
                        item1: match,
                        item2: path.substring(match.start, match.end),
                      ),
                    }),
      },
    );

    final parts = groups.entries
        .fold<String>(
          path,
          (path, entry) => path.replaceRange(
            entry.value.item1.start,
            entry.value.item1.end,
            "/${entry.key}",
          ),
        )
        .split('/');

    return groups.entries.fold<String>(
      parts.sublist(0, parts.length - 1).join('/'),
      (path, entry) => path.replaceAll(entry.key, entry.value.item2),
    );
  }

  @override
  String popPath(String path) {
    final nextPath = _popPath(path);

    if (nextPath.isNotEmpty) {
      return nextPath;
    }

    return "/";
  }

  @override
  List<String> createStack(String path) {
    final next = pushPath(
      "",
      path,
    );

    if (next == "/") {
      return [
        next,
      ];
    }

    return [
      if (!groups.contains(next)) ...createStack(popPath(next)),
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
  List<T> onReset(String path) {
    if (path == "/") {
      return <T>[
        RouteEntry(
          path: "/",
        ) as T,
      ];
    }

    return [
      if (!groups.contains(path)) ...onReset(popPath(path)),
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
