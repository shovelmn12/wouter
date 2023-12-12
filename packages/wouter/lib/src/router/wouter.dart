import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

part 'wouter.pop_scope.dart';

/// A [Widget] to use when using nested routing with base path
class Wouter extends StatefulWidget {
  final Widget child;

  final PathMatcherBuilder? matcher;

  final RoutingPolicy<List<RouteEntry>>? policy;

  final String base;

  const Wouter({
    super.key,
    required this.child,
    this.matcher,
    this.policy,
    this.base = "",
  });

  /// Retrieves the immediate [WouterState] ancestor from the given context.
  ///
  /// If no Wouter ancestor exists for the given context, this will assert in debug mode, and throw an exception in release mode.
  static WouterState of(BuildContext context) {
    final wouter = maybeOf(context);

    assert(wouter != null, 'There was no Wouter in current context.');

    return wouter!;
  }

  /// Retrieves the immediate [WouterState] ancestor from the given context.
  ///
  /// If no Wouter ancestor exists for the given context, this will return null.
  static WouterState? maybeOf(BuildContext context) {
    try {
      return context.watch<WouterState>();
    } catch (_) {
      return null;
    }
  }

  @override
  State<Wouter> createState() => WouterState();
}

class WouterState extends State<Wouter> with BaseWouter {
  final BehaviorSubject<List<RouteEntry>> _stackSubject = BehaviorSubject();

  final BehaviorSubject<List<ValueGetter<bool>>> _popSubject =
      BehaviorSubject();

  Stream<List<RouteEntry>> get stream => _stackSubject.stream.distinct();

  StreamSubscription<List<RouteEntry>>? _subscription;

  @override
  RoutingPolicy get policy =>
      widget.policy ?? parent?.policy ?? const URLRoutingPolicy();

  @protected
  @override
  WouterState? get parent {
    try {
      return context.read<WouterState>();
    } catch (_) {
      return null;
    }
  }

  late WouterState? _prevParent = parent;

  PathMatcher get matcher =>
      widget.matcher?.call() ?? parent?.matcher ?? PathMatchers.regexp();

  @override
  bool get canPop =>
      (_stackSubject.value.length > 1 || (parent?.canPop ?? false));

  bool get allowedToPop {
    final callbacks = (parent?._popSubject.value ?? _popSubject.value);

    if (callbacks.isEmpty) {
      return true;
    }

    return callbacks.fold(true, (acc, callback) => acc && callback());
  }

  @override
  String get base => widget.base;

  @override
  List<String> get stack =>
      _stackSubject.value.map((entry) => entry.path).toList();

  @override
  String get path => stack.last;

  @override
  void initState() {
    final parent = this.parent;

    if (parent != null) {
      _subscription = subscribe(parent);
    } else {
      _stackSubject.add(const [
        RouteEntry(
          path: "/",
        )
      ]);
      _popSubject.add(const []);
    }

    _stackSubject
        .where((stack) => stack.isNotEmpty)
        .map((stack) => stack.last.path)
        .distinct()
        .listen((_) => setState(() {}));

    super.initState();
  }

  @override
  void didUpdateWidget(covariant Wouter oldWidget) {
    if (oldWidget.matcher != widget.matcher ||
        oldWidget.policy != widget.policy) {
      setState(() {});
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    final parent = this.parent;

    if (parent != null && _prevParent != parent) {
      _prevParent = parent;
      _subscription?.cancel();
      _subscription = subscribe(parent);
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _dispose();

    super.dispose();
  }

  void _dispose() async {
    await _subscription?.cancel();
    await _stackSubject.close();
  }

  @protected
  StreamSubscription<List<RouteEntry>> subscribe(WouterState wouter) =>
      wouter.stream
          .distinct()
          .map((stack) => stack
              .where((entry) => entry.path.startsWith(base))
              .map((entry) => entry.copyWith(
                    path: wouter.policy.removeBase(base, entry.path),
                  ))
              .toList())
          .distinct()
          .listen(_stackSubject.add);

  @override
  Widget build(BuildContext context) => Provider<WouterState>.value(
        value: this,
        updateShouldNotify: (prev, next) => true,
        child: widget.child,
      );

  /// Push a [path].
  ///
  /// Returns a Future that completes to the result value passed to pop when the pushed route is popped off the navigator.
  ///
  ///The T type argument is the type of the return value of the route.
  ///
  @override
  Future<R?> push<R>(String path) {
    final parent = this.parent;

    if (parent == null) {
      final completer = Completer<R?>();

      _stackSubject.add(
        policy.onPush(
          policy.pushPath(
            "$base/${this.path}",
            policy.buildPath(base, path),
          ),
          _stackSubject.value,
          policy.buildOnResultCallback(completer),
        ),
      );

      return completer.future;
    } else {
      return parent.push(policy.buildPath(base, path));
    }
  }

  /// Pop the history stack.
  /// Returns [canPop] before popping.
  @override
  bool pop([dynamic result]) {
    final parent = this.parent;

    if (parent == null) {
      final canPop = this.canPop;

      print("canPop $canPop");

      if (canPop) {
        final allowedToPop = this.allowedToPop;

        print("allowed $allowedToPop");

        if (allowedToPop) {
          _stackSubject.add(
            policy.onPop(_stackSubject.value, result),
          );
        }

        return true;
      }

      return false;
    } else {
      return parent.pop(result);
    }
  }

  /// Resets the state as if only [path] been pushed.
  @override
  void reset([String path = ""]) {
    final parent = this.parent;

    if (parent == null) {
      _stackSubject.value.forEach((route) => route.onResult?.call(null));

      _stackSubject.add(
        policy.onReset(
          policy.pushPath(
            "$base${this.path}",
            policy.buildPath(base, path),
          ),
        ),
      );
    } else {
      parent.reset(policy.buildPath(base, path));
    }
  }

  @override
  void update(List<RouteEntry> Function(List<RouteEntry> state) update) =>
      _stackSubject.add(update(_stackSubject.value));

  void _registerPopCallback(ValueGetter<bool> callback) {
    final parent = this.parent;

    if (parent == null) {
      _popSubject.add([
        ..._popSubject.valueOrNull ?? [],
        callback,
      ]);
    } else {
      parent._registerPopCallback(callback);
    }
  }

  void _unregisterPopCallback(ValueGetter<bool> callback) {
    final parent = this.parent;

    if (parent == null) {
      _popSubject.add((_popSubject.valueOrNull ?? [])
          .where((cb) => cb != callback)
          .toList());
    } else {
      parent._unregisterPopCallback(callback);
    }
  }
}
