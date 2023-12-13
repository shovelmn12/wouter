import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:wouter/wouter.dart';

class URLRoutingPolicy implements RoutingPolicy {
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
      return List<String>.unmodifiable([
        next,
      ]);
    }

    return List<String>.unmodifiable([
      if (!groups.contains(next)) ...createStack(popPath(next)),
      next,
    ]);
  }

  @override
  List<RouteEntry> onPush<R>(
    String path,
    List<RouteEntry> state, [
    ValueSetter<R>? onResult,
  ]) {
    final nextStack = List<RouteEntry>.of(state);

    nextStack.add(RouteEntry<R>(
      path: path,
      onResult: onResult,
    ));

    return List<RouteEntry>.unmodifiable(nextStack);
  }

  @override
  List<RouteEntry> onPop(List<RouteEntry> state, [dynamic result]) {
    final nextStack = List<RouteEntry>.of(state);

    if (nextStack.isNotEmpty) {
      nextStack.removeLast().onResult?.call(result);
    }

    return List<RouteEntry>.unmodifiable(nextStack);
  }

  @override
  List<RouteEntry> onReset(String path) {
    if (path == "/") {
      return List<RouteEntry>.unmodifiable([
        RouteEntry(
          path: "/",
        ),
      ]);
    }

    return List<RouteEntry>.unmodifiable([
      if (!groups.contains(path)) ...onReset(popPath(path)),
      RouteEntry(
        path: path,
      ),
    ]);
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
