// export 'base.dart';
import 'dart:async';

import 'package:flutter/material.dart';

// import 'package:rxdart/rxdart.dart';
// import 'package:wouter/src/wouter.dart';

export 'matchers/matchers.dart';
export 'mixins/mixins.dart';

// export 'router.dart';
export 'routing_policy/routing_policy.dart';
// export 'wouter.dart';

typedef OnPopCallback = bool Function([dynamic result]);
typedef OnResetPathCallback = Future<void> Function(String path);

class WouterRouterDelegate extends RouterDelegate<String> with ChangeNotifier {
  final OnPopCallback onPop;
  final OnResetPathCallback onReset;
  final ValueGetter<String> onGetPath;
  final WidgetBuilder builder;

  late StreamSubscription<void> _subscription;

  @override
  String get currentConfiguration => onGetPath();

  WouterRouterDelegate({
    required Stream<String> onNotifyListeners,
    required this.onPop,
    required this.onReset,
    required this.onGetPath,
    required this.builder,
  }) {
    _subscription = onNotifyListeners.listen((event) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Navigator(
        onPopPage: (route, result) => !onPop(result),
        pages: [
          MaterialPage(
            child: builder(context),
          )
        ],
      );

  @override
  Future<bool> popRoute() async => onPop();

  @override
  Future<void> setNewRoutePath(String configuration) => onReset(configuration);
}
