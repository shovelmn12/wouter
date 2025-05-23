import 'package:flutter/widgets.dart';
import 'package:wouter/wouter.dart';

/// A widget that declaratively performs a "reset" navigation action
/// when it is inserted into the widget tree.
///
/// Upon initialization (after the first frame is built), this widget will
/// instruct the Wouter router to clear the entire current navigation stack
/// and then build a new stack based on the list of paths provided in [to].
///
/// This is useful for scenarios where you need to completely redefine the
/// navigation history, such as:
/// - After a user logs out, redirecting to a login screen with no prior history.
/// - Navigating to a deep-linked state that requires a specific back stack.
/// - Programmatically setting up an initial stack for the application.
///
/// The widget itself typically renders its [child] (which defaults to an
/// empty [SizedBox.shrink]), as its primary purpose is the navigation side effect.
class Reset extends StatefulWidget {
  /// The widget to display. Defaults to [SizedBox.shrink] if primarily used
  /// for its navigation side effect.
  final Widget child;

  /// A list of paths that will form the new navigation stack.
  /// The Wouter router will clear its current stack and then push each of these
  /// paths in order. Paths will be resolved by Wouter (e.g., relative paths
  /// are resolved against the current context before the reset operation).
  final List<String> to;

  /// Creates a [Reset] widget.
  ///
  /// - [key]: An optional key for the widget.
  /// - [to]: Required. A list of paths defining the new navigation stack.
  /// - [child]: The widget to render. Defaults to `SizedBox.shrink()`.
  const Reset({
    super.key,
    required this.to,
    this.child = const SizedBox.shrink(),
  });

  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  @override
  void initState() {
    super.initState();
    // Schedule the reset action to be performed after the current frame
    // has finished building. This ensures that the context is fully available
    // and avoids issues with modifying the widget tree during a build phase.
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        // Check if the widget is still mounted before attempting navigation,
        // as the callback might fire after the widget has been disposed.
        if (mounted) {
          context.wouter.actions.reset(widget.to);
        }
      },
    );
  }

  /// Builds the widget, returning the [child] provided to the [Reset] widget.
  @override
  Widget build(BuildContext context) => widget.child;
}
