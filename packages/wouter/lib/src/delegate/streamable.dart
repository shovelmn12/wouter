import 'dart:async';

import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

abstract class WouterStateStreamable {
  Stream<WouterState> get stream;

  WouterState get state;

  const WouterStateStreamable._();

  factory WouterStateStreamable({
    required Stream<WouterState> source,
    required WouterState state,
  }) = _WouterStateStreamableImpl;

  factory WouterStateStreamable.child({
    required String base,
    required Stream<WouterState> source,
    required WouterState state,
  }) =>
      WouterStateStreamable(
        source: source.map((state) => state.copyWith(
              stack: _buildStack(base, state.stack),
              base: "${state.base}$base",
            )),
        state: state.copyWith(
          stack: _buildStack(base, state.stack),
          base: "${state.base}$base",
        ),
      );

  static bool _byState(WouterState prev, WouterState next) =>
      const DeepCollectionEquality().equals(
        prev.stack.map((e) => e.path).toList(),
        next.stack.map((e) => e.path).toList(),
      ) &&
      prev.base != next.base;

  static List<RouteEntry> _buildStack(String base, List<RouteEntry> stack) {
    final start = stack.indexWhere((entry) => entry.path.startsWith(base));

    if (start < 0) {
      return const [];
    }

    return stack
        .sublist(start)
        .takeWhile((entry) => entry.path.startsWith(base))
        .map((entry) {
      final path = entry.path.replaceRange(0, base.length, "");

      return entry.copyWith(
        path: path.isEmpty ? "/" : path,
      );
    }).toList();
  }

  FutureOr<void> dispose() {}

  @override
  String toString() => "$state";
}

class _WouterStateStreamableImpl extends WouterStateStreamable {
  final BehaviorSubject<WouterState> _subject;

  @override
  Stream<WouterState> get stream => _subject.stream.distinct();

  late final StreamSubscription<WouterState> _subscription;

  @override
  WouterState get state => _subject.value;

  _WouterStateStreamableImpl({
    required Stream<WouterState> source,
    required WouterState state,
  })  : _subject = BehaviorSubject.seeded(state),
        super._() {
    _subscription =
        source.distinct(WouterStateStreamable._byState).listen(_subject.add);
  }

  @override
  Future<void> dispose() async {
    await _subscription.cancel();
    await _subject.close();
  }
}
