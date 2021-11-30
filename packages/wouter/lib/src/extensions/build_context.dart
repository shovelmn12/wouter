import 'package:flutter/widgets.dart';

import '../wouter.dart';

extension WouterBuildContextExtensions on BuildContext {
  WouterState get wouter => Wouter.of(this);

  WouterState? get maybeWouter => Wouter.maybeOf(this);
}
