import 'package:flutter/material.dart';
import 'package:wouter/wouter.dart';

import 'base.dart';

class WouterSwitch<T extends Widget> extends StatelessWidget {
  final Map<String, WouterRouteBuilder<T>> routes;

  const WouterSwitch({
    Key? key,
    required this.routes,
  }) : super(key: key);

  Widget _builder(BuildContext context,
      BaseWouter wouter,
      List<T> stack,) =>
      stack.isEmpty
          ? const SizedBox.shrink()
          : Stack(
        children: stack,
      );

  @override
  Widget build(BuildContext context) =>
      BaseWouterNavigator<T>.builder(
        routes: routes,
        builder: _builder,
      );
}
