import 'package:flutter/widgets.dart';

import 'extensions/extensions.dart';

class Redirect extends StatefulWidget {
  final Widget child;
  final String to;

  const Redirect({
    Key? key,
    this.to = "",
    this.child = const SizedBox.shrink(),
  }) : super(key: key);

  @override
  _RedirectState createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => context.wouter.replace(widget.to));

    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
