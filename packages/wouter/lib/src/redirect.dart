import 'package:flutter/widgets.dart';

import 'extensions/extensions.dart';

class Redirect extends StatefulWidget {
  final Widget child;
  final String to;

  const Redirect({
    Key? key,
    this.to = '',
    this.child = const SizedBox.shrink(),
  }) : super(key: key);

  @override
  RedirectState createState() => RedirectState();
}

class RedirectState extends State<Redirect> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => context.wouter.replace(widget.to));

    super.initState();
  }

  @override
  void didUpdateWidget(covariant Redirect oldWidget) {
    if (widget.to != oldWidget.to) {
      WidgetsBinding.instance.addPostFrameCallback((_) => context.wouter.replace(widget.to));
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
