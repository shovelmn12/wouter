import 'package:flutter/widgets.dart';

import 'models.dart';

typedef WouterRouteBuilder<T> = T Function(
  BuildContext context, [
  Map<String, dynamic> arguments,
]);

typedef RegexpBuilder = RegexpData Function(
  String pattern, {
  bool caseSensitive,
  bool prefix,
});

typedef PathMatcherBuilder = PathMatcher Function();

typedef PathMatcher = MatchData? Function(
  String path,
  String pattern,
);

typedef PopPredicate<T> = bool Function(T value);
