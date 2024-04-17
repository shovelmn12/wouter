import 'package:collection/collection.dart';

class StartsWithEquality implements Equality<String> {
  const StartsWithEquality();

  @override
  bool equals(String? e1, String? e2) =>
      (e1 == null || e2 == null) ? false : e1.startsWith(e2);

  @override
  int hash(String? e) => e.hashCode;

  @override
  bool isValidKey(Object? o) => true;
}
