import 'package:flutter/material.dart';
import 'package:wouter/wouter.dart';

/// A widget that synchronizes a `PageController` (and by extension, typically a
/// `PageView`) with Wouter's navigation state.
///
/// `WouterPage` is a specialized convenience widget built on top of
/// [WouterListenable]. It simplifies the setup for creating swipeable page
/// views where each page corresponds to a distinct Wouter route.
///
/// When a user swipes to a new page in the `PageView` managed by the
/// `PageController`, `WouterPage` updates the Wouter route. Conversely, when
/// the Wouter route changes (e.g., via browser navigation or programmatic
/// navigation), `WouterPage` updates the currently displayed page in the
/// `PageView`.
///
/// The [builder] function is responsible for constructing the UI, usually
/// involving a `PageView` that uses the provided `PageController`.
class WouterPage extends StatelessWidget {
  /// A map where keys are route path segments (relative to this widget's
  /// position in the routing tree) and values are the [Widget]s to be
  /// displayed as pages in the `PageView`.
  final Map<String, Widget> routes;

  /// A builder function that constructs the UI.
  /// It receives the [BuildContext], the `PageController` instance, and a
  /// list of child widgets (derived from `this.routes.values`).
  /// This is typically used to build a `PageView`.
  ///
  /// Example:
  /// ```dart
  /// builder: (context, pageController, pages) => PageView(
  ///   controller: pageController,
  ///   children: pages,
  /// ),
  /// ```
  final WouterListenableWidgetBuilder<PageController> builder;

  /// Creates a [WouterPage] widget.
  ///
  /// - [key]: An optional key for the widget.
  /// - [routes]: Required. A map defining the route paths and their
  ///   corresponding page widgets.
  /// - [builder]: Required. A function to build the UI, typically including
  ///   a `PageView`.
  const WouterPage({
    super.key,
    required this.routes,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) => WouterListenable<PageController>(
        // Creates a PageController, initializing it to the page
        // corresponding to the current Wouter route.
        create: (context, index) => PageController(
          initialPage: index,
        ),
        // Disposes the PageController when the widget is removed.
        dispose: (context, controller) => controller.dispose(),
        // Gets the current page index from the PageController.
        // `page` can be a double during transitions, so it's rounded.
        index: (controller) => controller.page?.round(),
        // When Wouter's route changes to a new index, animate the
        // PageController to that page.
        onChanged: (controller, index) => controller.animateToPage(
          index,
          duration: const Duration(
            milliseconds: 250, // Default animation duration
          ),
          curve: Curves.easeInOut, // Default animation curve
        ),
        // The route definitions and their corresponding page widgets.
        routes: routes,
        // The builder function provided by the user to construct the UI.
        builder: builder,
        // Converts a Wouter path to a page index.
        // It finds the first route key in `routes` that the current Wouter `path`
        // starts with. Handles the root path "/" as a special case.
        toIndex: (base, path, routeKeys) {
          // `routeKeys` is `this.routes.keys.toList()`
          final result = routeKeys.indexWhere((routeKey) {
            if (routeKey == "/") {
              // If the route key is "/", match only if the Wouter path is also exactly "/".
              // This assumes the Wouter path `path` here is relative to `base`.
              // A more robust check might consider if `path == base` or `path == base + "/"`.
              // Given typical WouterListenable usage, `path` is often `fullPath`.
              // If `path` is `state.fullPath`, then for root it would be "$base/" or just "$base".
              // For now, documenting based on provided logic.
              return path ==
                  "/"; // This seems to imply `path` is relative or `base` is empty.
              // Or `path` is the *segment* after `base`.
            }
            // For other route keys, check if the Wouter path starts with the route key.
            // This logic assumes route keys are prefixes.
            return path.startsWith(routeKey);
          });

          if (result < 0) {
            return null; // No matching route key found for the current Wouter path.
          }
          return result; // Return the index of the matched route key.
        },
        // Converts a page index back to a Wouter path.
        // It constructs the target Wouter path using the `base` path and the
        // route key corresponding to the `index`.
        toPath: (index, base, currentFullPath, routeKeys) {
          final routeKeyForIndex = routeKeys[index];

          // Construct the target path.
          final targetPath = "$base$routeKeyForIndex";

          // If the current Wouter full path already matches or starts with the target path,
          // return null to prevent unnecessary navigation (avoids a navigation loop).
          if (currentFullPath == targetPath ||
              currentFullPath.startsWith(targetPath)) {
            // A more precise check might be `currentFullPath == targetPath` if `routeKeyForIndex`
            // is meant to be a full segment match rather than a prefix for further nesting.
            return null;
          }

          return targetPath; // Return the Wouter path for the new page index.
        },
      );
}
