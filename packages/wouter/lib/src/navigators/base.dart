import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wouter/wouter.dart';

typedef _Entry = (String, WidgetBuilder);

class WouterNavigator extends StatefulWidget {
  final PathMatcher? matcher;
  final Map<String, WouterWidgetBuilder> routes;
  final Widget Function(BuildContext, List<Widget>) builder;
  final String? tag;

  const WouterNavigator({
    super.key,
    this.matcher,
    required this.routes,
    required this.builder,
    this.tag,
  });

  @override
  State<WouterNavigator> createState() => _WouterNavigatorState();
}

class _WouterNavigatorState extends State<WouterNavigator> {
  late final Stream<List<Widget>> _stream = context.wouter.stream
      .map((state) => (state.base, state.stack.map((e) => e.path).toList()))
      .distinct()
      .map((data) => createBuilderStack(
            data.$1,
            widget.matcher ?? context.read<PathMatcher>(),
            data.$2,
            widget.routes,
          ))
      .distinct();

  @override
  void didUpdateWidget(covariant WouterNavigator oldWidget) {
    if (!const DeepCollectionEquality()
        .equals(oldWidget.routes.keys, widget.routes.keys)) {
      setState(() {});
    }

    super.didUpdateWidget(oldWidget);
  }

  @protected
  List<Widget> createBuilderStack(
    String base,
    PathMatcher matcher,
    List<String> stack,
    Map<String, WouterWidgetBuilder> routes,
  ) {
    // print("${widget.tag ?? this} building $stack");

    return stack
        .fold<(List<_Entry>, Map<String, WouterWidgetBuilder?>)>(
          (
            <_Entry>[],
            Map.of(routes),
          ),
          (state, path) {
            final entry = matchPathToRoute(
              path,
              base,
              matcher,
              state.$2.entries.toList(),
            );

            // print(
            //     "${widget.tag ?? this} matching $path found $base${entry?.$1}");

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
        )
        .$1
        .map((entry) => RepaintBoundary(
              child: Builder(
                builder: entry.$2,
              ),
            ))
        .toList();
  }

  @protected
  (String, WidgetBuilder)? matchPathToRoute(
    String path,
    String base,
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
        child: StreamBuilder<List<Widget>>(
          stream: _stream,
          initialData: const [],
          builder: (context, snapshot) => widget.builder(
            context,
            snapshot.requireData,
          ),
        ),
      );
}
