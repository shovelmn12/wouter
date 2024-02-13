import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wouter/wouter.dart';

typedef _Entry = (String, WidgetBuilder);

class WouterNavigator extends StatefulWidget {
  final PathMatcher? matcher;
  final Map<String, WouterWidgetBuilder> routes;
  final Widget Function(BuildContext, List<WidgetBuilder>) builder;

  const WouterNavigator({
    super.key,
    this.matcher,
    required this.routes,
    required this.builder,
  });

  @override
  State<WouterNavigator> createState() => _WouterNavigatorState();
}

class _WouterNavigatorState extends State<WouterNavigator> {
  late final Stream<List<_Entry>> _stream = context.wouter.stream
      .map((state) => state.stack.map((e) => e.path).toList())
      .distinct()
      .map((stack) => createBuilderStack(
            widget.matcher ?? context.read<PathMatcher>(),
            stack,
            widget.routes,
          ))
      .distinct();

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
        create: (context) => widget.matcher ?? context.read<PathMatcher>(),
        child: StreamBuilder<List<_Entry>>(
          stream: _stream,
          initialData: const [],
          builder: (context, snapshot) => widget.builder(
            context,
            snapshot.requireData.map((e) => e.$2).toList(),
          ),
        ),
      );
}
