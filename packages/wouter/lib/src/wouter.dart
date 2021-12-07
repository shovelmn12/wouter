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

class WouterState extends State<Wouter> with ChildWouter, _ChangeNotifierState {
  @protected
  late BaseWouter _parent = context.wouter;

  @override
  @protected
  BaseWouter get parent => _parent;

  @protected
  set parent(BaseWouter wouter) {
    unsubscribe(parent);

    _parent = wouter;

    subscribe(wouter);
  }

  late PathMatcher matcher = widget.matcher();

  @override
  bool get canPop => stack.isNotEmpty || parent.canPop;

  @override
  @protected
  String get base => widget.base;

  List<String> _stack = const [];

  @override
  @protected
  List<String> get stack => _stack;

  @protected
  set stack(List<String> stack) {
    final prev = path;

    _stack = List<String>.unmodifiable(stack);

    onRouteChanged(prev, path);
  }

  @override
  String get path {
    try {
      return stack.last;
    } catch (e) {
      return "";
    }
  }

  @override
  void initState() {
    subscribe(parent);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    final wouter = context.wouter;

    if (parent != wouter) {
      parent = wouter;
    }

    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant Wouter oldWidget) {
    if (oldWidget.matcher != widget.matcher) {
      matcher = widget.matcher();

      notifyListeners();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    unsubscribe(parent);

    super.dispose();
  }

  @protected
  void subscribe(BaseWouter wouter) {
    wouter.addListener(_onChange);

    _onChange();
  }

  void _onChange() => onChange(parent);

  @protected
  void onChange(BaseWouter wouter) => stack = wouter.stack
      .where((path) => path.startsWith(base))
      .map((path) => policy.removeBase(base, path))
      .toList();

  @protected
  void unsubscribe(BaseWouter wouter) => wouter.removeListener(_onChange);

  @protected
  bool shouldNotify(String prev, String next) => prev != next;

  @protected
  void onRouteChanged(String prev, String next) {
    if (shouldNotify(prev, next)) {
      notifyListeners();
    }
  }

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<BaseWouter>.value(
        value: this,
        child: widget.child,
      );
}

mixin _ChangeNotifierState<T extends StatefulWidget> on State<T>
    implements ChangeNotifier {
  @protected
  final ChangeNotifier notifier = ChangeNotifier();

  @override
  bool get hasListeners => notifier.hasListeners;

  @override
  void dispose() {
    notifier.dispose();

    super.dispose();
  }

  @protected
  void notifyListeners() => notifier.notifyListeners();

  @override
  void addListener(VoidCallback listener) => notifier.addListener(listener);

  @override
  void removeListener(VoidCallback listener) =>
      notifier.removeListener(listener);
}
