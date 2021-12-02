import 'package:flutter/widgets.dart';
import 'package:wouter/src/base.dart';

import '../wouter.dart';

extension WouterBuildContextExtensions on BuildContext {
  BaseWouter get wouter => Wouter.of(this);

  BaseWouter? get maybeWouter => Wouter.maybeOf(this);
}
