import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

@freezed
class MatchData with _$MatchData {
  const factory MatchData({
    required String path,
    required Map<String, dynamic> arguments,
  }) = _MatchData;
}
