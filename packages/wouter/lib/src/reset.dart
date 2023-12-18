import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wouter/wouter.dart';

class Reset extends StatefulWidget {
  final Widget child;
  final List<String> to;

  const Reset({
    super.key,
    required this.to,
    this.child = const SizedBox.shrink(),
  });

  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  @override
  void initState() {
    final WouterActions(reset: reset) = context.read<WouterActions>();

    WidgetsBinding.instance.addPostFrameCallback((_) => reset(widget.to));

    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
