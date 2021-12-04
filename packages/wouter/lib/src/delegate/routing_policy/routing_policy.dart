import 'dart:async';

import 'package:flutter/foundation.dart';

export 'url.dart';

abstract class RoutingPolicy<T> {
  String get initial;

  const RoutingPolicy();

  String removeBase(String base, String path);

  String buildPath(String base, String path);

  String pushPath(String current, String path);

  String popPath(String path);

  List<String> createStack(String path);

  T onPush<R>(String path, covariant T state, [ValueSetter<R>? onResult]);

  T onPop(T state, [dynamic result]);

  T onReset(String current, String path);

  ValueSetter<R?> buildOnResultCallback<R>(Completer<R?> completer);
}
