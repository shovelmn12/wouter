import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wouter/wouter.dart';

typedef _Entry = (String, WidgetBuilder);

class WouterNavigator extends StatelessWidget {
  final PathMatcher? matcher;
  final Map<String, WouterWidgetBuilder> routes;
  final Widget Function(BuildContext, List<WidgetBuilder>) builder;

  const WouterNavigator({
    super.key,
    this.matcher,
    required this.routes,
    required this.builder,
  });

  @protected
  List<_Entry> createBuilderStack(
    PathMatcher matcher,
    List<String> stack,
    Map<String, WouterWidgetBuilder> routes,
  ) =>
      stack.fold<(List<_Entry>, Map<String, WouterWidgetBuilder?>)>(
        (
          <_Entry>[],
          Map.of(routes),
        ),
        (state, path) {
          final entry = matchPathToRoute(
            path,
            matcher,
            state.$2.entries.toList(),
          );

          if (entry == null) {
            return state;
          }

          final (key, builder) = entry;

          return (
            List<_Entry>.unmodifiable([
              ...state.$1,
              (path, builder),
            ]),
            Map<String, WouterWidgetBuilder?>.unmodifiable({
              ...state.$2,
              key: null,
            }),
          );
        },
      ).$1;

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
  Widget build(BuildContext context) => Provider<PathMatcher>(
        create: (context) => matcher ?? context.read<PathMatcher>(),
        child: ProxyProvider<WouterState, List<_Entry>>(
          key: ObjectKey(routes),
          update: (context, state, prev) {
            final stack = state.stack.map((e) => e.path).toList();

            if (prev != null) {
              final current = prev.map((e) => e.$1).toList();

              if (const DeepCollectionEquality().equals(stack, current)) {
                return prev;
              }
            }

            return createBuilderStack(
              context.read<PathMatcher>(),
              stack,
              routes,
            );
          },
          updateShouldNotify: (prev, next) =>
              !const DeepCollectionEquality().equals(
            prev.map((e) => e.$1),
            next.map((e) => e.$1),
          ),
          child: Builder(
            builder: (context) => builder(
              context,
              context.watch<List<_Entry>>().map((e) => e.$2).toList(),
            ),
          ),
        ),
      );
}
