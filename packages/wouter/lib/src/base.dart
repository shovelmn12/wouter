import '../wouter.dart';
import 'delegate/delegate.dart';

abstract class BaseWouter {
  WouterType get type;

  bool get canPop;

  Stream<List<String>> get stream;

  RoutingPolicy get policy;

  PathMatcher get matcher;

  String get base;

  String get route;

  const factory BaseWouter.root({
    required WouterBaseRouterDelegate delegate,
  }) = RootWouter;

  Future<R?> push<R>(String path);

  bool pop([dynamic result]);

  void reset([String path = "/"]);
}

class RootWouter implements BaseWouter {
  final WouterBaseRouterDelegate delegate;

  @override
  WouterType get type => WouterType.root(
        delegate: delegate,
        policy: policy,
        matcher: matcher,
        canPop: canPop,
        base: base,
        route: route,
      );

  @override
  bool get canPop => delegate.canPop;

  @override
  Stream<List<String>> get stream => delegate.stream
      .map((stack) => stack.map((entry) => entry.path).toList())
      .distinct();

  @override
  RoutingPolicy get policy => delegate.policy;

  @override
  PathMatcher get matcher => delegate.matcher;

  @override
  String get base => "";

  @override
  String get route => "${delegate.currentConfiguration ?? ""}";

  const RootWouter({
    required this.delegate,
  });

  Future<R?> push<R>(String path) => delegate.push(policy.pushPath(base, path));

  bool pop([dynamic result]) => delegate.pop(result);

  void reset([String path = "/"]) =>
      delegate.reset(policy.pushPath(base, path));
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
  bool get canPop => parent.canPop;

  @override
  RoutingPolicy get policy => parent.policy;

  @override
  Stream<List<String>> get stream => parent.stream
      .map((stack) => stack
          .where((path) => path.startsWith(base))
          .map((path) => policy.removeBase(base, path))
          .toList())
      .distinct();

  Future<R?> push<R>(String path) => parent.push(policy.buildPath(base, path));

  bool pop([dynamic result]) => parent.pop(result);

  void reset([String path = "/"]) => parent.reset(policy.buildPath(base, path));
}
