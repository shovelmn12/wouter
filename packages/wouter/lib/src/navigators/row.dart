import 'package:flutter/material.dart';
import 'package:wouter/wouter.dart';

class WouterRow<T extends Widget> extends StatelessWidget {
  final Map<String, WouterRouteBuilder<T>> routes;

  const WouterRow({
    super.key,
    required this.routes,
  });

  @override
  Widget build(BuildContext context) => BaseWouterNavigator<T>.builder(
        routes: routes,
        builder: (context, delegate, stack) => Row(
          children: stack,
        ),
      );
}
