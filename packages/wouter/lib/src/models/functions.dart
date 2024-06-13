import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:wouter/wouter.dart';

typedef RegexpBuilder = RegexpData Function(
  String pattern, {
  bool caseSensitive,
  bool prefix,
});

typedef PathBuilder = String Function(String current, String path);

typedef PushPredicate = bool Function(String path);

typedef PopPredicate = bool Function(String path, [dynamic result]);

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

typedef WouterListenableWidgetBuilder<T> = Widget Function(
  BuildContext,
  T,
  List<Widget>,
);

typedef CreateListenable<T> = T Function(BuildContext, int);

typedef DisposeListenable<T> = void Function(BuildContext, T);

typedef OnGetListenableIndex<T> = int? Function(T);

typedef OnRouteChanged<T> = FutureOr<void> Function(T, int);

typedef ToPathCallback = String? Function(
  int index,
  String base,
  String path,
  List<String> routes,
);

typedef ToIndexCallback = int? Function(
  String base,
  String path,
  List<String> routes,
);
