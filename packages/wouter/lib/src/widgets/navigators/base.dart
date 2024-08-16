import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

typedef WouterRoutes = Map<String, WouterWidgetBuilder>;

typedef WouterStackBuilder = Widget Function(BuildContext, List<Widget>);

typedef WouterEntryBuilder = Widget Function(WidgetBuilder);

typedef _Entry = ({
  String key,
  WouterState state,
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

class WouterNavigatorState extends State<WouterNavigator>
    with WouterParentMixin {
  late final _base = Rx.combineLatest2(
    wouter.distinct(
      (prev, next) =>
          const DeepCollectionEquality().equals(
            prev.stack.map((e) => e.path).toList(),
            next.stack.map((e) => e.path).toList(),
          ) &&
          prev.base != next.base,
    ),
    _routes.distinct(),
    (state, routes) => _createEntries(
      widget.matcher ?? context.read<PathMatcher>(),
      state,
      routes,
    ),
  ).distinct().publishValue().autoConnect();

  late final _stream = _base
      .distinct((prev, next) => const DeepCollectionEquality().equals(
            prev.map((e) => e.key),
            next.map((e) => e.key),
          ))
      .map((entries) => entries
          .mapIndexed((index, route) => widget.entryBuilder(
                (context) => Provider(
                  key: ValueKey('${route.key}-$index'),
                  create: (context) => WouterStateStreamable(
                    source: _base
                        .where((entries) => entries.length > index)
                        .map((entries) => entries[index])
                        .map((entry) => entry.state),
                    state: route.state,
                  ),
                  dispose: (context, streamable) => streamable.dispose(),
                  child: Builder(
                    builder: (context) => StreamBuilder<_EntryMatch>(
                      stream: Rx.combineLatest2(
                        context.wouter.stream
                            .mapNotNull((state) => state.stack.lastOrNull)
                            .distinct(),
                        _routes,
                        (entry, routes) => _matchPathToRoute(
                          entry.path,
                          widget.matcher ?? context.read<PathMatcher>(),
                          routes,
                        )!,
                      ),
                      initialData: _matchPathToRoute(
                        context.wouter.state.stack.last.path,
                        widget.matcher ?? context.read<PathMatcher>(),
                        _routes.value,
                      )!,
                      builder: (context, snapshot) =>
                          snapshot.requireData.builder(context),
                    ),
                  ),
                ),
              ))
          .toList());

  late final StreamSubscription<List<Widget>> _subscription;

  late final BehaviorSubject<List<Widget>> _stack = BehaviorSubject();

  late final BehaviorSubject<List<MapEntry<String, WouterWidgetBuilder>>>
      _routes = BehaviorSubject.seeded(
    List<MapEntry<String, WouterWidgetBuilder>>.unmodifiable(
      widget.routes.entries,
    ),
  );

  @override
  void initState() {
    _subscription = _stream.listen(_stack.add);

    super.initState();
  }

  @override
  void didUpdateWidget(covariant WouterNavigator oldWidget) {
    if (!const DeepCollectionEquality()
        .equals(oldWidget.routes.keys, widget.routes.keys)) {
      _routes.add(List<MapEntry<String, WouterWidgetBuilder>>.unmodifiable(
        widget.routes.entries,
      ));
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _subscription.cancel();
    _stack.close();
    _routes.close();

    super.dispose();
  }

  List<_Entry> _createEntries(
    PathMatcher matcher,
    WouterState state,
    List<MapEntry<String, WouterWidgetBuilder>> routes,
  ) =>
      state.stack.fold<List<_Entry>>(
        const <_Entry>[],
        (stack, entry) {
          final last = stack.lastOrNull;

          final match = _matchPathToRoute(
            entry.path,
            matcher,
            routes,
          );

          if (match == null) {
            return stack;
          }

          final (key: key, builder: builder) = match;

          return List<_Entry>.unmodifiable(
            last != null && last.key == key
                ? [
                    if (stack.length > 1) ...stack.sublist(0, stack.length - 1),
                    (
                      key: key,
                      state: WouterState(
                        stack: List<RouteEntry>.unmodifiable([
                          ...last.state.stack,
                          entry,
                        ]),
                        canPop: state.canPop,
                        base: state.base,
                      ),
                    ),
                  ]
                : [
                    ...stack,
                    (
                      key: key,
                      state: WouterState(
                        stack: List<RouteEntry>.unmodifiable([
                          entry,
                        ]),
                        canPop: state.canPop,
                        base: state.base,
                      ),
                    )
                  ],
          );
        },
      );

  _EntryMatch? _matchPathToRoute(
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

    return null;
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
