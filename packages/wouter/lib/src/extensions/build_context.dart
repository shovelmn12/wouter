import 'package:flutter/widgets.dart';
import 'package:wouter/wouter.dart';

extension WouterBuildContextExtensions on BuildContext {
  WouterState get wouter => Wouter.of(this);

  WouterState? get maybeWouter => Wouter.maybeOf(this);
}
