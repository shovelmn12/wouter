import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'delegate.dart';

/// A base delegate that is used by the [Router] widget to build and configure a navigating widget.
abstract class BaseRouterDelegate<T> extends RouterDelegate<Uri>
    with ChangeNotifier, RouterState<T> {
  /// The widget below this widget in the tree.
  Widget get child;

  @override
  Uri? get currentConfiguration;

  /// Whether it is possible to [pop].
  bool get canPop;

  /// Push a [path].
  ///
  /// Returns a Future that completes to the result value passed to pop when the pushed route is popped off the navigator.
  ///
  ///The T type argument is the type of the return value of the route.
  ///
  Future<R?> push<R extends Object?>(String path);

  /// Pop the history stack.
  /// Returns [canPop] before popping.
  bool pop([dynamic result]);

  /// Resets the state as if only [path] been pushed.
  void reset(String path);

  /// Calling [pop]
  @override
  Future<bool> popRoute() => Future.value(pop());

  /// Calling [reset]
  @override
  Future<void> setNewRoutePath(Uri uri) =>
      SynchronousFuture(reset(uri.toString()));

  /// Called by the [Router] to obtain the widget tree that represents the current state.
  ///
  /// The context is the [Router]'s build context.
  @override
  Widget build(BuildContext context) => child;
}
