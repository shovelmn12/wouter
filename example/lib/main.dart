import 'package:flutter/widgets.dart';
import 'package:wouter/wouter.dart';
import 'package:flutter_widgets_app/flutter_widgets_app.dart';

import 'simple.dart';

class ExampleApp extends StatelessWidget {
  final delegate = WouterRouterDelegate(
    child: WouterSwitch(
      routes: {
        '/': (context, arguments) => const SimpleExampleApp(
              key: ValueKey('simple-example'),
            ),
      },
    ),
  );

  @override
  Widget build(BuildContext context) => MaterialApp(
        child: Wouter(
          child: SizedBox.shrink(),
          // child: WouterSwitch(
          //   routes: {
          //     '/': (context, arguments) => const SimpleExampleApp(
          //           key: ValueKey('simple-example'),
          //         ),
          //   },
          // ),
        ),
        // routerDelegate: delegate,
        // routeInformationParser: const WouterRouteInformationParser(),
        // backButtonDispatcher: WouterBackButtonDispatcher(
        //   delegate: delegate,
        // ),
      );
}

void main() => runApp(ExampleApp());
