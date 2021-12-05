import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

@freezed
class Pair<T, S> with _$Pair<T, S> {
  const factory Pair({
    required T item1,
    required S item2,
  }) = _Pair;
}
