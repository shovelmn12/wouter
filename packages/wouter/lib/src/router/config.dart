import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:wouter/wouter.dart';

class WouterConfig extends RouterConfig<String> {
  WouterConfig({
    required Wouter wouter,
  })  : assert(wouter.key is GlobalKey<WouterState>),
        super(
          routerDelegate: WouterRouterDelegate(
            onNotifyListeners: () =>
                (wouter.key as GlobalKey<WouterState>)
                    .currentState
                    ?.stream
                    .map((stack) => stack.last.path)
                    .distinct() ??
                Stream.empty(),
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
            onPop: () =>
                (wouter.key as GlobalKey<WouterState>).currentState?.pop(),
          ),
          routeInformationParser: const WouterRouteInformationParser(),
          routeInformationProvider: WouterRouteInformationProvider(
            onGetRoute: () =>
                (wouter.key as GlobalKey<WouterState>).currentState?.path ?? "",
          ),
        );
}
