import 'package:flutter/material.dart';
import 'package:wouter/wouter.dart';

class WouterSwitch<T extends Widget> extends StatelessWidget {
  final String? tag;
  final Map<String, WouterRouteBuilder<T>> routes;
  final AnimatedSwitcherTransitionBuilder transitionBuilder;
  final AnimatedSwitcherLayoutBuilder layoutBuilder;
  final Curve switchInCurve;
  final Curve switchOutCurve;
  final Color? background;
  final Widget? fallback;

  const WouterSwitch({
    super.key,
    this.tag,
    required this.routes,
    this.transitionBuilder = defaultTransitionBuilder,
    this.layoutBuilder = AnimatedSwitcher.defaultLayoutBuilder,
    this.switchInCurve = Curves.easeInOut,
    this.switchOutCurve = Curves.easeInOut,
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
    BaseWouter wouter,
    List<T> stack,
  ) =>
      (stack.isEmpty && fallback != null)
          ? fallback!
          : Container(
              color: background ?? Theme.of(context).scaffoldBackgroundColor,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: transitionBuilder,
                layoutBuilder: layoutBuilder,
                switchInCurve: switchInCurve,
                switchOutCurve: switchOutCurve,
                child: Stack(
                  key: ValueKey(stack.length),
                  children: stack,
                ),
              ),
            );

  @override
  Widget build(BuildContext context) => BaseWouterNavigator<T>.builder(
        tag: tag,
        routes: routes,
        builder: _builder,
      );
}
