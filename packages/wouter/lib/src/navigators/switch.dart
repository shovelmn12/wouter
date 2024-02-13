import 'package:flutter/material.dart';
import 'package:wouter/wouter.dart';

class WouterSwitch extends StatelessWidget {
  final Map<String, WouterWidgetBuilder> routes;
  final Color? background;
  final Widget? fallback;

  const WouterSwitch({
    super.key,
    required this.routes,
    this.background,
    this.fallback,
  });

  static Widget defaultTransitionBuilder(
    Widget child,
    Animation<double> animation,
  ) =>
      FadeTransition(
        opacity: animation,
        child: child,
      );

  Widget _builder(
    BuildContext context,
    List<WidgetBuilder> stack,
  ) {
    if (stack.isEmpty && fallback != null) {
      return fallback!;
    }

    return Container(
      color: background ?? Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        alignment: Alignment.center,
        children: stack
            .map((builder) => RepaintBoundary(
                  child: Builder(
                    builder: builder,
                  ),
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => WouterNavigator(
        key: ObjectKey(routes),
        routes: routes,
        builder: _builder,
      );
}
