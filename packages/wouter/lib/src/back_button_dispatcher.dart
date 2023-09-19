import 'package:flutter/widgets.dart';

typedef BackButtonDispatcherCallback = Future<bool> Function(
    Future<bool> defaultValue);

/// Overrides default back button behavior in [BackButtonDispatcher]
/// to call [WouterRouterDelegate.pop].
class WouterBackButtonDispatcher extends BackButtonDispatcher {
  final BackButtonDispatcherCallback onPop;

  WouterBackButtonDispatcher({
    required this.onPop,
  });

  @override
  Future<bool> invokeCallback(Future<bool> defaultValue) => onPop(defaultValue);

  @override
  ChildBackButtonDispatcher createChildBackButtonDispatcher() {
    print("createChildBackButtonDispatcher");
    return super.createChildBackButtonDispatcher();
  }
}
