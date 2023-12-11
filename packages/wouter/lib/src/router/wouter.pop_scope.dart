part of 'wouter.dart';

class WPopScope extends StatefulWidget {
  final Widget child;
  final ValueGetter<bool> onPop;

  const WPopScope({
    super.key,
    required this.onPop,
    required this.child,
  });

  @override
  State<WPopScope> createState() => _WPopScopeState();
}

class _WPopScopeState extends State<WPopScope> {
  late WouterState _wouter;

  @override
  void initState() {
    _wouter = context.read<WouterState>();

    _register(_wouter);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    final wouter = context.read<WouterState>();

    if (wouter != _wouter) {
      _unregister(_wouter);

      _wouter = wouter;

      _register(_wouter);
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _unregister(_wouter);

    super.dispose();
  }

  void _register(WouterState wouter) =>
      wouter._registerPopCallback(widget.onPop);

  void _unregister(WouterState wouter) =>
      wouter._unregisterPopCallback(widget.onPop);

  @override
  Widget build(BuildContext context) => widget.child;
}
