import 'package:flutter/widgets.dart';

import 'delegate/delegate.dart';

/// Overrides default back button behavior in [RootBackButtonDispatcher]
/// to do [BeamerRouterDelegate.beamBack] when possible.
class WouterBackButtonDispatcher extends RootBackButtonDispatcher {
  final BaseRouterDelegate delegate;

  WouterBackButtonDispatcher({
    required this.delegate,
  });

  @override
  Future<bool> invokeCallback(Future<bool> defaultValue) async {
    if (await super.invokeCallback(defaultValue)) {
      return true;
    } else {
      return delegate.pop();
    }
  }
}
