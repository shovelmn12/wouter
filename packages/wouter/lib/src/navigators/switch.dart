import 'package:flutter/material.dart';
import 'package:wouter/wouter.dart';

class WouterSwitch extends StatelessWidget {
  final Map<String, WouterWidgetBuilder> routes;
  final Color? background;
  final Widget? fallback;
  final String? tag;

  const WouterSwitch({
    super.key,
    required this.routes,
    this.background,
    this.fallback,
    this.tag,
  });

  Widget _builder(
    BuildContext context,
    List<Widget> stack,
  ) {
    if (stack.isEmpty && fallback != null) {
      return fallback!;
    }

    return Container(
      color: background ?? Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        alignment: Alignment.center,
        children: stack,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => WouterNavigator(
        routes: routes,
        builder: _builder,
        tag: tag,
      );
}
