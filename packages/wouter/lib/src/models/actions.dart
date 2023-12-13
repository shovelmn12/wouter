import 'package:wouter/wouter.dart';

typedef WouterStateUpdateCallback = List<RouteEntry> Function(List<RouteEntry>);

typedef WouterActions = ({
  Future<T?> Function<T>(String) push,
  bool Function([dynamic]) pop,
  void Function([String]) reset,
  Future<T> Function<T>(String, [dynamic]) replace,
  void Function(WouterStateUpdateCallback update) update,
});
