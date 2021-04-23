import 'package:flutter/widgets.dart';

import 'models.dart';

typedef PageBuilder<T> = Page<T> Function(BuildContext context);

typedef PathNotFoundCallback<S, T> = T Function(
  BuildContext context,
  S state,
);

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

typedef PagePopCallback<T> = bool Function(
  BuildContext context,
  T state,
  dynamic result,
);
