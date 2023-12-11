import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:wouter/wouter.dart';

export 'url.dart';

abstract class RoutingPolicy {
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
  List<RouteEntry> onPush<R>(String path, covariant List<RouteEntry> state, [ValueSetter<R>? onResult]);

  /// pop state
  List<RouteEntry> onPop(List<RouteEntry> state, [dynamic result]);

  /// returns state as if only [path] was pushed
  List<RouteEntry> onReset(String path);

  /// build result call back for [completer]
  ValueSetter<R?> buildOnResultCallback<R>(Completer<R?> completer);
}
