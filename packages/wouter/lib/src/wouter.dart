import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'base.dart';
import 'delegate/delegate.dart';
import 'extensions/extensions.dart';
import 'models/models.dart';

/// A [Widget] to use when using nested routing with base path
class Wouter extends StatefulWidget {
  // final WouterBaseRouterDelegate delegate;
  final Widget child;

  final PathMatcherBuilder matcher;

  final String base;

  const Wouter({
    Key? key,
    required this.child,
    this.matcher = PathMatchers.regexp,
    this.base = "",
  }) : super(key: key);

  /// Retrieves the immediate [WouterState] ancestor from the given context.
  ///
  /// If no Wouter ancestor exists for the given context, this will assert in debug mode, and throw an exception in release mode.
  static BaseWouter of(BuildContext context) {
    final wouter = maybeOf(context);

    assert(wouter != null, 'There was no Wouter in current context.');

    return wouter!;
  }

  /// Retrieves the immediate [WouterState] ancestor from the given context.
  ///
  /// If no Wouter ancestor exists for the given context, this will return null.
  static BaseWouter? maybeOf(BuildContext context) {
    try {
      return context.read<BaseWouter>();
    } catch (_) {
      return null;
    }
  }

  @override
  State<Wouter> createState() => WouterState();
}

class WouterState extends State<Wouter> with ChildWouter {
  // @override
  @protected
  late final BaseWouter parent = context.wouter;

  late PathMatcher matcher = widget.matcher();

  bool get canPop => parent.canPop;

  @override
  @protected
  String get base => widget.base;

  List<String> _stack = const [];

  List<String> get stack => _stack;

  String get route => stack.last;

  @override
  void initState() {
    stream.listen((stack) {
      _stack = List<String>.unmodifiable(stack);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Provider<BaseWouter>.value(
        value: this,
        child: widget.child,
      );
}
