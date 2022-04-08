import 'package:flutter/foundation.dart';
import 'package:wouter/wouter.dart';

abstract class BaseWouter implements ChangeNotifier {
  WouterType get type;

  bool get canPop;

  RoutingPolicy get policy;

  PathMatcher get matcher;

  String get base;

  List<String> get stack;

  String get path;

  Future<R?> push<R>(String path);

  bool pop([dynamic result]);

  void reset([String? path]);
}

mixin RootWouter on BaseRouterDelegate implements BaseWouter {
  @override
  WouterType get type => WouterType.root(
        delegate: this,
        policy: policy,
        matcher: matcher,
        canPop: canPop,
        base: base,
        path: path,
      );
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
        path: path,
      );

  @override
  RoutingPolicy get policy => parent.policy;

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
