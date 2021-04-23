import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models.dart';

part 'model.freezed.dart';

part 'model.mixin.dart';

@freezed
class StackItem<T> with _$StackItem<T>, StackItemBuilder<T> {
  const StackItem._();

  const factory StackItem({
    required String path,
    required WouterRouteBuilder<T> builder,
    @Default({}) Map<String, dynamic> arguments,
  }) = _StackItem;
}
