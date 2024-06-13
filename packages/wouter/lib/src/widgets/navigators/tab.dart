import 'package:flutter/material.dart';
import 'package:wouter/wouter.dart';

class WouterTab extends StatefulWidget {
  final Map<String, Widget> routes;
  final WouterListenableWidgetBuilder<TabController> builder;

  const WouterTab({
    super.key,
    required this.routes,
    required this.builder,
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
        builder: widget.builder,
        toIndex: (base, path, routes) {
          final result =
              routes.indexWhere((route) => path.startsWith("$base$route"));

          if (result < 0) {
            return null;
          }

          return result;
        },
        toPath: (index, base, path, routes) {
          final route = routes[index];

          if (path == "$base$route" || path.startsWith("$base$route")) {
            return null;
          }

          return "$base$route";
        },
      );
}
