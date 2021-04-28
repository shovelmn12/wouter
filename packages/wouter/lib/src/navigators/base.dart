import 'package:flutter/material.dart';
import 'package:wouter/wouter.dart';

abstract class WouterBaseNavigator<T> extends StatefulWidget {
  final Map<String, WouterRouteBuilder<T>> routes;

  const WouterBaseNavigator({
    Key? key,
    required this.routes,
  }) : super(key: key);
}

abstract class WouterBaseNavigatorState<T extends WouterBaseNavigator<W>, W>
    extends State<T> {
  bool _isDisposed = false;

  bool get isDisposed => _isDisposed;

  @protected
  List<StackItem<W>> stack = const [];

  @protected
  late WouterBaseRouterDelegate delegate;

  Map<String, WouterRouteBuilder<W>> get routes => widget.routes;

  @override
  void initState() {
    init(context.wouter);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (context.wouter != delegate) {
      update(context.wouter);
    }

    super.didChangeDependencies();
  }

  @override
  void setState(fn) {
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
  void init(WouterBaseRouterDelegate delegate) {
    this.delegate = delegate;

    delegate.addListener(onDelegateUpdated);

    stack = onUpdate(delegate);
  }

  @protected
  void update(WouterBaseRouterDelegate delegate) {
    this.delegate.removeListener(onDelegateUpdated);

    init(delegate);
  }

  @protected
  void onDelegateUpdated() {
    stack = onUpdate(delegate);

    setState(() {});
  }

  @protected
  List<StackItem<W>> onUpdate(WouterBaseRouterDelegate delegate) =>
      delegate.state.route?.stack
          .map((route) => matchPathToRoute(
                route,
                delegate.matcher,
                routes.entries.toList(),
              ))
          .where((item) => item != null)
          .toList()
          .cast() ??
      const [];

  @protected
  List<W> buildStack(BuildContext context, List<StackItem<W>> stack) =>
      stack.map((builder) => builder(context)).toList();

  @protected
  Widget builder(BuildContext context, List<W> stack);

  @override
  Widget build(BuildContext context) => builder(
        context,
        buildStack(context, stack),
      );
}
