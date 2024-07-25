import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

mixin WouterParentMixin<T extends StatefulWidget> on State<T> {
  late final _wouterSubject =
      BehaviorSubject.seeded(context.read<WouterStateStreamable>());

  Stream<WouterState> get wouter =>
      _wouterSubject.stream.switchMap((wouter) => wouter.stream);

  @override
  void didChangeDependencies() {
    final wouter = context.watch<WouterStateStreamable>();

    if (wouter != _wouterSubject.value) {
      _wouterSubject.add(wouter);
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _wouterSubject.close();

    super.dispose();
  }
}
