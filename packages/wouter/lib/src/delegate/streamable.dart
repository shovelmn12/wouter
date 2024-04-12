import 'package:wouter/wouter.dart';

abstract class WouterStateStreamable {
  Stream<WouterState> get stream;

  WouterState get state;
}
