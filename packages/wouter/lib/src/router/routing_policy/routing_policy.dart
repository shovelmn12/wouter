import 'dart:async';

import 'package:flutter/foundation.dart';

export 'url.dart';

abstract class RoutingPolicy<T> {
  const RoutingPolicy();

  /// removes [base] from [path]
  String removeBase(String base, String path);

  /// build path for a child wouter
  String buildPath(String base, String path);

  /// merge current and next path
  String pushPath(String current, String path);

  /// pop path
  String popPath(String path);

  /// create stack for [path]
  List<String> createStack(String path);

  /// push [path] to [state]
  T onPush<R>(String path, covariant T state, [ValueSetter<R>? onResult]);

  /// pop state
  T onPop(T state, [dynamic result]);

  /// returns state as if only [path] was pushed
  T onReset(String path);

  /// build result call back for [completer]
  ValueSetter<R?> buildOnResultCallback<R>(Completer<R?> completer);
}
