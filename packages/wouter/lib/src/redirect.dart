import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wouter/wouter.dart';

class Redirect extends StatefulWidget {
  final Widget child;
  final String to;

  const Redirect({
    super.key,
    this.to = "",
    this.child = const SizedBox.shrink(),
  });

  @override
  State<Redirect> createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<WouterActions>().replace(widget.to));

    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
