import 'package:flutter/material.dart';
import 'package:wouter/wouter.dart';

class WouterPage extends StatelessWidget {
  final Map<String, Widget> routes;
  final WouterListenableWidgetBuilder<PageController> builder;

  const WouterPage({
    super.key,
    required this.routes,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) => WouterListenable<PageController>(
        create: (context, index) => PageController(
          initialPage: index,
        ),
        dispose: (context, controller) => controller.dispose(),
        index: (controller) => controller.page?.round(),
        onChanged: (controller, index) => controller.animateToPage(
          index,
          duration: const Duration(
            milliseconds: 250,
          ),
          curve: Curves.easeInOut,
        ),
        routes: routes,
        builder: builder,
        toIndex: (base, path, routes) {
          final result = routes.indexWhere((route) {
            if (route == "/") {
              return path == "/";
            }

            final result = path.startsWith(route);

            return result;
          });

          if (result < 0) {
            return null;
          }

          return result;
        },
        toPath: (index, base, path, routes) {
          final route = routes[index];

          if (path == "$base$route" || path.startsWith("$base$route")) {
            return null;
          }

          return "$base$route";
        },
      );
}
