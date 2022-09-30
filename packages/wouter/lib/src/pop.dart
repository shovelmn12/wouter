import 'package:flutter/widgets.dart';

import 'extensions/extensions.dart';

class Pop extends StatefulWidget {
  final Widget child;

  const Pop({
    Key? key,
    this.child = const SizedBox.shrink(),
  }) : super(key: key);

  @override
  PopState createState() => PopState();
}

class PopState extends State<Pop> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => context.wouter.pop());

    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
