import 'dart:async';

import 'package:flutter/foundation.dart';

export 'url.dart';

abstract class RoutingPolicy<T> {
  const RoutingPolicy();

  bool isCurrentPath(T state, String path);

  String removeBase(String base, String path);

  String pushPath(String base, String current, String path);

  T onPush<R>(String path, T state, [ValueSetter<R>? onResult]);

  T onPop(T state, [dynamic result]);

  ValueSetter<R?> buildOnResultCallback<R>(Completer<R?> completer);
}
