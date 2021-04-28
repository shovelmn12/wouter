import 'package:flutter/material.dart';
import 'package:wouter/wouter.dart';

import 'base.dart';

class WouterSwitch<T extends Page> extends WouterBaseNavigator<T> {
  final List<NavigatorObserver> observers;
  final TransitionDelegate transition;

  const WouterSwitch({
    Key? key,
    required Map<String, WouterRouteBuilder<T>> routes,
    this.observers = const [],
    this.transition = const DefaultTransitionDelegate(),
  }) : super(
          key: key,
          routes: routes,
        );

  @override
  WouterSwitchState<T> createState() => WouterSwitchState<T>();
}

class WouterSwitchState<T extends Page>
    extends WouterBaseNavigatorState<WouterSwitch<T>, T> {
  @override
  Widget builder(BuildContext context, List<T> stack) => stack.isEmpty
      ? const SizedBox.shrink()
      : Navigator(
          pages: [
            if (delegate.canPop)
              const MaterialPage(
                child: SizedBox.shrink(),
              ),
            ...stack,
          ],
          observers: widget.observers,
          transitionDelegate: widget.transition,
          onPopPage: (route, result) {
            final result = delegate.pop();

            route.didPop(result);

            return result;
          },
        );
}
