import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wouter/wouter.dart';

extension WouterBuildContextExtensions on BuildContext {
  WouterSelector get wouter => WouterSelector._(this);
}

class WouterSelector {
  final BuildContext _context;

  const WouterSelector._(this._context);

  WouterStateStreamable get _streamable =>
      _context.read<WouterStateStreamable>();

  Stream<WouterState> get stream => _streamable.stream;

  WouterState get state => _streamable.state;

  WouterActions get actions => _context.read<WouterActions>();
}
