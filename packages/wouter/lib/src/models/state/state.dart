import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wouter/wouter.dart' hide WouterState;

part 'state.freezed.dart';

@freezed
class WouterState with _$WouterState {
  const factory WouterState({
    required PathMatcher matcher,
    required RoutingPolicy policy,
    required String base,
    required List<RouteEntry> stack,
  }) = _WouterState;
}

extension WouterStatePathExtension on WouterState {
  String get path => stack.last.path;
}

extension WouterStateCanPopExtension on WouterState {
  bool get canPop => stack.length > 1;
}

extension WouterStateFullPathExtension on WouterState {
  String get fullPath => '$base$path';
}
