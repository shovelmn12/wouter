import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

@freezed
class RouteEntry<T> with _$RouteEntry<T> {
  const factory RouteEntry({
    required String path,
    ValueSetter<T>? onResult,
  }) = _RouteEntry;
}
