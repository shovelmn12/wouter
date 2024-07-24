import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wouter/wouter.dart';

class Wouter extends StatelessWidget {
  final String base;
  final Widget child;

  const Wouter({
    super.key,
    this.base = '',
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Provider<WouterStateStreamable>(
        key: ValueKey("wouter-base-$base"),
        create: (context) => WouterStateStreamable.child(
          base: base,
          parent: context.wouter.stream,
          state: context.wouter.state,
        ),
        dispose: (context, streamable) => streamable.dispose(),
        child: child,
      );
}
