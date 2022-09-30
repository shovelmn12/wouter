import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../base.dart';
import '../extensions/extensions.dart';
import '../models/models.dart';

part 'base.builder.dart';

abstract class BaseWouterNavigator<T> extends StatefulWidget {
  final Map<String, WouterRouteBuilder> routes;

  const BaseWouterNavigator({
    Key? key,
    required this.routes,
  }) : super(key: key);

  const factory BaseWouterNavigator.builder({
    Key? key,
    required Map<String, WouterRouteBuilder> routes,
    required WouterStackBuilder<T> builder,
  }) = BaseWouterNavigatorBuilder;
}

abstract class BaseWouterNavigatorState<T extends BaseWouterNavigator, W> extends State<T> {
  @protected
  late WouterState _parent = context.wouter;

  @protected
  BaseWouter get parent => _parent;

  @protected
  set parent(BaseWouter parent) {
    unsubscribe(parent);

    _parent = parent;

    subscribe(parent);
  }

  List<StackEntry> _stack = const [];

  @protected
  List<StackEntry> get stack => _stack;

  @protected
  set stack(List<StackEntry> stack) {
    final prev = _stack;

    _stack = stack;

    onStackChanged(prev, stack);
  }

  @protected
  Map<String, WouterRouteBuilder> get routes => widget.routes;

  @override
  void initState() {
    subscribe(parent);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    final wouter = context.wouter;

    // if (parent != wouter) {
    //   parent = wouter;
    // }

    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    if (!const DeepCollectionEquality().equals(oldWidget.routes, widget.routes)) {
      _onChange();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    unsubscribe(parent);

    super.dispose();
  }

  @protected
  void subscribe(BaseWouter wouter) {
    wouter.addListener(_onChange);

    _onChange();
  }

  void _onChange() => onChange(parent);

  @protected
  void onChange(BaseWouter wouter) => stack = createStack(
        wouter.matcher,
        wouter.policy.createStack(wouter.path),
      );

  @protected
  void unsubscribe(BaseWouter wouter) => wouter.removeListener(_onChange);

  @protected
  bool shouldNotify(List<StackEntry> prev, List<StackEntry> next) => !const DeepCollectionEquality().equals(
        prev.map((entry) => entry.path),
        next.map((entry) => entry.path),
      );

  @protected
  void onStackChanged(List<StackEntry> prev, List<StackEntry> next) {
    if (shouldNotify(prev, next)) {
      setState(() {});
    }
  }

  @protected
  StackEntry? matchPathToRoute(
    String path,
    PathMatcher matcher,
    List<MapEntry<String, WouterRouteBuilder?>> routes,
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

        return StackEntry(
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
  List<StackEntry> createStack(PathMatcher matcher, List<String> stack) {
    final result = stack.fold<Pair<List<StackEntry>, Map<String, WouterRouteBuilder?>>>(
      Pair(
        item1: <StackEntry>[],
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

        return state.copyWith.call(
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
  List buildStack(BuildContext context, List<StackEntry> stack) =>
      stack.map((builder) => builder(context)).toList();

  Widget builder(BuildContext context, List<StackEntry> stack);

  @override
  Widget build(BuildContext context) => RepaintBoundary(
        child: builder(
          context,
          buildStack(context, stack),
        ),
      );
}
