import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'delegate/delegate.dart';

/// Overrides default back button behavior in [RootBackButtonDispatcher]
/// to call [WouterRouterDelegate.pop].
class WouterBackButtonDispatcher extends RootBackButtonDispatcher {
  final BaseRouterDelegate delegate;

  WouterBackButtonDispatcher({
    required this.delegate,
  });

  @override
  Future<bool> invokeCallback(Future<bool> defaultValue) =>
      SynchronousFuture(delegate.pop());
}
