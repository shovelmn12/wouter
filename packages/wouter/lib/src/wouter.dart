import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/src/mixin.dart';

import 'base.dart';
import 'delegate/delegate.dart';
import 'extensions/extensions.dart';
import 'models/models.dart';

/// A [Widget] to use when using nested routing with base path
class Wouter extends StatefulWidget {
  final Widget child;

  final PathMatcherBuilder matcher;

  final String base;

  final RoutingPolicy policy;

  const Wouter({
    Key? key,
    required this.child,
    this.matcher = PathMatchers.regexp,
    this.base = "",
    this.policy = const URLRoutingPolicy<RouteEntry<String>>(),
  }) : super(key: key);

  /// Retrieves the immediate [WouterState] ancestor from the given context.
  ///
  /// If no Wouter ancestor exists for the given context, this will assert in debug mode, and throw an exception in release mode.
  static WouterState of(BuildContext context) {
    final wouter = maybeOf(context);

    assert(wouter != null, 'There was no Wouter in current context.');

    return wouter!;
  }

  /// Retrieves the immediate [WouterState] ancestor from the given context.
  ///
  /// If no Wouter ancestor exists for the given context, this will return null.
  static WouterState? maybeOf(BuildContext context) {
    try {
      return context.read<WouterState>();
    } catch (_) {
      return null;
    }
  }

  @override
  State<Wouter> createState() => WouterState();
}

class WouterState extends State<Wouter> with WouterStackListenerMixin<Wouter> {
  late PathMatcher matcher = widget.matcher();

  @protected
  String get base => widget.base;

  @override
  void didUpdateWidget(covariant Wouter oldWidget) {
    if (oldWidget.matcher != widget.matcher) {
      matcher = widget.matcher();

      setState(() {});
    }

    super.didUpdateWidget(oldWidget);
  }

  RoutingPolicy get policy => context.maybeWouter?.policy ?? widget.policy;

  @override
  Future<R?> push<R>(String path) {
    final parent = this.parent;

    if (parent == null) {

    } else {
      return parent.push(
        policy.pushPath(
          policy.initial,
          base,
          path,
        ),
      );
    }
  }

  @override
  bool pop([dynamic result]) => parent.pop(result);

  @override
  void reset([String? path]) => parent.reset(
        policy.pushPath(
          policy.initial,
          base,
          path ?? policy.initial,
        ),
      );

  @override
  void onStackChanged(List<String> stack) => setState(() {});

  @override
  Widget build(BuildContext context) => Provider<WouterState>.value(
        value: this,
        child: widget.child,
      );
}
