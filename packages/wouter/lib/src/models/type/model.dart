import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../wouter.dart';
import '../../base.dart';
import '../models.dart';

part 'model.freezed.dart';

@freezed
class WouterType with _$WouterType {
  const factory WouterType.root({
    required BaseRouterDelegate delegate,
    required RoutingPolicy policy,
    required PathMatcher matcher,
    required bool canPop,
    required String base,
    required String path,
  }) = RootWouterType;

  const factory WouterType.child({
    required BaseWouter parent,
    required RoutingPolicy policy,
    required PathMatcher matcher,
    required bool canPop,
    required String base,
    required String path,
  }) = ChildWouterType;
}
