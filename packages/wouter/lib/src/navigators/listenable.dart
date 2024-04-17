import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

import 'equality/equality.dart';

typedef WouterListenableWidgetBuilder<T> = Widget Function(
  BuildContext,
  T,
  List<Widget>,
);

typedef CreateListenable<T> = T Function(BuildContext, int);

typedef DisposeListenable<T> = void Function(BuildContext, T);

typedef OnGetListenableIndex<T> = int? Function(T);

typedef OnRouteChanged<T> = void Function(T, int);

class WouterListenable<T extends Listenable> extends StatefulWidget {
  final CreateListenable<T> create;
  final DisposeListenable<T> dispose;
  final OnGetListenableIndex<T> index;
  final OnRouteChanged<T> onChanged;
  final Map<String, Widget> routes;
  final WouterListenableWidgetBuilder<T> builder;
  final Equality<String> equals;

  const WouterListenable({
    super.key,
    required this.create,
    required this.dispose,
    required this.index,
    required this.onChanged,
    required this.routes,
    required this.builder,
    this.equals = const StartsWithEquality(),
  });

  @override
  State<WouterListenable<T>> createState() => _WouterListenableState<T>();
}

class _WouterListenableState<T extends Listenable>
    extends State<WouterListenable<T>> {
  final _subscription = CompositeSubscription();

  late final T _listenable = widget.create(
    context,
    _pathToIndex(
          context.wouter.state.path,
          widget.routes.keys.toList(),
        ) ??
        0,
  );

  @override
  void initState() {
    _subscription
      ..add(_listenable
          .toStream<T>()
          .mapNotNull(widget.index)
          .distinct()
          .map((index) => _indexToPath(index, widget.routes.keys.toList()))
          .distinct()
          .withLatestFrom(context.wouter.stream, (path, state) => (path, state))
          .where((data) =>
              data.$2.fullPath.startsWith(data.$2.base) &&
              !data.$2.fullPath.startsWith("${data.$2.base}${data.$1}"))
          .map((data) => "${data.$2.base}${data.$1}")
          .listen(context.wouter.actions.replace))
      ..add(context.wouter.stream
          .map((state) => state.path)
          .where((path) => path.isNotEmpty)
          .distinct()
          .mapNotNull((path) => _pathToIndex(
                path,
                widget.routes.keys.toList(),
              ))
          .distinct()
          .listen((index) => widget.onChanged(_listenable, index)));

    super.initState();
  }

  String _indexToPath(int index, List<String> paths) => paths[index];

  int? _pathToIndex(
    String path,
    List<String> paths,
  ) {
    final result =
        paths.indexWhere((element) => widget.equals.equals(path, element));

    if (result < 0) {
      return null;
    }

    return result;
  }

  @override
  void dispose() {
    _subscription.dispose();
    widget.dispose(context, _listenable);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(
        context,
        _listenable,
        widget.routes.values.toList(),
      );
}

extension _ListenableStreamExtension on Listenable {
  Stream<T> toStream<T extends Listenable>() {
    late final StreamController<T> controller;

    onChange() {
      if (!controller.isClosed) {
        controller.add(this as T);
      }
    }

    controller = StreamController<T>.broadcast(
      onListen: () {
        addListener(onChange);
        onChange();
      },
      onCancel: () => removeListener(onChange),
    );

    return controller.stream;
  }
}
