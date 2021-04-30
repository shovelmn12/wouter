import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

@freezed
class RouteHistory<T> with _$RouteHistory<T> {
  const factory RouteHistory({
    required String path,
    ValueSetter<T>? onResult,
  }) = _RouteHistory;
}
