import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wouter/wouter.dart';

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
  List<StackItem<W>> stack = const [];

  @protected
  late WouterState wouter = context.wouter;

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

    super.dispose();
  }

  @protected
  StackItem<W>? matchPathToRoute(
    String path,
    PathMatcher matcher,
    Iterable<MapEntry<String, WouterRouteBuilder<W>>> routes,
  ) {
    for (final entry in routes) {
      final match = matcher(path, entry.key);

      if (match != null) {
        return StackItem<W>(
          path: match.path,
          builder: entry.value,
          arguments: match.arguments,
        );
      }
    }
  }

  @protected
  void update(WouterState wouter) {
    this.wouter.removeListener(onDelegateUpdated);

    init(wouter);
  }

  @protected
  void onDelegateUpdated() => setState(() => stack = onUpdate(wouter));

  @protected
  void init(WouterState wouter) {
    wouter.addListener(onDelegateUpdated);

    this.wouter = wouter;
  }

  @protected
  List<StackItem<W>> onUpdate(WouterState wouter) => wouter.stack
      .map((route) => matchPathToRoute(
            route,
            wouter.matcher,
            routes.entries.toList(),
          ))
      .where((item) => item != null)
      .toList()
      .cast();

  @protected
  List<W> buildStack(BuildContext context, List<StackItem<W>> stack) =>
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
