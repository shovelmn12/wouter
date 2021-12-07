import 'dart:async';

import 'package:flutter/foundation.dart';

export 'url.dart';

abstract class RoutingPolicy<T> {
  String get initial;

  const RoutingPolicy();

  /// removes a [base] from a [path]
  String removeBase(String base, String path);

  /// builds path for a child wouter
  String buildPath(String base, String path);

  /// builds path for root wouter
  String buildRootPath(String base, String path);

  /// merging current and next path
  String pushPath(String current, String path);

  /// pop path
  String popPath(String path);

  /// creating stack for [path]
  List<String> createStack(String path);

  /// pushing [path] to [state]
  T onPush<R>(String path, covariant T state, [ValueSetter<R>? onResult]);

  /// popping state
  T onPop(T state, [dynamic result]);

  /// returning state as if only [path] was pushed
  T onReset(String path);

  /// build result call back for [completer]
  ValueSetter<R?> buildOnResultCallback<R>(Completer<R?> completer);
}
