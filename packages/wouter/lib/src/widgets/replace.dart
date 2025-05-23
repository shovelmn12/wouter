import 'package:flutter/widgets.dart';
import 'package:wouter/wouter.dart';

/// A widget that declaratively performs a "replace" navigation action
/// when it is inserted into the widget tree.
///
/// Upon initialization (after the first frame is built), this widget will
/// instruct the Wouter router to replace the current route with the new
/// route specified by [to]. This is equivalent to popping the current
/// route and then immediately pushing the new route.
///
/// This is useful for scenarios like redirecting after an action (e.g.,
/// form submission) where you don't want the previous page to be in
/// the back stack.
///
/// The widget itself typically renders its [child] (which defaults to an
/// empty [SizedBox.shrink]), as its primary purpose is the navigation side effect.
class Replace extends StatefulWidget {
  /// The widget to display. Defaults to [SizedBox.shrink] if primarily used
  /// for its navigation side effect.
  final Widget child;

  /// The path of the new route to navigate to, replacing the current route.
  /// This path will be resolved by Wouter (e.g., relative to the current context if applicable).
  final String to;

  /// Creates a [Replace] widget.
  ///
  /// - [key]: An optional key for the widget.
  /// - [to]: Required. The target path to navigate to, replacing the current route.
  /// - [child]: The widget to render. Defaults to `SizedBox.shrink()`.
  const Replace({
    super.key,
    required this.to,
    this.child = const SizedBox.shrink(),
  });

  @override
  State<Replace> createState() => _ReplaceState();
}

class _ReplaceState extends State<Replace> {
  @override
  void initState() {
    super.initState();
    // Schedule the replace action to be performed after the current frame
    // has finished building. This ensures that the context is fully available
    // and avoids issues with modifying the widget tree during a build phase.
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        // Check if the widget is still mounted before attempting navigation,
        // as the callback might fire after the widget has been disposed.
        if (mounted) {
          context.wouter.actions.replace(widget.to);
        }
      },
    );
  }

  /// Builds the widget, returning the [child] provided to the [Replace] widget.
  @override
  Widget build(BuildContext context) => widget.child;
}
