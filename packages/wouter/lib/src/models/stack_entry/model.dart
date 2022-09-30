import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models.dart';

part 'model.freezed.dart';

part 'model.mixin.dart';

@freezed
class StackEntry with _$StackEntry, StackEntryBuilder {
  const StackEntry._();

  const factory StackEntry({
    required String key,
    required String path,
    required WouterRouteBuilder builder,
    @Default({}) Map<String, dynamic> arguments,
  }) = _StackEntry;
}
