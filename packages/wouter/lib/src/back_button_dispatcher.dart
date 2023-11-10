import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

typedef BackButtonDispatcherCallback = bool? Function();

/// Overrides default back button behavior in [BackButtonDispatcher]
/// to call [WouterRouterDelegate.pop].
class WouterBackButtonDispatcher extends RootBackButtonDispatcher {
  final BackButtonDispatcherCallback onPop;

  WouterBackButtonDispatcher({
    required this.onPop,
  });

  @override
  Future<bool> invokeCallback(Future<bool> defaultValue) =>
      SynchronousFuture(onPop() ?? false);
}
