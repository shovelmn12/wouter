import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:wouter/wouter.dart';

import 'equality/equality.dart';

class WouterPage extends StatelessWidget {
  final Map<String, Widget> routes;
  final WouterListenableWidgetBuilder<PageController> builder;
  final Equality<String> equals;

  const WouterPage({
    super.key,
    required this.routes,
    required this.builder,
    this.equals = const StartsWithEquality(),
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
        equals: equals,
        builder: builder,
      );
}
