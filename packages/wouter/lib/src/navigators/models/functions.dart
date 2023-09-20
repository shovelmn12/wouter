import 'package:flutter/widgets.dart';
import 'package:wouter/wouter.dart';

typedef WouterRouteBuilder<T> = T Function(
  BuildContext context,
  Map<String, dynamic> arguments,
);

typedef WouterStackBuilder<T> = Widget Function(
  BuildContext context,
  BaseWouter wouter,
  List<T> stack,
);

typedef PathMatcherBuilder = PathMatcher Function();

typedef PathMatcher = MatchData? Function(
  String path,
  String pattern, {
  bool prefix,
});
