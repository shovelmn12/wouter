import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

@freezed
sealed class RegexpData with _$RegexpData {
  const factory RegexpData({
    required RegExp regexp,
    @Default([]) List<String> parameters,
  }) = _RegexpData;
}
