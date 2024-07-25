import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

class WouterListenable<T extends Listenable> extends StatefulWidget {
  final CreateListenable<T> create;
  final DisposeListenable<T> dispose;
  final OnGetListenableIndex<T> index;
  final OnRouteChanged<T> onChanged;
  final Map<String, Widget> routes;
  final WouterListenableWidgetBuilder<T> builder;
  final ToPathCallback toPath;
  final ToIndexCallback toIndex;

  const WouterListenable({
    super.key,
    required this.create,
    required this.dispose,
    required this.index,
    required this.onChanged,
    required this.routes,
    required this.builder,
    required this.toPath,
    required this.toIndex,
  });

  @override
  State<WouterListenable<T>> createState() => _WouterListenableState<T>();
}

class _WouterListenableState<T extends Listenable>
    extends State<WouterListenable<T>> with WouterParentMixin {
  final _subscription = CompositeSubscription();
  final _changeSubject = BehaviorSubject.seeded(false);

  late final T _listenable = widget.create(
    context,
    widget.toIndex(
          context.wouter.state.base,
          context.wouter.state.fullPath,
          widget.routes.keys.toList(),
        ) ??
        0,
  );

  @override
  void initState() {
    _subscription
      ..add(_listenable
          .toStream<T>()
          .where((event) => !_changeSubject.value)
          .mapNotNull(widget.index)
          .distinct()
          .map((index) => (index, widget.routes.keys.toList()))
          .distinct()
          .withLatestFrom(wouter, (data, state) => (data.$1, data.$2, state))
          .mapNotNull((data) => widget.toPath(
                data.$1,
                data.$3.base,
                data.$3.fullPath,
                data.$2,
              ))
          .listen(context.wouter.actions.replace))
      ..add(wouter
          .distinct()
          .map((state) => (state.base, state.fullPath))
          .distinct()
          .mapNotNull((data) => widget.toIndex(
                data.$1,
                data.$2,
                widget.routes.keys.toList(),
              ))
          .distinct()
          .listen((index) async {
        if (!_changeSubject.isClosed) {
          _changeSubject.add(true);
        }

        await widget.onChanged(_listenable, index);

        if (!_changeSubject.isClosed) {
          _changeSubject.add(false);
        }
      }));

    super.initState();
  }

  @override
  void dispose() {
    _subscription.dispose();
    _changeSubject.close();
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
