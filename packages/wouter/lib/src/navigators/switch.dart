import 'package:flutter/material.dart';
import 'package:wouter/wouter.dart';

import 'base.dart';

class WouterSwitch<T extends Page> extends StatelessWidget {
  final Map<String, WouterRouteBuilder<T>> routes;
  final List<NavigatorObserver> observers;
  final TransitionDelegate transition;

  const WouterSwitch({
    Key? key,
    required this.routes,
    this.observers = const [],
    this.transition = const DefaultTransitionDelegate(),
  }) : super(key: key);

  Widget _builder(
    BuildContext context,
    WouterBaseRouterDelegate delegate,
    List<T> stack,
  ) =>
      stack.isEmpty
          ? const SizedBox.shrink()
          : Navigator(
              pages: [
                if (delegate.canPop)
                  const MaterialPage(
                    child: SizedBox.shrink(),
                  ),
                ...stack,
              ],
              observers: observers,
              transitionDelegate: transition,
              onPopPage: (route, result) {
                final result = delegate.pop();

                route.didPop(result);

                return result;
              },
            );

  @override
  Widget build(BuildContext context) => BaseWouterNavigator<T>.builder(
        routes: routes,
        builder: _builder,
      );
}
