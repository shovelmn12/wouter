import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'delegate.dart';

/// A delegate that is used by the [Router] widget
/// to build and configure a navigating widget.
abstract class BaseRouterDelegate<T> extends RouterDelegate<Uri>
    with ChangeNotifier, RouterState<T> {
  Widget get child;

  @override
  Uri? get currentConfiguration;

  /// Whether it is possible to [pop],
  bool get canPop;

  /// Push to [path]
  Future<R?> push<R>(String path);

  /// Pop the history stack
  /// Returns [canPop] before popping
  bool pop([dynamic? result]);

  void reset(String path);

  @override
  Future<bool> popRoute() => Future.value(pop());

  @override
  Future<void> setInitialRoutePath(Uri configuration) =>
      super.setInitialRoutePath(configuration);

  @override
  Future<void> setNewRoutePath(Uri uri) =>
      SynchronousFuture(reset(uri.toString()));

  @override
  Widget build(BuildContext context) => child;
}
