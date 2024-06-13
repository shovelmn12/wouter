part of 'base.dart';

class _WouterStateStreamableImpl implements WouterStateStreamable {
  @override
  late final Stream<WouterState> stream = Stream.value(state);

  @override
  final WouterState state;

  _WouterStateStreamableImpl({
    required this.state,
  });
}
