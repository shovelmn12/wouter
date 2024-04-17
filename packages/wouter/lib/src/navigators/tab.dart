import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:wouter/wouter.dart';

import 'equality/equality.dart';

class WouterTab extends StatefulWidget {
  final Map<String, Widget> routes;
  final WouterListenableWidgetBuilder<TabController> builder;
  final Equality<String> equals;

  const WouterTab({
    super.key,
    required this.routes,
    required this.builder,
    this.equals = const StartsWithEquality(),
  });

  @override
  State<WouterTab> createState() => _WouterTabState();
}

class _WouterTabState extends State<WouterTab>
    with SingleTickerProviderStateMixin {
  @override
  void didUpdateWidget(covariant WouterTab oldWidget) {
    setState(() {});

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => WouterListenable<TabController>(
        create: (context, index) => TabController(
          length: widget.routes.length,
          initialIndex: index,
          vsync: this,
        ),
        dispose: (context, controller) => controller.dispose(),
        index: (controller) => controller.index,
        onChanged: (controller, index) => controller.animateTo(
          index,
          duration: const Duration(
            milliseconds: 250,
          ),
          curve: Curves.easeInOut,
        ),
        routes: widget.routes,
        equals: widget.equals,
        builder: widget.builder,
      );
}
