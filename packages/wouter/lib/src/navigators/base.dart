import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
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

class WouterNavigator extends StatefulWidget {
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
  State<WouterNavigator> createState() => WouterNavigatorState();
}

class WouterNavigatorState extends State<WouterNavigator> {
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
    (state, routes) => _createStack(
      widget.matcher ?? context.read<PathMatcher>(),
      state,
      routes,
    ),
  ).distinct();

  late final StreamSubscription<List<Widget>> _subscription;

  late final BehaviorSubject<List<Widget>> _stack =
      BehaviorSubject.seeded(_createStack(
    widget.matcher ?? context.read<PathMatcher>(),
    context.wouter.state,
    List<MapEntry<String, WouterWidgetBuilder>>.unmodifiable(
      widget.routes.entries,
    ),
  ));

  late final BehaviorSubject<WouterRoutes> _routes =
      BehaviorSubject.seeded(widget.routes);

  @override
  void initState() {
    _subscription = _stream.listen(_stack.add);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant WouterNavigator oldWidget) {
    if (!const DeepCollectionEquality()
        .equals(oldWidget.routes.keys, widget.routes.keys)) {
      _routes.add(widget.routes);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    // properties.add(DiagnosticsProperty(
    //   "stack",
    //   _stack,
    // ));

    super.debugFillProperties(properties);
  }

  @override
  void dispose() {
    _subscription.cancel();
    _stack.close();
    _routes.close();

    super.dispose();
  }

  List<Widget> _createStack(
    PathMatcher matcher,
    WouterState state,
    List<MapEntry<String, WouterWidgetBuilder>> routes,
  ) =>
      state.stack
          .fold<List<_Entry>>(
            const <_Entry>[],
            (stack, entry) {
              final last = stack.lastOrNull;

              final (key: key, builder: builder) = _matchPathToRoute(
                entry.path,
                matcher,
                routes,
              );

              return List<_Entry>.unmodifiable(
                last != null && last.key == key
                    ? [
                        if (stack.length > 1)
                          ...stack.sublist(0, stack.length - 1),
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
                    state: WouterState(
                      stack: entry.stack,
                      canPop: state.canPop,
                      base: state.base,
                    ),
                  ),
                  lazy: false,
                  child: Builder(
                    builder: entry.builder,
                  ),
                ),
              ))
          .toList();

  _EntryMatch _matchPathToRoute(
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
          stream: _stack,
          initialData: const [],
          builder: (context, snapshot) => widget.builder(
            context,
            snapshot.requireData,
          ),
        ),
      );
}
