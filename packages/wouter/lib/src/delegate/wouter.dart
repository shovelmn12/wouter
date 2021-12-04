import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wouter/src/base.dart';

import '../models/models.dart';
import 'delegate.dart';

/// A delegate that is used by the [Router] widget to build and configure a navigating widget.
abstract class WouterBaseRouterDelegate<T extends RouteHistory>
    extends BaseRouterDelegate<T>
    with DelegateRoutingActions<T>, StreamRouterState<List<T>> {
  final String tag;
  @override
  final RoutingPolicy<List<T>> policy;
  @override
  final Widget child;

  final PathMatcher matcher;

  @protected
  late final BaseWouter wouter = BaseWouter.root(
    delegate: this,
  );

  WouterBaseRouterDelegate({
    required this.child,
    this.policy = const URLRoutingPolicy(),
    this.tag = '',
    PathMatcherBuilder matcher = PathMatchers.regexp,
    String initial = '/',
  })  : matcher = matcher(),
        super() {
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
  Widget build(BuildContext context) => Provider<BaseWouter>.value(
        value: wouter,
        child: super.build(context),
      );
}
