import 'package:flutter/foundation.dart';

import '../wouter.dart';
import 'delegate/delegate.dart';

abstract class BaseWouter implements ChangeNotifier {
  WouterType get type;

  bool get canPop;

  // Stream<List<String>> get stream;

  RoutingPolicy get policy;

  PathMatcher get matcher;

  String get base;

  List<String> get stack;

  String get route;

  Future<R?> push<R>(String path);

  bool pop([dynamic result]);

  void reset([String? path]);
}

mixin RootWouter on BaseRouterDelegate implements BaseWouter {
  // WouterBaseRouterDelegate get delegate;

  @override
  WouterType get type => WouterType.root(
        delegate: this,
        policy: policy,
        matcher: matcher,
        canPop: canPop,
        base: base,
        route: route,
      );

// @override
// bool get canPop => canPop;

// @override
// Stream<List<String>> get stream => stream
//     .map((stack) => stack.map((entry) => entry.path).toList())
//     .distinct();

// @override
// RoutingPolicy get policy => policy;

// @override
// PathMatcher get matcher => delegate.matcher;

// @override
// String get route => "${delegate.currentConfiguration ?? ""}";

// Future<R?> push<R>(String path) => super.push(policy.pushPath(
//       route,
//       policy.buildPath(base, path),
//     ));
//
// bool pop([dynamic result]) => super.pop(result);
//
// void reset([String path = "/"]) => super.reset(policy.pushPath(
//       route,
//       policy.buildPath(base, path),
//     ));
}

mixin ChildWouter implements BaseWouter {
  BaseWouter get parent;

  @override
  WouterType get type => WouterType.child(
        parent: parent,
        policy: policy,
        matcher: matcher,
        canPop: canPop,
        base: base,
        route: route,
      );

  @override
  RoutingPolicy get policy => parent.policy;

  // @override
  // Stream<List<String>> get stream => parent.stream
  //     .map((stack) => stack
  //         .where((path) => path.startsWith(base))
  //         .map((path) => policy.removeBase(base, path))
  //         .toList())
  //     .distinct();

  Future<R?> push<R>(String path) => parent.push(
        policy.buildPath(
          base,
          path,
        ),
      );

  bool pop([dynamic result]) => parent.pop(result);

  void reset([String? path]) => parent.reset(
        policy.buildPath(
          base,
          path ?? policy.initial,
        ),
      );
}
