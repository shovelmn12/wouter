import 'package:flutter/widgets.dart';

import 'extensions/extensions.dart';

class Redirect extends StatelessWidget {
  final Widget child;
  final String to;

  const Redirect({
    Key? key,
    required this.to,
    this.child = const SizedBox.shrink(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => context.wouter.reset(to));

    return child;
  }
}
