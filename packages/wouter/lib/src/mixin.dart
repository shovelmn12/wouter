import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

import 'base.dart';
import 'delegate/delegate.dart';
import 'extensions/extensions.dart';
import 'models/models.dart';

mixin WouterStackListenerMixin<W extends StatefulWidget> on State<W> {
  final BehaviorSubject<List<String>> _stackSubject = BehaviorSubject.seeded(const []);
  late StreamSubscription<List<String>>? _subscription;

  late WouterState? _parent = context.maybeWouter;

  WouterState? get parent => _parent;

  @override
  void initState() {
    subscribe(context.maybeWouter);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    final parent = context.maybeWouter;

    if (_parent != parent) {
      subscribe(parent);
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _subscription?.cancel();

    super.dispose();
  }

  @protected
  void subscribe(WouterState? wouter) {
    _subscription?.cancel();

    if (wouter != null) {
      _parent = wouter;
      _subscription = onSubscribe(wouter._stackSubject).listen(onStackChanged);
    } else {
      _parent = null;
      _subscription = null;
      _stackSubject.add(const []);
    }
  }

  Stream<List<String>> onSubscribe(Stream<List<String>> stream) => stream.distinct();

  void onStackChanged(List<String> stack) {}
}
