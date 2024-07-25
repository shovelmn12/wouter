import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wouter/wouter.dart';

class Wouter extends StatefulWidget {
  final String base;
  final Widget child;

  const Wouter({
    super.key,
    this.base = '',
    required this.child,
  });

  @override
  State<Wouter> createState() => _WouterState();
}

class _WouterState extends State<Wouter> with WouterParentMixin {
  @override
  Widget build(BuildContext context) => Provider<WouterStateStreamable>(
        key: ValueKey("wouter-base-${widget.base}"),
        create: (context) => WouterStateStreamable.child(
          base: widget.base,
          source: wouter,
          state: context.wouter.state,
        ),
        dispose: (context, streamable) => streamable.dispose(),
        child: widget.child,
      );
}
