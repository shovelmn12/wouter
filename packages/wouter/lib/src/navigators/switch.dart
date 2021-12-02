import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wouter/wouter.dart';

import '../base.dart';
import 'base.dart';

typedef Widget? RouteNotFoundCallback<T>(
  BuildContext context,
  BaseWouter wouter,
);

class WouterSwitch<T extends Page> extends StatelessWidget {
  final Map<String, WouterRouteBuilder<T>> routes;
  final List<NavigatorObserver> observers;
  final TransitionDelegate<T> transition;
  final RouteNotFoundCallback<T>? onNotFound;

  const WouterSwitch({
    Key? key,
    required this.routes,
    this.observers = const [],
    this.transition = const DefaultTransitionDelegate(),
    this.onNotFound,
  }) : super(key: key);

  Widget _builder(
    BuildContext context,
    BaseWouter wouter,
    bool notFound,
    List<T> stack,
  ) =>
      stack.isEmpty
          ? ((notFound ? onNotFound?.call(context, wouter) : null) ??
              const SizedBox.shrink())
          : Navigator(
              pages: stack,
              observers: observers,
              transitionDelegate: transition,
              onPopPage: (route, result) {
                final result = wouter.pop();

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
