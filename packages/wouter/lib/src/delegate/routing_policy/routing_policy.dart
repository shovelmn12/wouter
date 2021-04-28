import 'package:flutter/foundation.dart';

export 'url.dart';

abstract class RoutingPolicy<T> {
  const RoutingPolicy();

  bool isCurrentPath(T state, String path);

  T onReset(String base, String path);

  String pushPath(String base, String current, String next);

  T onPush<R>(String path, T state, [ValueSetter<R>? onResult]);

  String popPath(String path);

  T onPop(T state, [dynamic result]);
}
