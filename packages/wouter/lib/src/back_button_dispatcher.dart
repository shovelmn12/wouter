import 'dart:async';

import 'package:flutter/widgets.dart';

/// Overrides default back button behavior in [BackButtonDispatcher]
/// to call [WouterRouterDelegate.pop].
class WouterBackButtonDispatcher extends RootBackButtonDispatcher {
  final ValueGetter<Future<bool>> onPop;

  WouterBackButtonDispatcher({
    required this.onPop,
  });

  @override
  Future<bool> invokeCallback(Future<bool> defaultValue) => onPop();
}
