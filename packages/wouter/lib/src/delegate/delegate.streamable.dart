part of 'delegate.dart';

class _WouterStateStreamableImpl implements WouterStateStreamable {
  final BehaviorSubject<WouterState> _subject;

  @override
  late final Stream<WouterState> stream =
      _subject.stream.publishValue().autoConnect();

  @override
  WouterState get state => _subject.value;

  _WouterStateStreamableImpl({
    required String base,
    required String initial,
  }) : _subject = BehaviorSubject.seeded(WouterState(
          base: base,
          canPop: false,
          stack: [
            if (initial.isNotEmpty)
              RouteEntry(
                path: initial,
              ),
          ],
        ));
}
