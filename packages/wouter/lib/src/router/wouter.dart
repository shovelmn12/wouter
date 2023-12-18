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
  Widget build(BuildContext context) => Provider<WouterState>.value(
        value: context.select(
          (WouterState state) => state.copyWith(
            stack: state.stack
                .where((entry) => entry.path.startsWith(base))
                .map((entry) => entry.copyWith(
                      path: entry.path.replaceRange(0, base.length, ""),
                    ))
                .toList(),
            base: base,
          ),
        ),
        updateShouldNotify: (prev, next) =>
            prev.fullPath != next.fullPath ||
            !const DeepCollectionEquality().equals(
              prev.stack.map((e) => e.path),
              next.stack.map((e) => e.path),
            ),
        child: child,
      );
}
