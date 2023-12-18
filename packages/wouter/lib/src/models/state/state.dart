import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wouter/wouter.dart' hide WouterState;

part 'state.freezed.dart';

@freezed
class WouterState with _$WouterState {
  const factory WouterState({
    required bool canPop,
    required String base,
    required List<RouteEntry> stack,
  }) = _WouterState;
}

extension WouterStatePathExtension on WouterState {
  String get path => stack.lastOrNull?.path ?? "";
}

extension WouterStateFullPathExtension on WouterState {
  String get fullPath => '$base$path';
}
