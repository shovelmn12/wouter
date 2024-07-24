import 'dart:async';

import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

abstract class WouterStateStreamable {
  Stream<WouterState> get stream;

  WouterState get state;

  const WouterStateStreamable._();

  factory WouterStateStreamable.value({
    required WouterState state,
  }) = _Value;

  factory WouterStateStreamable.root({
    required String base,
    required Stream<WouterState> source,
    required String initial,
  }) = _Root;

  factory WouterStateStreamable.child({
    required String base,
    required Stream<WouterState> parent,
    required WouterState state,
  }) = _Child;

  FutureOr<void> dispose() {}

  @override
  String toString() => "$state";
}

class _Value extends WouterStateStreamable {
  @override
  late final Stream<WouterState> stream = Stream.value(state).asBroadcastStream();

  @override
  final WouterState state;

  _Value({
    required this.state,
  }) : super._();
}

class _Root extends WouterStateStreamable {
  final BehaviorSubject<WouterState> _subject;

  @override
  late final Stream<WouterState> stream =
      _subject.stream.publishValue().autoConnect().distinct();

  late final StreamSubscription<WouterState> _subscription;

  @override
  WouterState get state => _subject.value;

  _Root({
    required String base,
    required Stream<WouterState> source,
    required String initial,
  })  : _subject = BehaviorSubject.seeded(WouterState(
          base: base,
          canPop: false,
          stack: [
            if (initial.isNotEmpty)
              RouteEntry(
                path: initial,
                onResult: (_) {},
              ),
          ],
        )),
        super._() {
    _subscription = source.listen(_subject.add);
  }

  @override
  Future<void> dispose() async {
    await _subscription.cancel();
    await _subject.close();
  }
}

class _Child extends WouterStateStreamable {
  final BehaviorSubject<WouterState> _subject;

  late final StreamSubscription<WouterState> _subscription;

  @override
  late final Stream<WouterState> stream =
      _subject.stream.publishValue().autoConnect().distinct();

  @override
  WouterState get state => _subject.value;

  _Child({
    required String base,
    required Stream<WouterState> parent,
    required WouterState state,
  })  : _subject = BehaviorSubject.seeded(state.copyWith(
          stack: _buildStack(base, state.stack),
          base: "${state.base}$base",
        )),
        super._() {
    _subscription = parent
        .map((state) => state.copyWith(
              stack: _buildStack(base, state.stack),
              base: "${state.base}$base",
            ))
        .distinct((prev, next) =>
            const DeepCollectionEquality().equals(
              prev.stack.map((e) => e.path).toList(),
              next.stack.map((e) => e.path).toList(),
            ) &&
            prev.base != next.base)
        .listen(_subject.add);
  }

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

  @override
  Future<void> dispose() async {
    await _subscription.cancel();
    await _subject.close();
  }
}
