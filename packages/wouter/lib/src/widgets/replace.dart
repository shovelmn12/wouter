import 'package:flutter/widgets.dart';
import 'package:wouter/wouter.dart';

class Replace extends StatefulWidget {
  final Widget child;
  final String to;

  const Replace({
    super.key,
    required this.to,
    this.child = const SizedBox.shrink(),
  });

  @override
  State<Replace> createState() => _ReplaceState();
}

class _ReplaceState extends State<Replace> {
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => context.wouter.actions.replace(widget.to));

    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
