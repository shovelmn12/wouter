import 'dart:async';

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
  bool _isDisposed = false;

  bool get isDisposed => _isDisposed;

  @protected
  List<StackEntry<W>> stack = const [];

  @protected
  late BaseWouter wouter = context.wouter;

  @protected
  late StreamSubscription<List<StackEntry<W>>> subscription;

  @protected
  Map<String, WouterRouteBuilder<W>> get routes => widget.routes;

  @override
  void initState() {
    init(wouter);

    super.initState();
  }

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
  void setState(VoidCallback fn) {
    if (isDisposed) {
      return;
    }

    super.setState(fn);
  }

  @override
  void dispose() {
    _isDisposed = true;
    subscription.cancel();

    super.dispose();
  }

  @protected
  List<StackEntry<W>> matchPathToRoutes(
    String path,
    PathMatcher matcher,
    Iterable<MapEntry<String, WouterRouteBuilder<W>>> routes,
  ) {
    return routes
        .map((entry) {
          final match = matcher(path, entry.key);

          if (match != null) {
            return StackEntry<W>(
              path: match.path,
              builder: entry.value,
              arguments: match.arguments,
            );
          }
        })
        .whereType<StackEntry<W>>()
        .toList();
  }

  @protected
  void update(BaseWouter wouter) {
    subscription.cancel();

    init(wouter);
  }

  @protected
  void init(BaseWouter wouter) {
    subscription = wouter.stream
        .where((stack) => stack.isNotEmpty)
        .map((stack) => stack.last)
        .distinct()
        .map((route) => onUpdate(wouter.matcher, route))
        .distinct()
        .listen((stack) => setState(() => this.stack = stack));

    this.wouter = wouter;
  }

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

  Widget builder(BuildContext context, List<W> stack);

  @override
  Widget build(BuildContext context) => ClipRect(
        child: RepaintBoundary(
          child: builder(
            context,
            buildStack(context, stack),
          ),
        ),
      );
}
