import 'package:flutter/material.dart';

import '../models/models.dart';
import 'delegate.dart';

/// A delegate that is used by the [Router] widget
/// to build and configure a navigating widget.
class WouterRouterDelegate extends WouterBaseRouterDelegate<RouteHistory> {
  WouterRouterDelegate({
    required Widget child,
    RoutingPolicy<List<RouteHistory>> policy = const URLRoutingPolicy(),
    String tag = '',
    String initial = '/',
    String base = '',
  }) : super(
          child: child,
          policy: policy,
          tag: tag,
          initial: initial,
        );
}
