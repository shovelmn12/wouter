import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

export 'functions.dart';

class WouterRouterDelegate extends RouterDelegate<String> with ChangeNotifier {
  final BehaviorSubject<String> _pathSubject = BehaviorSubject();
  final BehaviorSubject<WouterActions> _actionsSubject = BehaviorSubject();

  final WidgetBuilder builder;

  @override
  String get currentConfiguration => _pathSubject.valueOrNull ?? "";

  WouterRouterDelegate({
    required this.builder,
  }) {
    _pathSubject.listen((event) => notifyListeners());
  }

  @override
  void dispose() {
    _pathSubject.close();
    _actionsSubject.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Wouter(
        child: _Sync(
          pathSubject: _pathSubject,
          actionsSubject: _actionsSubject,
          child: Navigator(
            onPopPage: (route, result) => !_actionsSubject.value.pop(result),
            pages: [
              MaterialPage(
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Builder(
                    builder: builder,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Future<bool> popRoute() async => _actionsSubject.value.pop();

  @override
  Future<void> setNewRoutePath(String configuration) =>
      SynchronousFuture(_actionsSubject.value.reset(configuration));
}

class _Sync extends StatefulWidget {
  final BehaviorSubject<String> pathSubject;
  final BehaviorSubject<WouterActions> actionsSubject;
  final Widget child;

  const _Sync({
    required this.pathSubject,
    required this.actionsSubject,
    required this.child,
  });

  @override
  State<_Sync> createState() => _SyncState();
}

class _SyncState extends State<_Sync> {
  @override
  void initState() {
    widget.pathSubject.add(context.read<WouterState>().fullPath);
    widget.actionsSubject.add(context.read<WouterActions>());

    super.initState();
  }

  @override
  void didChangeDependencies() {
    widget.pathSubject.add(context.read<WouterState>().fullPath);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
