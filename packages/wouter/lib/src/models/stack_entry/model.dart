import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models.dart';

part 'model.freezed.dart';

part 'model.mixin.dart';

@freezed
class StackEntry<T> with _$StackEntry<T>, StackEntryBuilder<T> {
  const StackEntry._();

  const factory StackEntry({
    required String path,
    required WouterRouteBuilder<T> builder,
    @Default({}) Map<String, dynamic> arguments,
  }) = _StackEntry;
}
