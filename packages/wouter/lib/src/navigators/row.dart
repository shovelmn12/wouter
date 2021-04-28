import 'package:flutter/material.dart';
import 'package:wouter/wouter.dart';

import 'base.dart';

class WouterRow<T extends Widget> extends StatelessWidget {
  final Map<String, WouterRouteBuilder<T>> routes;

  const WouterRow({
    Key? key,
    required this.routes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BaseWouterNavigator<T>.builder(
        routes: routes,
        builder: (context, delegate, stack) => Row(
          children: stack,
        ),
      );
}
