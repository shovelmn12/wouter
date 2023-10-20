import 'package:wouter/wouter.dart';

abstract mixin class BaseWouter {
  bool get canPop;

  WouterState? get parent;

  RoutingPolicy get policy;

  PathMatcher get matcher;

  String get base;

  List<String> get stack;

  String get path;

  Future<R?> push<R>(String path);

  bool pop([dynamic result]);

  void reset([String path]);

  void update(List<RouteEntry> Function(List<RouteEntry> state) update);
}
