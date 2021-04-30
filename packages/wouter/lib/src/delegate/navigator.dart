import 'package:flutter/material.dart';

import '../models/models.dart';
import 'delegate.dart';

/// A delegate that is used by the [Router] widget
/// to build and configure a navigating widget.
class WouterRouterDelegate
    extends WouterBaseRouterDelegate<WouterDelegateState> {
  @override
  final WouterDelegateState initialState = const WouterDelegateState();

  WouterRouterDelegate({
    required Widget child,
    RoutingPolicy<WouterDelegateState> policy = const URLRoutingPolicy(),
    PathMatcherBuilder matcher = PathMatchers.regexp,
    String tag = '',
    String initial = '/',
    String base = '',
  }) : super(
          child: child,
          policy: policy,
          matcher: matcher,
          tag: tag,
          initial: initial,
          base: base,
        );

  WouterRouterDelegate.withParent({
    required WouterBaseRouterDelegate parent,
    required Widget child,
    RoutingPolicy<WouterDelegateState> policy = const URLRoutingPolicy(),
    PathMatcherBuilder matcher = PathMatchers.regexp,
    String tag = '',
    String base = '',
  }) : super.withParent(
          child: child,
          parent: parent,
          policy: policy,
          matcher: matcher,
          tag: tag,
          base: base,
        );
}
