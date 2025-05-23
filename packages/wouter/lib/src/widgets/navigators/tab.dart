import 'package:flutter/material.dart';
import 'package:wouter/wouter.dart';

/// A widget that synchronizes a `TabController` (and typically a `TabBar` and
/// `TabBarView`) with Wouter's navigation state.
///
/// `WouterTab` is a specialized convenience widget built upon [WouterListenable].
/// It simplifies the creation of tabbed interfaces where each tab corresponds
/// to a distinct Wouter route.
///
/// It facilitates two-way synchronization:
/// 1.  **User Tab Interaction to Wouter**: When the user selects a new tab,
///     `WouterTab` updates Wouter's current route to reflect this change.
/// 2.  **Wouter Route Change to Tabs**: When Wouter's route changes (e.g., due
///     to browser navigation or programmatic navigation), `WouterTab` updates
///     the active tab in the `TabBar`/`TabBarView`.
///
/// This widget requires `SingleTickerProviderStateMixin` for the `TabController`'s
/// `vsync` property. The [builder] function is responsible for constructing the
/// UI, usually involving a `TabBar` and `TabBarView` that use the provided
/// `TabController`.
class WouterTab extends StatefulWidget {
  /// A map where keys are route path segments (relative to this widget's
  /// position in the routing tree) and values are the [Widget]s to be
  /// displayed as the content for each tab.
  final Map<String, Widget> routes;

  /// A builder function that constructs the UI.
  /// It receives the [BuildContext], the `TabController` instance, and a
  /// list of child widgets (derived from `this.routes.values`).
  /// This is typically used to build a `Scaffold` with a `TabBar` and `TabBarView`.
  ///
  /// Example:
  /// ```dart
  /// builder: (context, tabController, tabContentPages) {
  ///   return Scaffold(
  ///     appBar: AppBar(
  ///       title: Text('Tabs Demo'),
  ///       bottom: TabBar(
  ///         controller: tabController,
  ///         tabs: widget.routes.keys.map((key) => Tab(text: key)).toList(),
  ///       ),
  ///     ),
  ///     body: TabBarView(
  ///       controller: tabController,
  ///       children: tabContentPages,
  ///     ),
  ///   );
  /// }
  /// ```
  final WouterListenableWidgetBuilder<TabController> builder;

  /// Creates a [WouterTab] widget.
  ///
  /// - [key]: An optional key for the widget.
  /// - [routes]: Required. A map defining the route paths and their
  ///   corresponding tab content widgets. The number of entries in this map
  ///   determines the number of tabs.
  /// - [builder]: Required. A function to build the UI, typically including
  ///   a `TabBar` and `TabBarView`.
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
  /// Called when the widget configuration changes.
  @override
  void didUpdateWidget(covariant WouterTab oldWidget) {
    setState(() {});

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) => WouterListenable<TabController>(
        // Creates a TabController.
        // `vsync: this` uses the SingleTickerProviderStateMixin from _WouterTabState.
        // `initialIndex` is determined by the current Wouter route.
        // `length` is the number of defined routes/tabs.
        create: (context, index) => TabController(
          length: widget.routes.length,
          initialIndex: index,
          vsync: this,
        ),
        // Disposes the TabController when the widget is removed.
        dispose: (context, controller) => controller.dispose(),
        // Gets the current tab index from the TabController.
        index: (controller) => controller.index,
        // When Wouter's route changes to a new index, animate the
        // TabController to that tab.
        onChanged: (controller, index) => controller.animateTo(
          index,
          duration: const Duration(
            milliseconds: 250, // Default animation duration
          ),
          curve: Curves.easeInOut, // Default animation curve
        ),
        // The route definitions and their corresponding tab content widgets.
        routes: widget.routes,
        // The builder function provided by the user to construct the UI.
        builder: widget.builder,
        // Converts a Wouter path to a tab index.
        // It finds the index of the first route key from `widget.routes.keys`
        // for which the current Wouter path (`path`, typically `state.fullPath`)
        // starts with the concatenation of `base` and that `routeKey`.
        toIndex: (base, path, routeKeys) {
          // `routeKeys` is `widget.routes.keys.toList()`
          final result = routeKeys
              .indexWhere((routeKey) => path.startsWith("$base$routeKey"));

          if (result < 0) {
            return null; // No matching route key found for the current Wouter path.
          }
          return result; // Return the index of the matched route key.
        },
        // Converts a tab index back to a Wouter path.
        // It constructs the target Wouter path using the `base` path and the
        // route key corresponding to the `index`.
        // If the current Wouter path already matches or starts with this target
        // path, it returns `null` to prevent redundant navigation.
        toPath: (index, base, currentWouterPath, routeKeys) {
          final routeKeyForIndex = routeKeys[index];
          final targetPath = "$base$routeKeyForIndex";

          // Avoid navigation if already at or under the target path.
          if (currentWouterPath == targetPath ||
              currentWouterPath.startsWith(targetPath)) {
            return null;
          }

          return targetPath; // Return the Wouter path for the new tab index.
        },
      );
}
