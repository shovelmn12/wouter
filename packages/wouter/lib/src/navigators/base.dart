import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wouter/wouter.dart';

class WouterNavigator extends StatelessWidget {
  final Map<String, WouterWidgetBuilder> routes;
  final Widget Function(BuildContext, List<WidgetBuilder>) builder;

  const WouterNavigator({
    super.key,
    required this.routes,
    required this.builder,
  });

  @protected
  List<WidgetBuilder> createBuilderStack(
    PathMatcher matcher,
    List<String> stack,
    Map<String, WouterWidgetBuilder> routes,
  ) =>
      stack.fold<Pair<List<WidgetBuilder>, Map<String, WouterWidgetBuilder?>>>(
        (
          item1: <WidgetBuilder>[],
          item2: Map.of(routes),
        ),
        (state, path) {
          final entry = matchPathToRoute(
            path,
            matcher,
            state.item2.entries.toList(),
          );

          if (entry == null) {
            return state;
          }

          final (key, builder) = entry;

          return (
            item1: List.unmodifiable([
              ...state.item1,
              builder,
            ]),
            item2: Map.unmodifiable({
              ...state.item2,
              key: null,
            }),
          );
        },
      ).item1;

  @protected
  (String, WidgetBuilder)? matchPathToRoute(
    String path,
    PathMatcher matcher,
    List<MapEntry<String, WouterWidgetBuilder?>> routes,
  ) {
    for (final entry in routes) {
      final match = matcher(
        path,
        entry.key,
        prefix: false,
      );

      if (match != null) {
        final builder = entry.value;

        if (builder == null) {
          return null;
        }

        return (
          entry.key,
          (context) => builder(context, match.arguments),
        );
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) =>
      ProxyProvider<WouterState, List<WidgetBuilder>>(
        key: ObjectKey(routes),
        update: (context, state, prev) => createBuilderStack(
          state.matcher,
          state.stack.map((e) => e.path).toList(),
          routes,
        ),
        updateShouldNotify: (prev, next) => true,
        child: Builder(
          builder: (context) => builder(
            context,
            context.watch<List<WidgetBuilder>>(),
          ),
        ),
      );
}
