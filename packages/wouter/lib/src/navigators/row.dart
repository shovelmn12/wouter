import 'package:flutter/material.dart';
import 'package:wouter/wouter.dart';

import 'base.dart';

class WouterRow<T extends Widget> extends WouterBaseNavigator<T> {
  const WouterRow({
    Key? key,
    required Map<String, WouterRouteBuilder<T>> routes,
  }) : super(
          key: key,
          routes: routes,
        );

  @override
  WouterRowState<T> createState() => WouterRowState<T>();
}

class WouterRowState<T extends Widget>
    extends WouterBaseNavigatorState<WouterRow<T>, T> {
  @override
  Widget builder(BuildContext context, List<T> stack) => Row(
        children: stack,
      );
}
