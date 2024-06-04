import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

part 'base.wouter.dart';

typedef WouterRoutes = Map<String, WouterWidgetBuilder>;

typedef WouterStackBuilder = Widget Function(BuildContext, List<Widget>);

typedef WouterEntryBuilder = Widget Function(WidgetBuilder);

typedef _Entry = ({
  String key,
  List<RouteEntry> stack,
  WidgetBuilder builder,
});

typedef _EntryMatch = ({
  String key,
  WidgetBuilder builder,
});

class WouterNavigator extends StatelessWidget {
  final PathMatcher? matcher;
  final WouterRoutes routes;
  final WouterStackBuilder builder;
  final WouterEntryBuilder entryBuilder;

  const WouterNavigator({
    super.key,
    this.matcher,
    required this.routes,
    required this.builder,
    this.entryBuilder = defaultEntryBuilder,
  });

  static Widget defaultEntryBuilder(WidgetBuilder builder) => RepaintBoundary(
        child: Builder(
          builder: builder,
        ),
      );

  @override
  Widget build(BuildContext context) => _WouterNavigator(
        matcher: matcher,
        routes: routes,
        builder: builder,
        entryBuilder: entryBuilder,
      );
}

class _WouterNavigator extends StatefulWidget {
  final PathMatcher? matcher;
  final WouterRoutes routes;
  final WouterStackBuilder builder;
  final WouterEntryBuilder entryBuilder;

  const _WouterNavigator({
    required this.matcher,
    required this.routes,
    required this.builder,
    required this.entryBuilder,
  });

  @override
  State<_WouterNavigator> createState() => _WouterNavigatorState();
}

class _WouterNavigatorState extends State<_WouterNavigator> {
  late final Stream<List<Widget>> _stream = Rx.combineLatest2(
    context.wouter.stream.distinct().distinct((prev, next) =>
        const DeepCollectionEquality().equals(
          prev.stack.map((e) => e.path).toList(),
          next.stack.map((e) => e.path).toList(),
        ) &&
        prev.base != next.base),
    _routes.map(
      (routes) => List<MapEntry<String, WouterWidgetBuilder>>.unmodifiable(
        widget.routes.entries,
      ),
    ),
    (state, routes) => _createStackN(
      widget.matcher ?? context.read<PathMatcher>(),
      state,
      routes,
    ),
  );

  late final BehaviorSubject<WouterRoutes> _routes =
      BehaviorSubject.seeded(widget.routes);

  @override
  void didUpdateWidget(covariant _WouterNavigator oldWidget) {
    if (!const DeepCollectionEquality()
        .equals(oldWidget.routes.keys, widget.routes.keys)) {
      _routes.add(widget.routes);
    }

    super.didUpdateWidget(oldWidget);
  }

  List<Widget> _createStackN(
    PathMatcher matcher,
    WouterState state,
    List<MapEntry<String, WouterWidgetBuilder>> routes,
  ) =>
      state.stack
          .fold<List<_Entry>>(
            const <_Entry>[],
            (stack, entry) {
              final last = stack.lastOrNull;

              final (key: key, builder: builder) = _matchPathToRouteN(
                entry.path,
                matcher,
                routes,
              );

              return List<_Entry>.unmodifiable(
                last != null && last.key == key
                    ? [
                        if (stack.length > 1) ...stack.sublist(0, stack.length),
                        (
                          key: key,
                          stack: List<RouteEntry>.unmodifiable([
                            ...last.stack,
                            entry,
                          ]),
                          builder: builder,
                        ),
                      ]
                    : [
                        ...stack,
                        (
                          key: key,
                          stack: List<RouteEntry>.unmodifiable([
                            entry,
                          ]),
                          builder: builder,
                        )
                      ],
              );
            },
          )
          .map((entry) => widget.entryBuilder(
                (context) => Provider(
                  create: (context) => _WouterStateStreamableImpl(
                    source: Stream.value(WouterState(
                      stack: entry.stack,
                      canPop: state.canPop,
                      base: state.base,
                    )),
                  ),
                  child: Builder(
                    builder: entry.builder,
                  ),
                ),
              ))
          .toList();

  _EntryMatch _matchPathToRouteN(
    String path,
    PathMatcher matcher,
    List<MapEntry<String, WouterWidgetBuilder>> routes,
  ) {
    for (final entry in routes) {
      final match = matcher(
        path,
        entry.key,
        prefix: false,
      );

      if (match != null) {
        return (
          key: entry.key,
          builder: (context) => entry.value(context, match.arguments),
        );
      }
    }

    throw Exception("Route not found for $path");
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
