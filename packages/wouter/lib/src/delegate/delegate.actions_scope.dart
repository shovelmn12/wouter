part of 'delegate.dart';

class _WouterActionsScope extends StatelessWidget {
  final ValueSetter<bool Function(String)> addPush;
  final ValueSetter<bool Function(String)> removePush;
  final ValueSetter<bool Function(String, [dynamic])> addPop;
  final ValueSetter<bool Function(String, [dynamic])> removePop;
  final Widget child;

  const _WouterActionsScope({
    required this.addPush,
    required this.removePush,
    required this.addPop,
    required this.removePop,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => child;
}

class WouterActionsScope extends StatefulWidget {
  final bool Function(String)? onPush;
  final bool Function(String, [dynamic])? onPop;
  final Widget child;

  const WouterActionsScope({
    super.key,
    this.onPush,
    this.onPop,
    required this.child,
  });

  @override
  State<WouterActionsScope> createState() => _WouterActionsScopeState();
}

class _WouterActionsScopeState extends State<WouterActionsScope> {
  late final _WouterActionsScope _scope =
      context.findAncestorWidgetOfExactType<_WouterActionsScope>()!;

  @override
  void initState() {
    _scope.addPush(_onPush);
    _scope.addPop(_onPop);

    super.initState();
  }

  @override
  void dispose() {
    _scope.removePush(_onPush);
    _scope.removePop(_onPop);

    super.dispose();
  }

  bool _onPush<T>(String path) => widget.onPush?.call(path) ?? true;

  bool _onPop(String path, [dynamic result]) =>
      widget.onPop?.call(path, result) ?? true;

  @override
  Widget build(BuildContext context) => widget.child;
}
