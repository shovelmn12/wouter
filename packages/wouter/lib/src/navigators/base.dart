import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

part 'base.builder.dart';

abstract class BaseWouterNavigator<T> extends StatefulWidget {
  final String? tag;
  final Map<String, WouterRouteBuilder<T>> routes;

  const BaseWouterNavigator({
    super.key,
    this.tag,
    required this.routes,
  });

  const factory BaseWouterNavigator.builder({
    Key? key,
    String? tag,
    required Map<String, WouterRouteBuilder<T>> routes,
    required WouterStackBuilder<T> builder,
  }) = BaseWouterNavigatorBuilder;
}

abstract class BaseWouterNavigatorState<T extends BaseWouterNavigator<W>, W>
    extends State<T> {
  final BehaviorSubject<List<StackEntry<W>>> _stackSubject =
      BehaviorSubject.seeded(const []);
  final BehaviorSubject<Map<String, WouterRouteBuilder<W>>> _routesSubject =
      BehaviorSubject.seeded(const {});

  late StreamSubscription<List<StackEntry<W>>> _subscription;

  @protected
  WouterState get parent => context.read<WouterState>();

  late WouterState _prevParent = parent;

  @protected
  Map<String, WouterRouteBuilder<W>> get routes => widget.routes;

  @override
  void initState() {
    _routesSubject.add(routes);
    _subscription = subscribe(parent);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    final parent = this.parent;

    if (_prevParent != parent) {
      _prevParent = parent;
      _subscription.cancel();
      _subscription = subscribe(parent);
    }

    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    if (!const DeepCollectionEquality()
        .equals(oldWidget.routes, widget.routes)) {
      _routesSubject.add(routes);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _dispose();

    super.dispose();
  }

  void _dispose() async {
    await _subscription.cancel();
    await _stackSubject.close();
    await _routesSubject.close();
  }

  @protected
  StreamSubscription<List<StackEntry<W>>> subscribe(WouterState wouter) =>
      Rx.combineLatest2(
        wouter.stream
            .where((stack) => stack.isNotEmpty)
            .map((stack) => stack.last.path)
            .distinct()
            .map(wouter.policy.createStack)
            .distinct(),
        _routesSubject.stream.distinct(),
        (stack, routes) => createStack(wouter.matcher, stack, routes),
      ).distinct().listen(_stackSubject.add);

  @protected
  List<StackEntry<W>> createStack(
    PathMatcher matcher,
    List<String> stack,
    Map<String, WouterRouteBuilder<W>> routes,
  ) {
    final result = stack
        .fold<Pair<List<StackEntry<W>>, Map<String, WouterRouteBuilder<W>?>>>(
      (
        item1: <StackEntry<W>>[],
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

        return (
          item1: List.unmodifiable([
            ...state.item1,
            entry,
          ]),
          item2: Map.unmodifiable({
            ...state.item2,
            entry.key: null,
          }),
        );
      },
    );

    return result.item1;
  }

  @protected
  StackEntry<W>? matchPathToRoute(
    String path,
    PathMatcher matcher,
    List<MapEntry<String, WouterRouteBuilder<W>?>> routes,
  ) {
    for (final entry in routes) {
      final match = matcher(
        path,
        entry.key,
        prefix: false,
      );

      if (match != null) {
        final value = entry.value;

        if (value == null) {
          return null;
        }

        return StackEntry<W>(
          key: entry.key,
          path: match.path,
          builder: value,
          arguments: match.arguments,
        );
      }
    }

    return null;
  }

  @protected
  List<W> buildStack(BuildContext context, List<StackEntry<W>> stack) =>
      stack.map((builder) => builder(context)).toList();

  Widget builder(BuildContext context, List<W> stack);

  @override
  Widget build(BuildContext context) => RepaintBoundary(
        child: StreamBuilder<List<StackEntry<W>>>(
          stream: _stackSubject.distinct(const DeepCollectionEquality().equals),
          builder: (context, snapshot) => builder(
            context,
            buildStack(context, snapshot.data ?? const []),
          ),
        ),
      );
}
