import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wouter/wouter.dart';

export 'functions.dart';

class WouterRouterDelegate extends RouterDelegate<String> with ChangeNotifier {
  final OnPopCallback onPop;
  final OnResetPathCallback onReset;
  final ValueGetter<String> onGetPath;
  final WidgetBuilder builder;

  late StreamSubscription<void> _subscription;

  @override
  String get currentConfiguration => onGetPath();

  WouterRouterDelegate({
    required ValueGetter<Stream<String>> onNotifyListeners,
    required this.onPop,
    required this.onReset,
    required this.onGetPath,
    required this.builder,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _subscription =
        onNotifyListeners().listen((event) => notifyListeners()));
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
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: builder(context),
            ),
          )
        ],
      );

  @override
  Future<bool> popRoute() async => onPop();

  @override
  Future<void> setNewRoutePath(String configuration) => onReset(configuration);
}
