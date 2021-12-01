import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../wouter.dart';
import 'delegate.dart';

/// A delegate that is used by the [Router] widget to build and configure a navigating widget.
abstract class WouterBaseRouterDelegate<T extends RouteHistory>
    extends BaseRouterDelegate<T>
    with DelegateRoutingActions<T>, StreamRouterState<List<T>> {
  final String tag;
  @override
  @protected
  final RoutingPolicy<List<T>> policy;
  @override
  final Widget child;

  WouterBaseRouterDelegate({
    required this.child,
    this.policy = const URLRoutingPolicy(),
    this.tag = '',
    String initial = '/',
  }) : super() {
    state = [
      RouteHistory(
        path: initial,
      ) as T,
    ];
  }

  //only parent update uri
  @override
  Uri? get currentConfiguration => Uri.parse(state.last.path);

  @override
  bool get canPop => state.length > 1;

  @override
  bool shouldNotify(List<T> prev, List<T> next) =>
      prev.last.path != next.last.path;

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<WouterBaseRouterDelegate>.value(
        value: this,
        child: Wouter(
          child: super.build(context),
        ),
      );
}
