import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

class Wouter extends StatefulWidget {
  final PathMatcherBuilder? matcher;

  final RoutingPolicy? policy;

  final String base;

  final Widget child;

  const Wouter({
    super.key,
    this.matcher,
    this.policy,
    this.base = '',
    required this.child,
  });

  @override
  State<Wouter> createState() => _WouterState();
}

class _WouterState extends State<Wouter> {
  late final BehaviorSubject<WouterState> _stateSubject;

  /// Push a [path].
  ///
  /// Returns a Future that completes to the result value passed to pop when the pushed route is popped off the navigator.
  ///
  ///The T type argument is the type of the return value of the route.
  (WouterState, Future<R?>) _push<R>(WouterState state, String path) {
    final completer = Completer<R?>();

    return (
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
      completer.future,
    );
  }

  /// Pop the history stack.
  /// Returns [canPop] before popping.
  (WouterState, bool) _pop(WouterState state, [dynamic result]) {
    if (state.canPop) {
      return (
        state.copyWith(
          stack: state.policy.onPop(state.stack, result),
        ),
        true,
      );
    }

    return (state, false);
  }

  /// Resets the state as if only [path] been pushed.
  (WouterState, void) _reset(WouterState state, [String path = "/"]) {
    state.stack.forEach((route) => route.onResult?.call(null));

    return (
      state.copyWith(
        stack: List.unmodifiable(state.policy.onReset(
          state.policy.pushPath(
            state.fullPath,
            state.policy.buildPath(state.base, path),
          ),
        )),
      ),
      null,
    );
  }

  (WouterState, Future<T>) _replace<T>(WouterState state, String path,
      [dynamic result]) {
    final completer = Completer<T>();

    return (
      state.copyWith(
        stack: state.policy.onPush(
          state.policy.pushPath(
            state.path,
            state.policy.buildPath(state.base, path),
          ),
          state.policy.onPop(state.stack, result),
          state.policy.buildOnResultCallback(completer),
        ),
      ),
      completer.future
    );
  }

  (WouterState, void) _update(
    WouterState state,
    WouterStateUpdateCallback update,
  ) =>
      (
        state.copyWith(
          stack: update(state.stack),
        ),
        null,
      );

  T _action<T>(ValueGetter<(WouterState, T)> action) {
    final (next, result) = action();

    _stateSubject.add(next);

    return result;
  }

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
        child: Provider<WouterActions>(
          create: (context) => (
            push: <T>(path) => _action(() => _push<T>(
                  context.read<WouterState>(),
                  path,
                )),
            pop: ([result]) => _action(() => _pop(
                  context.read<WouterState>(),
                  result,
                )),
            reset: ([path = "/"]) => _action(() => _reset(
                  context.read<WouterState>(),
                  path,
                )),
            replace: <T>(path, [result]) => _action(() => _replace<T>(
                  context.read<WouterState>(),
                  path,
                )),
            update: (update) => _action(() => _update(
                  context.read<WouterState>(),
                  update,
                )),
          ),
          child: widget.child,
        ),
      );
}
