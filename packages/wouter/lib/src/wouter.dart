import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'delegate/delegate.dart';
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

  /// Retrieves the immediate [WouterBaseRouterDelegate] ancestor from the given context.
  ///
  /// If no Router ancestor exists for the given context, this will assert in debug mode, and throw an exception in release mode.
  static WouterState of(BuildContext context) {
    final wouter = maybeOf(context);

    assert(wouter != null, 'There was no Wouter in current context.');

    return wouter!;
  }

  /// Retrieves the immediate [WouterBaseRouterDelegate] ancestor from the given context.
  ///
  /// If no Router ancestor exists for the given context, this will return null.
  static WouterState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<WouterState>();

  @override
  State<Wouter> createState() => WouterState();
}

class WouterState extends State<Wouter>
    with RoutingActions
    implements ChangeNotifier {
  @override
  @protected
  late final WouterBaseRouterDelegate router =
      context.read<WouterBaseRouterDelegate>();

  final ChangeNotifier _changeNotifier = ChangeNotifier();

  late PathMatcher matcher = widget.matcher();

  @override
  @protected
  String get base => widget.base;

  List<String> _stack = const [];

  List<String> get stack => _stack;

  String get route => stack.last;

  @override
  void initState() {
    router.stream
        .where((stack) => stack.isNotEmpty)
        .map((stack) => stack.map((entry) => entry.path).toList())
        .distinct()
        .listen((stack) {
      _stack = List<String>.unmodifiable(stack);

      notifyListeners();
    });

    super.initState();
  }

  @override
  void dispose() {
    _changeNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
        value: this,
        child: widget.child,
      );

  @override
  void addListener(VoidCallback listener) =>
      _changeNotifier.addListener(listener);

  @override
  bool get hasListeners => _changeNotifier.hasListeners;

  @override
  void notifyListeners() => _changeNotifier.notifyListeners();

  @override
  void removeListener(VoidCallback listener) =>
      _changeNotifier.removeListener(listener);
}

mixin RoutingActions {
  WouterBaseRouterDelegate get router;

  String get base;

  Future<R?> push<R>(String path) => router.push("$base$path");

  bool pop([dynamic result]) => router.pop(result);

  void reset([String path = "/"]) => router.reset("$base$path");
}
