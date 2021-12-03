import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wouter/wouter.dart';

import '../base.dart';

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

  String popPath(String path) {
    final parts = path.split('/');
    final newPath = parts.sublist(0, parts.length - 1).join('/');

    if (newPath.isNotEmpty) {
      return newPath;
    }

    return "/";
  }

  List<String> breakPath(String path) {
    if (path.isEmpty || path == "/") {
      return [
        "/",
      ];
    }

    return [
      ...breakPath(popPath(path)),
      path,
    ];
  }

  @protected
  List<StackEntry<W>> matchPathToRoutes(
    String path,
    PathMatcher matcher,
    Iterable<MapEntry<String, WouterRouteBuilder<W>>> routes,
  ) {
    final result = breakPath(path).map((path) {
      for (final entry in routes) {
        final match = matcher(
          path,
          entry.key,
          prefix: false,
        );

        if (match != null) {
          // print("$path -> ${entry.key}");
          return StackEntry<W>(
            path: match.path,
            builder: entry.value,
            arguments: match.arguments,
          );
        }
      }
    }).whereType<StackEntry<W>>();

    return result.fold(
      <StackEntry<W>>[],
      (List<StackEntry<W>> acc, StackEntry<W> element) {
        if (acc.map((entry) => entry.path).contains(element.path)) {
          return acc;
        }

        return [
          ...acc,
          element,
        ];
      },
    );
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
      .map((route) => onUpdate(wouter.matcher, route))
      .distinct();

  @protected
  List<StackEntry<W>> onUpdate(PathMatcher matcher, String route) =>
      matchPathToRoutes(
        route,
        matcher,
        routes.entries.toList(),
      );

  @protected
  List<W> buildStack(BuildContext context, List<StackEntry<W>> stack) =>
      stack.map((builder) => builder(context)).toList();

  Widget builder(BuildContext context, bool notFound, List<W> stack);

  @override
  Widget build(BuildContext context) => ClipRect(
        child: RepaintBoundary(
          child: StreamBuilder<List<StackEntry<W>>>(
            stream: stream,
            builder: (context, snapshot) => builder(
              context,
              snapshot.data?.isEmpty ?? false,
              buildStack(context, snapshot.data ?? const []),
            ),
          ),
        ),
      );
}
