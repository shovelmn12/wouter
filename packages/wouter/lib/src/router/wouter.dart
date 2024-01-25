import 'package:collection/collection.dart';
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
  Widget build(BuildContext context) => Selector<WouterState, WouterState>(
        key: ValueKey('wouter-base-$base'),
        selector: (context, state) => state.copyWith(
          stack: state.stack
              .where((entry) => entry.path.startsWith(base))
              .map((entry) {
            final path = entry.path.replaceRange(0, base.length, "");

            return entry.copyWith(
              path: path.isEmpty ? "/" : path,
            );
          }).toList(),
          base: "${state.base}$base",
        ),
        shouldRebuild: (prev, next) =>
            prev.fullPath != next.fullPath ||
            !const DeepCollectionEquality().equals(
              prev.stack.map((e) => e.path),
              next.stack.map((e) => e.path),
            ),
        builder: (context, state, child) => Provider.value(
          value: state,
          child: child,
        ),
        child: child,
      );
}
