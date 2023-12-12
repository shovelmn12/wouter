import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:wouter/wouter.dart';

class WouterConfig extends RouterConfig<String> {
  WouterConfig({
    required WidgetBuilder builder,
  }) : super(
          routerDelegate: WouterRouterDelegate(
            builder: builder,
          ),
          backButtonDispatcher: WouterBackButtonDispatcher(
            onPop: () => true,
          ),
          routeInformationParser: const WouterRouteInformationParser(),
          routeInformationProvider: WouterRouteInformationProvider(
            onGetRoute: () => "",
          ),
        );
}
