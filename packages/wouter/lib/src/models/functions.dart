import 'package:wouter/wouter.dart';

typedef RegexpBuilder = RegexpData Function(
  String pattern, {
  bool caseSensitive,
  bool prefix,
});

typedef PathBuilder = String Function(String current, String path);

typedef PushPredicate = bool Function(String path);

typedef PopPredicate = bool Function(String path, [dynamic result]);
