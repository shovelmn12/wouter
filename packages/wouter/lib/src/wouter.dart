import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'delegate/delegate.dart';

/// A [Widget] to use when using nested routing with base path
class Wouter extends StatelessWidget {
  final WouterBaseRouterDelegate delegate;

  const Wouter({
    Key? key,
    required this.delegate,
  }) : super(key: key);

  /// Retrieves the immediate [WouterBaseRouterDelegate] ancestor from the given context.
  ///
  /// If no Router ancestor exists for the given context, this will assert in debug mode, and throw an exception in release mode.
  static T of<T extends WouterBaseRouterDelegate>(BuildContext context) {
    final delegate = maybeOf<T>(context);

    assert(delegate != null, 'There was no Router in current context.');

    return delegate!;
  }

  /// Retrieves the immediate [WouterBaseRouterDelegate] ancestor from the given context.
  ///
  /// If no Router ancestor exists for the given context, this will return null.
  static T? maybeOf<T extends WouterBaseRouterDelegate>(BuildContext context) {
    try {
      return context.read<T>();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) => Router(
        routerDelegate: delegate,
      );
}
