import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import 'delegate.dart';

/// A delegate that is used by the [Router] widget to build and configure a navigating widget.
abstract class WouterBaseRouterDelegate<T extends WouterDelegateState>
    extends BaseRouterDelegate<T> with ValueRouterState<T>, RoutingActions<T> {
  final PathMatcher matcher;

  @override
  final String tag;
  @override
  @protected
  final RoutingPolicy<T> policy;
  @override
  @protected
  final WouterBaseRouterDelegate? parent;
  @override
  final Widget child;

  @override
  bool get hasParent => parent != null;

  WouterBaseRouterDelegate({
    required this.child,
    this.policy = const URLRoutingPolicy(),
    PathMatcherBuilder matcher = PathMatchers.regexp,
    this.tag = '',
    String initial = '/',
  })  : parent = null,
        matcher = matcher(),
        super() {
    onInitialize(initial);
  }

  WouterBaseRouterDelegate.withParent({
    required this.child,
    required WouterBaseRouterDelegate parent,
    this.policy = const URLRoutingPolicy(),
    PathMatcherBuilder matcher = PathMatchers.regexp,
    this.tag = '',
  })  : parent = parent,
        matcher = matcher(),
        super() {
    onInitialize(parent.state.path);
  }

  @protected
  void onInitialize(String path) {
    onParentPathUpdated(path);

    parent?.addListener(_onParentUpdated);
  }

  //only parent update uri
  @override
  Uri? get currentConfiguration => parent == null ? state.uri : null;

  @override
  bool get canPop => state.canPop || (parent?.canPop ?? false);

  @override
  @mustCallSuper
  void dispose() {
    parent?.removeListener(_onParentUpdated);

    super.dispose();
  }

  void _onParentUpdated() {
    final path = parent!.state.path;

    if (path.isEmpty) {
      return;
    }

    onParentPathUpdated(path);
  }

  @override
  bool shouldNotify(T prev, T next) => prev.path != next.path;

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<WouterBaseRouterDelegate<T>>.value(
        value: this,
        child: super.build(context),
      );
}
