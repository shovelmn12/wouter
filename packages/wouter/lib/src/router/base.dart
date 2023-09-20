import 'package:wouter/wouter.dart';

abstract mixin class BaseWouter {
  bool get canPop;

  RoutingPolicy get policy;

  PathMatcher get matcher;

  String get base;

  String get path;

  Future<R?> push<R>(String path);

  bool pop([dynamic result]);

  void reset([String? path]);
}
