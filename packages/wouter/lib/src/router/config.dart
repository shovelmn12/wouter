import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:wouter/wouter.dart';

class WouterConfig extends RouterConfig<String> {
  WouterConfig({
    required GlobalKey<WouterState> key,
    required WidgetBuilder builder,
  }) : super(
          routerDelegate: WouterRouterDelegate(
            onNotifyListeners: () =>
                key.currentState?.stream
                    .map((stack) => stack.last.path)
                    .distinct() ??
                Stream.empty(),
            onPop: ([result]) => key.currentState?.pop(result) ?? true,
            onReset: (path) async => key.currentState?.reset(path),
            onGetPath: () => key.currentState?.path ?? "",
            onCanPop: () => key.currentState?.canPop ?? false,
            builder: builder,
          ),
          backButtonDispatcher: WouterBackButtonDispatcher(
            onPop: () => key.currentState?.pop(),
          ),
          routeInformationParser: const WouterRouteInformationParser(),
          routeInformationProvider: WouterRouteInformationProvider(
            onGetRoute: () => key.currentState?.path ?? "",
          ),
        );
}
