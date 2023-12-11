import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/src/models/state/state.dart';
import 'package:wouter/wouter.dart' hide WouterState;

typedef WouterActions = ({
  Future<dynamic> Function(String) push,
  bool Function([dynamic]) pop,
  void Function([String]) reset,
  Future<dynamic> Function(String, [dynamic]) replace,
  void Function(List<RouteEntry> Function(List<RouteEntry>)) update,
});

class WouterProvider extends StatefulWidget {
  final PathMatcherBuilder? matcher;

  final RoutingPolicy? policy;

  final String base;

  final Widget child;

  const WouterProvider({
    super.key,
    this.matcher,
    this.policy,
    this.base = '',
    required this.child,
  });

  @override
  State<WouterProvider> createState() => _WouterProviderState();
}

class _WouterProviderState extends State<WouterProvider> {
  late final BehaviorSubject<WouterState> _stateSubject;

  /// Push a [path].
  ///
  /// Returns a Future that completes to the result value passed to pop when the pushed route is popped off the navigator.
  ///
  ///The T type argument is the type of the return value of the route.
  ///
  (Future<R?>, WouterState) _push<R>(WouterState state, String path) {
    final completer = Completer<R?>();

    return (
      completer.future,
      state.copyWith(
        stack: state.policy.onPush(
          state.policy.pushPath(
            state.fullPath,
            state.policy.buildPath(state.base, path),
          ),
          state.stack,
          state.policy.buildOnResultCallback(completer),
        ),
      ),
    );
  }

  /// Pop the history stack.
  /// Returns [canPop] before popping.
  WouterState? _pop(WouterState state, [dynamic result]) {
    if (state.canPop) {
      return state.copyWith(
        stack: state.policy.onPop(state.stack, result),
      );
    }

    return null;
  }

  /// Resets the state as if only [path] been pushed.
  WouterState _reset(WouterState state, [String path = ""]) {
    state.stack.forEach((route) => route.onResult?.call(null));

    return state.copyWith(
      stack: List.unmodifiable(state.policy.onReset(
        state.policy.pushPath(
          state.fullPath,
          state.policy.buildPath(state.base, path),
        ),
      )),
    );
  }

  // Future<T> _replace(WouterState state, String path, [dynamic result]) {
  //   final completer = Completer<T>();
  //
  //   update((state) => policy.onPush(
  //     policy.pushPath(
  //       this.path,
  //       policy.buildPath(base, path),
  //     ),
  //     policy.onPop(state, result),
  //     policy.buildOnResultCallback(completer),
  //   ));
  //
  //   return completer.future;
  // }

  @override
  Widget build(BuildContext context) => StreamProvider<WouterState>(
        create: (context) => _stateSubject = BehaviorSubject.seeded(WouterState(
          matcher: widget.matcher?.call() ?? PathMatchers.regexp(),
          policy: widget.policy ?? const URLRoutingPolicy(),
          base: '',
          stack: [
            RouteEntry(
              path: '${widget.base}/',
            ),
          ],
        )),
        initialData: WouterState(
          matcher: widget.matcher?.call() ?? PathMatchers.regexp(),
          policy: widget.policy ?? const URLRoutingPolicy(),
          base: '',
          stack: [
            RouteEntry(
              path: '${widget.base}/',
            ),
          ],
        ),
        child: widget.child,
      );
}
