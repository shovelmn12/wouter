import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../base.dart';
import '../extensions/extensions.dart';
import '../models/models.dart';

part 'base.builder.dart';

abstract class BaseWouterNavigator<T> extends StatefulWidget {
  final Map<String, WouterRouteBuilder<T>> routes;

  const BaseWouterNavigator({
    Key? key,
    required this.routes,
  }) : super(key: key);

  const factory BaseWouterNavigator.builder({
    Key? key,
    required Map<String, WouterRouteBuilder<T>> routes,
    required WouterStackBuilder<T> builder,
  }) = BaseWouterNavigatorBuilder;
}

abstract class BaseWouterNavigatorState<T extends BaseWouterNavigator<W>, W>
    extends State<T> {
  @protected
  late BaseWouter wouter = context.wouter;

  @protected
  late Stream<List<StackEntry<W>>> stream = createStream(wouter);

  @protected
  Map<String, WouterRouteBuilder<W>> get routes => widget.routes;

  @override
  void didChangeDependencies() {
    final wouter = context.wouter;

    if (wouter != this.wouter) {
      update(wouter);
    }

    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    if (!const DeepCollectionEquality()
        .equals(oldWidget.routes, widget.routes)) {
      setState(() {});
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    stream = Stream.empty();

    super.dispose();
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
  }

  @protected
  void update(BaseWouter wouter) {
    stream = createStream(wouter);

    this.wouter = wouter;

    setState(() {});
  }

  @protected
  Stream<List<StackEntry<W>>> createStream(BaseWouter wouter) => wouter.stream
      .where((stack) => stack.isNotEmpty)
      .map((stack) => stack.last)
      .distinct()
      .map(wouter.policy.createStack)
      .distinct()
      .map((stack) => onUpdate(wouter.matcher, stack))
      .distinct();

  @protected
  List<StackEntry<W>> onUpdate(PathMatcher matcher, List<String> stack) {
    final result = stack
        .fold<Pair<List<StackEntry<W>>, Map<String, WouterRouteBuilder<W>?>>>(
      Pair(
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
  List<W> buildStack(BuildContext context, List<StackEntry<W>> stack) =>
      stack.map((builder) => builder(context)).toList();

  Widget builder(BuildContext context, List<W> stack);

  @override
  Widget build(BuildContext context) => ClipRect(
        child: RepaintBoundary(
          child: StreamBuilder<List<StackEntry<W>>>(
            stream: stream,
            builder: (context, snapshot) => builder(
              context,
              buildStack(context, snapshot.data ?? const []),
            ),
          ),
        ),
      );
}
