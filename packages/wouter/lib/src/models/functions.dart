import 'package:wouter/wouter.dart';

typedef RegexpBuilder = RegexpData Function(
  String pattern, {
  bool caseSensitive,
  bool prefix,
});



typedef PopPredicate<T> = bool Function(T value);


