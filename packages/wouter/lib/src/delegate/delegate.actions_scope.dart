part of 'delegate.dart';

/// An internal [StatelessWidget] used by [WouterRouterDelegate] to provide
/// mechanisms for adding and removing push/pop action interceptor callbacks.
///
/// This widget itself doesn't render anything visually different but acts as a
/// conduit for the callback registration functions passed down from the
/// [WouterRouterDelegate] to the [WouterActionsScope] widget.
/// It's not intended for direct public use.
class _WouterActionsScope extends StatelessWidget {
  /// Callback to add a push interceptor.
  final ValueSetter<bool Function(String)> addPush;

  /// Callback to remove a push interceptor.
  final ValueSetter<bool Function(String)> removePush;

  /// Callback to add a pop interceptor.
  final ValueSetter<bool Function(String, [dynamic])> addPop;

  /// Callback to remove a pop interceptor.
  final ValueSetter<bool Function(String, [dynamic])> removePop;

  /// The child widget.
  final Widget child;

  /// Creates an [_WouterActionsScope].
  ///
  /// All parameters are required and are typically provided by the
  /// [WouterRouterDelegate].
  const _WouterActionsScope({
    required this.addPush,
    required this.removePush,
    required this.addPop,
    required this.removePop,
    required this.child,
  });

  /// Builds the widget by simply returning its [child].
  /// The primary purpose of this widget is to be found via `context.findAncestorWidgetOfExactType`
  /// by [WouterActionsScopeState].
  @override
  Widget build(BuildContext context) => child;
}

/// A widget that allows descendant widgets to register interceptor callbacks
/// for Wouter's push and pop navigation actions.
///
/// When [onPush] or [onPop] callbacks are provided, they are registered with
/// the Wouter routing system. These callbacks are invoked before a push or pop
/// action is executed, respectively. They can prevent the action by returning
/// `false`.
///
/// If a callback is not provided or if it returns `true`, the navigation
/// action proceeds as usual.
///
/// Callbacks are automatically unregistered when this widget is disposed.
///
/// Example:
/// ```dart
/// WouterActionsScope(
///   onPush: (path) {
///     if (path == '/restricted') {
///       print('Push to /restricted prevented!');
///       return false; // Prevent navigation
///     }
///     return true; // Allow navigation
///   },
///   child: MyAppPages(),
/// )
/// ```
class WouterActionsScope extends StatefulWidget {
  /// An optional callback invoked before a "push" navigation action.
  ///
  /// It receives the `String` path being pushed to.
  /// If it returns `false`, the push action is prevented.
  /// If it returns `true` or is `null`, the push action proceeds.
  final bool Function(String)? onPush;

  /// An optional callback invoked before a "pop" navigation action.
  ///
  /// It receives the `String` path of the route being popped from and an
  /// optional `dynamic` result.
  /// If it returns `false`, the pop action is prevented.
  /// If it returns `true` or is `null`, the pop action proceeds.
  final bool Function(String, [dynamic])? onPop;

  /// The child widget to which this scope applies.
  final Widget child;

  /// Creates a [WouterActionsScope].
  ///
  /// - [key]: Optional widget key.
  /// - [onPush]: Optional callback to intercept push actions.
  /// - [onPop]: Optional callback to intercept pop actions.
  /// - [child]: The widget below this scope in the tree.
  const WouterActionsScope({
    super.key,
    this.onPush,
    this.onPop,
    required this.child,
  });

  @override
  State<WouterActionsScope> createState() => _WouterActionsScopeState();
}

/// The state for [WouterActionsScope].
///
/// This state class handles the registration and unregistration of the
/// [onPush] and [onPop] callbacks with the Wouter routing system. It
/// finds the [_WouterActionsScope] ancestor to access the add/remove
/// callback functions provided by the [WouterRouterDelegate].
class _WouterActionsScopeState extends State<WouterActionsScope> {
  /// The ancestor [_WouterActionsScope] instance, used to access
  /// callback registration functions.
  late final _WouterActionsScope _scope =
      context.findAncestorWidgetOfExactType<_WouterActionsScope>()!;

  @override
  void initState() {
    super.initState();
    // Register the provided (or default) onPush and onPop callbacks.
    _scope.addPush(_onPush);
    _scope.addPop(_onPop);
  }

  @override
  void dispose() {
    // Unregister the callbacks when the widget is disposed.
    _scope.removePush(_onPush);
    _scope.removePop(_onPop);
    super.dispose();
  }

  /// Internal handler for push actions.
  /// Calls the user-provided [widget.onPush] if available, otherwise defaults to `true`.
  bool _onPush<T>(String path) => widget.onPush?.call(path) ?? true;

  /// Internal handler for pop actions.
  /// Calls the user-provided [widget.onPop] if available, otherwise defaults to `true`.
  bool _onPop(String path, [dynamic result]) =>
      widget.onPop?.call(path, result) ?? true;

  /// Builds the widget by simply returning its [widget.child].
  /// The functionality is managed in [initState] and [dispose].
  @override
  Widget build(BuildContext context) => widget.child;
}
