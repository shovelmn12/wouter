import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'back_button_dispatcher.dart';
import 'delegate/delegate.dart';
import 'models/models.dart';

/// Central place for creating, accessing and modifying a Router subtree.
class Wouter extends StatefulWidget {
  /// Responsible for beaming, updating and rebuilding the page stack.
  final WouterBaseRouterDelegate delegate;

  const Wouter({
    Key? key,
    required this.delegate,
  }) : super(key: key);

  /// Access Wouter's [routerDelegate].
  static WouterBaseRouterDelegate of<T extends WouterDelegateState>(
      BuildContext context) {
    final delegate = maybeOf<T>(context);

    assert(delegate != null, 'There was no Router in current context.');

    return delegate!;
  }

  /// Access Wouter's [routerDelegate].
  static WouterBaseRouterDelegate<T>? maybeOf<T extends WouterDelegateState>(
      BuildContext context) {
    try {
      return context.read<WouterBaseRouterDelegate<T>>();
    } catch (e) {
      return null;
    }
  }

  @override
  State<StatefulWidget> createState() => WouterState();
}

class WouterState extends State<Wouter> {
  // WouterBaseRouterDelegate? _parent;
  // WouterBaseRouterDelegate? _delegate;

  // @override
  // void didChangeDependencies() {
  //   _update();
  //
  //   super.didChangeDependencies();
  // }
  //
  // @override
  // void didUpdateWidget(Wouter oldWidget) {
  //   _update();
  //
  //   super.didUpdateWidget(oldWidget);
  // }
  //
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  // }
  //
  // void _update() {
  //   final delegate = _delegate;
  //   final parent = context.wouter;
  //
  //   if (parent == _parent) {
  //     return;
  //   }
  //
  //   _parent = parent;
  //   _delegate = widget.delegate.withParent(parent);
  //
  //   delegate?.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final delegate = widget.delegate;
    // .withParent(context.wouter);

    return Router(
      routerDelegate: delegate,
      backButtonDispatcher: WouterBackButtonDispatcher(
        delegate: delegate,
      ),
    );
  }
}
