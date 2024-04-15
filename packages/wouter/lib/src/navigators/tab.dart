import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

typedef WouterTabWidgetBuilder = Widget Function(
  BuildContext,
  TabController,
  List<Widget>,
);

class StartsWithEquality implements Equality<String> {
  const StartsWithEquality();

  @override
  bool equals(String? e1, String? e2) =>
      (e1 == null || e2 == null) ? false : e1.startsWith(e2);

  @override
  int hash(String? e) => e.hashCode;

  @override
  bool isValidKey(Object? o) => true;
}

class WouterTab extends StatefulWidget {
  final Map<String, Widget> routes;
  final WouterTabWidgetBuilder builder;
  final int fallback;
  final Equality<String> equals;

  const WouterTab({
    super.key,
    required this.routes,
    required this.builder,
    this.fallback = 0,
    this.equals = const StartsWithEquality(),
  });

  @override
  State<WouterTab> createState() => _WouterTabState();
}

class _WouterTabState extends State<WouterTab>
    with SingleTickerProviderStateMixin {
  final _subscription = CompositeSubscription();

  late final _controller = TabController(
    length: widget.routes.length,
    vsync: this,
  );

  @override
  void initState() {
    _subscription.add(_controller
        .toStream<TabController>()
        .map((controller) => controller.index)
        .distinct()
        .map((index) => _indexToPath(index, widget.routes.keys.toList()))
        .distinct()
        .withLatestFrom(context.wouter.stream.map((state) => state.base),
            (path, base) => "$base$path")
        .listen(context.wouter.actions.replace));

    _subscription.add(context.wouter.stream
        .map((state) => state.path)
        .where((path) => path.isNotEmpty)
        .distinct()
        .map((path) => _pathToIndex(
              path,
              widget.routes.keys.toList(),
              widget.fallback,
            ))
        .distinct()
        .listen((index) => _controller.animateTo(index)));

    super.initState();
  }

  String _indexToPath(int index, List<String> paths) => paths[index];

  int _pathToIndex(
    String path,
    List<String> paths,
    int fallback,
  ) {
    final result =
        paths.indexWhere((element) => widget.equals.equals(path, element));

    if (result < 0) {
      return fallback;
    }

    return result;
  }

  @override
  void dispose() {
    _subscription.dispose();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(
        context,
        _controller,
        widget.routes.values.toList(),
      );
}

extension _ListenableStreamExtension on Listenable {
  Stream<T> toStream<T extends Listenable>() {
    late final StreamController<T> controller;

    onChange() => controller.add(this as T);

    controller = StreamController<T>(
      onListen: () {
        addListener(onChange);
        onChange();
      },
      onCancel: () => removeListener(onChange),
    );

    return controller.stream;
  }
}
