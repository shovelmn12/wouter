import 'package:flutter/widgets.dart';
import 'package:wouter/wouter.dart';

extension WouterBuildContextExtensions on BuildContext {
  BaseWouter get wouter => Wouter.of(this);

  BaseWouter? get maybeWouter => Wouter.maybeOf(this);
}
