import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

import '../../models/models.dart';
import 'routing_policy.dart';

class URLRoutingPolicy<T extends RouteEntry> implements RoutingPolicy<List<T>> {
  @override
  final String initial;
  final Set<String> groups;

  const URLRoutingPolicy({
    this.initial = '/',
    this.groups = const {},
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
  String pushPath(String current, String base, String path) {
    if (path.startsWith(".")) {
      return normalize("$current/$path");
    } else if (path.startsWith("/")) {
      return normalize(path);
    } else if (path.isEmpty) {
      return initial;
    } else {
      return normalize("$base/$path");
    }
  }

  @override
  String popPath(String path) {
    final groups = this.groups.foldIndexed<Map<String, Pair<Match, String>>>(
        const {},
        (parentIndex, acc, pattern) => {
              ...acc,
              ...RegExp(pattern).allMatches(path).foldIndexed<Map<String, Pair<Match, String>>>(
                  const <String, Pair<Match, String>>{},
                  (index, acc, match) => {
                        ...acc,
                        "pattern-$parentIndex-match-$index": Pair(
                          item1: match,
                          item2: path.substring(match.start, match.end),
                        ),
                      }),
            });
    final parts = groups.entries
        .fold<String>(
            path,
            (path, entry) => path.replaceRange(
                  entry.value.item1.start,
                  entry.value.item1.end,
                  "/${entry.key}",
                ))
        .split('/');
    final newPath = parts.sublist(0, parts.length - 1).join('/');

    if (newPath.isNotEmpty) {
      return groups.entries.fold<String>(
        newPath,
        (path, entry) => path.replaceAll(entry.key, entry.value.item2),
      );
    }

    return initial;
  }

  @override
  List<String> createStack(String path) {
    final next = pushPath("", "", path);

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
  List<T> onReset(String path) {
    if (path.isEmpty || path == initial) {
      return <T>[
        RouteEntry(
          path: initial,
        ) as T,
      ];
    }

    return [
      ...onReset(popPath(path)),
      RouteEntry(
        path: path,
      ) as T,
    ];
  }

  @override
  ValueSetter<R?> buildOnResultCallback<R>(Completer<R?> completer) => (R? value) {
        if (completer.isCompleted) {
          return;
        }

        completer.complete(value);
      };
}
