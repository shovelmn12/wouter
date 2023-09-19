import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:wouter/src/back_button_dispatcher.dart';
import 'package:wouter/src/delegate/delegate.dart';
import 'package:wouter/src/route_information.dart';
import 'package:wouter/src/wouter.dart';

class WouterConfig extends RouterConfig<String> {
  WouterConfig({
    required Wouter wouter,
  })  : assert(wouter.key is GlobalKey<WouterState>),
        super(
          routerDelegate: WouterRouterDelegate(
            onNotifyListeners: Stream.empty(),
            onPop: ([result]) =>
                (wouter.key as GlobalKey<WouterState>)
                    .currentState
                    ?.pop(result) ??
                true,
            onReset: (path) async => (wouter.key as GlobalKey<WouterState>)
                .currentState
                ?.reset(path),
            onGetPath: () =>
                (wouter.key as GlobalKey<WouterState>).currentState?.path ?? "",
            builder: (context) => wouter,
          ),
          backButtonDispatcher: WouterBackButtonDispatcher(
            onPop: (value) async =>
                (wouter.key as GlobalKey<WouterState>).currentState?.pop() ??
                true,
          ),
          routeInformationParser: const WouterRouteInformationParser(),
          routeInformationProvider: WouterRouteInformationProvider(
            onGetRoute: () =>
                (wouter.key as GlobalKey<WouterState>).currentState?.path ?? "",
          ),
        );
}
