import '../wouter.dart';
import 'delegate/delegate.dart';

abstract class BaseWouter {
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

  Future<R?> push<R>(String path) => delegate.push(path);

  bool pop([dynamic result]) => delegate.pop(result);

  void reset([String path = "/"]) => delegate.reset(path);
}

mixin ChildWouter implements BaseWouter {
  BaseWouter get parent;

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

  Future<R?> push<R>(String path) {
    if (path.startsWith(".") || path.startsWith("/")) {
      return parent.push(path);
    }

    return parent.push("$base/$path");
  }

  bool pop([dynamic result]) => parent.pop(result);

  void reset([String path = "/"]) {
    if (path.startsWith(".") || path.startsWith("/")) {
      parent.reset(path);
    }

    parent.reset("$base/$path");
  }
}
