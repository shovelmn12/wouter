import 'package:flutter/widgets.dart';
import 'package:wouter/wouter.dart';

/// A widget that declaratively performs a "replace until" navigation action
/// when it is inserted into the widget tree.
///
/// Upon initialization (after the first frame is built), this widget will
/// instruct the Wouter router to:
/// 1. Pop routes from the current navigation stack until a route satisfying
///    the given [predicate] is found.
/// 2. Then, push the new route specified by [to] onto the stack.
///
/// This is useful for scenarios where you want to navigate to a new section
/// of your app while clearing a specific portion of the back stack, for example,
/// after a login or signup flow, redirecting to a main dashboard and ensuring
/// the login/signup screens are not easily accessible via the back button.
///
/// The widget itself typically renders its [child] (which defaults to an
/// empty [SizedBox.shrink]), as its primary purpose is the navigation side effect.
class ReplaceUntil extends StatefulWidget {
  /// The widget to display. Defaults to [SizedBox.shrink] if primarily used
  /// for its navigation side effect.
  final Widget child;

  /// The path of the new route to push after the pop operations have completed.
  /// This path will be resolved by Wouter (e.g., relative to the current context if applicable).
  final String to;

  /// A function that determines when to stop popping routes.
  /// It receives the path of each route being considered for popping.
  /// Popping stops *before* the route for which this predicate returns `true`.
  final bool Function(String) predicate;

  /// An optional function to provide a result for each route that is popped
  /// during the "pop until" phase.
  /// It receives the path of the route being popped and should return the result
  /// for that specific pop.
  final dynamic Function(String)? result;

  /// Creates a [ReplaceUntil] widget.
  ///
  /// - [key]: An optional key for the widget.
  /// - [to]: Required. The target path to navigate to after popping.
  /// - [predicate]: Required. The predicate to determine how many routes to pop.
  /// - [result]: Optional. A function to provide results for popped routes.
  /// - [child]: The widget to render. Defaults to `SizedBox.shrink()`.
  const ReplaceUntil({
    super.key,
    required this.to,
    required this.predicate,
    this.result,
    this.child = const SizedBox.shrink(),
  });

  @override
  State<ReplaceUntil> createState() => _ReplaceUntilState();
}

class _ReplaceUntilState extends State<ReplaceUntil> {
  @override
  void initState() {
    super.initState();
    // Schedule the replaceUntil action to be performed after the current frame
    // has finished building. This ensures that the context is fully available
    // and avoids issues with modifying the widget tree during a build phase.
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        // Check if the widget is still mounted before attempting navigation,
        // as the callback might fire after the widget has been disposed.
        if (mounted) {
          context.wouter.actions.replaceUntil(
            widget.to,
            widget.predicate,
            widget.result,
          );
        }
      },
    );
  }

  /// Builds the widget, returning the [child] provided to the [ReplaceUntil] widget.
  @override
  Widget build(BuildContext context) => widget.child;
}
