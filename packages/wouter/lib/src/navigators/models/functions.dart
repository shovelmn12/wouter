import 'package:flutter/widgets.dart';
import 'package:wouter/wouter.dart';

typedef WouterWidgetBuilder = Widget Function(
  BuildContext context,
  Map<String, dynamic> arguments,
);

typedef PathMatcherBuilder = PathMatcher Function();

typedef PathMatcher = MatchData? Function(
  String path,
  String pattern, {
  bool prefix,
});
