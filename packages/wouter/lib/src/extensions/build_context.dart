import 'package:flutter/widgets.dart';

import '../delegate/wouter.dart';
import '../wouter.dart';

extension WouterBuildContextExtensions on BuildContext {
  WouterBaseRouterDelegate get wouter => Wouter.of(this);

  WouterBaseRouterDelegate? get maybeWouter => Wouter.maybeOf(this);
}
