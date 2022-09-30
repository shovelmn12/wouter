import 'package:flutter/widgets.dart' hide TransitionBuilder;
import 'package:wouter/wouter.dart';

import 'base.dart';

class WouterSwitch extends StatelessWidget {
  final Map<String, WouterRouteBuilder<Widget>> routes;
  final TransitionBuilder? transition;

  const WouterSwitch({
    Key? key,
    required this.routes,
    this.transition,
  }) : super(key: key);

  Widget _builder(
    BuildContext context,
    BaseWouter wouter,
    List<Widget> stack,
  ) =>
      Stack(
        children: stack
            .map((child) => RepaintBoundary(
                  child: Overlay(
                    initialEntries: [
                      OverlayEntry(
                        builder: (context) => transition?.call(context, child) ?? child,
                      )
                    ],
                  ),
                ))
            .toList(),
      );

  @override
  Widget build(BuildContext context) => BaseWouterNavigator<Widget>.builder(
        routes: routes,
        builder: _builder,
      );
}
