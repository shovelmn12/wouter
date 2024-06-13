import 'package:flutter/widgets.dart';
import 'package:wouter/wouter.dart';

class ReplaceUntil extends StatefulWidget {
  final Widget child;
  final String to;
  final bool Function(String) predicate;
  final dynamic Function(String)? result;

  const ReplaceUntil({
    super.key,
    required this.to,
    required this.predicate,
    this.result,
    this.child = const SizedBox.shrink(),
  });

  @override
  State<ReplaceUntil> createState() => _ReplaceUntilState();
}

class _ReplaceUntilState extends State<ReplaceUntil> {
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => context.wouter.actions.replaceUntil(
              widget.to,
              widget.predicate,
              widget.result,
            ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
