import 'dart:async';

import 'package:flutter/foundation.dart';

export 'url.dart';

abstract class RoutingPolicy<T> {
  const RoutingPolicy();

  String pushPath(String current, String path);

  T onPush<R>(String path, covariant T state, [ValueSetter<R>? onResult]);

  T onPop(T state, [dynamic result]);

  T onReset(String path);

  ValueSetter<R?> buildOnResultCallback<R>(Completer<R?> completer);
}
