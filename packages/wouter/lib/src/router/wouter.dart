import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

class _WouterStateStreamableImpl implements WouterStateStreamable {
  final BehaviorSubject<WouterState> _subject = BehaviorSubject();
  late final StreamSubscription<WouterState> _subscription;

  @override
  late final Stream<WouterState> stream =
      _subject.stream.publishValue().autoConnect();

  @override
  WouterState get state => _subject.value;

  _WouterStateStreamableImpl({
    required String base,
    required Stream<WouterState> parent,
  }) {
    _subscription = parent
        .map((state) => state.copyWith(
              stack: state.stack
                  .sublist(1)
                  .takeWhile((entry) => entry.path.startsWith(base))
                  .map((entry) {
                final path = entry.path.replaceRange(0, base.length, "");

                return entry.copyWith(
                  path: path.isEmpty ? "/" : path,
                );
              }).toList(),
              base: "${state.base}$base",
            ))
        .distinct()
        .listen(_subject.add);
  }

  Future<void> close() async {
    await _subscription.cancel();
    await _subject.close();
  }
}

class Wouter extends StatelessWidget {
  final String base;
  final Widget child;

  const Wouter({
    super.key,
    this.base = '',
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Provider<WouterStateStreamable>(
        key: ValueKey("wouter-base-$base"),
        create: (context) => _WouterStateStreamableImpl(
          base: base,
          parent: context.wouter.stream,
        ),
        dispose: (context, streamable) =>
            (streamable as _WouterStateStreamableImpl).close(),
        child: child,
      );
}
