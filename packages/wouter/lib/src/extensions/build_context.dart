import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wouter/wouter.dart';

extension WouterBuildContextExtensions on BuildContext {
  WouterSelector get wouter => WouterSelector._(this);
}

class WouterSelector {
  final BuildContext _context;

  const WouterSelector._(this._context);

  WouterState get state => _context.watch<WouterState>();

  WouterActions get actions => _context.watch<WouterActions>();
}
