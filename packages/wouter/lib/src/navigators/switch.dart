import 'package:flutter/material.dart';
import 'package:wouter/wouter.dart';

class WouterSwitch extends StatelessWidget {
  final String? tag;
  final Map<String, WouterWidgetBuilder> routes;
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
    List<WidgetBuilder> stack,
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
                  children: stack
                      .map((builder) => Builder(
                            builder: builder,
                          ))
                      .toList(),
                ),
              ),
            );

  @override
  Widget build(BuildContext context) => WouterNavigator(
        // tag: tag,
        routes: routes,
        builder: _builder,
      );
}
