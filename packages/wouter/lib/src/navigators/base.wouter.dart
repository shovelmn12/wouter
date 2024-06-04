part of 'base.dart';

class _WouterStateStreamableImpl implements WouterStateStreamable {
  final BehaviorSubject<WouterState> _subject = BehaviorSubject();
  late final StreamSubscription<WouterState> _subscription;

  @override
  late final Stream<WouterState> stream =
      _subject.stream.publishValue().autoConnect();

  @override
  WouterState get state => _subject.value;

  _WouterStateStreamableImpl({
    required Stream<WouterState> source,
  }) {
    _subscription = source.distinct().listen(_subject.add);
  }

  Future<void> close() async {
    await _subscription.cancel();
    await _subject.close();
  }
}
