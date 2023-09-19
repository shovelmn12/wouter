// import 'dart:async';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
//
// import '../models/models.dart';
// import 'delegate.dart';
//
// /// A base delegate that is used by the [Router] widget to build and configure a navigating widget.
// abstract class BaseRouterDelegate extends RouterDelegate<Uri>
//     with ChangeNotifier, StateChangeNotifier<List<RouteEntry>> {
//   /// The widget below this widget in the tree.
//   Widget get child;
//
//   /// Routing policy for the delegate
//   RoutingPolicy<List<RouteEntry>> get policy;
//
//   @override
//   Uri? get currentConfiguration;
//
//   /// Returns [currentConfiguration] as String, when null returns "" (empty String)
//   String get path => "${currentConfiguration ?? ""}";
//
//   String get base => "";
//
//   /// Whether it is possible to [pop].
//   bool get canPop;
//
//   /// Push a [path].
//   ///
//   /// Returns a Future that completes to the result value passed to pop when the pushed route is popped off the navigator.
//   ///
//   ///The T type argument is the type of the return value of the route.
//   ///
//   Future<R?> push<R>(String path) {
//     final completer = Completer<R?>();
//
//     state = policy.onPush(
//       policy.pushPath(
//         this.path,
//         policy.buildPath(base, path),
//       ),
//       state,
//       policy.buildOnResultCallback(completer),
//     );
//
//     return completer.future;
//   }
//
//   /// Pop the history stack.
//   /// Returns [canPop] before popping.
//   bool pop([dynamic result]) {
//     if (state.isNotEmpty) {
//       state = policy.onPop(state, result);
//
//       return true;
//     }
//
//     return false;
//   }
//
//   /// Resets the state as if only [path] been pushed.
//   void reset([String? path]) {
//     state.forEach((route) => route.onResult?.call(null));
//
//     state = policy.onReset(
//       policy.pushPath(
//         this.path,
//         policy.buildPath(base, path ?? ""),
//       ),
//     );
//   }
//
//   void update(List<RouteEntry> Function(List<RouteEntry> state) callback) =>
//       state = callback(state);
//
//   /// Calling [pop]
//   @override
//   Future<bool> popRoute() => Future.value(pop());
//
//   /// Calling [reset]
//   @override
//   Future<void> setNewRoutePath(Uri uri) =>
//       SynchronousFuture(reset(uri.toString()));
//
//   /// Called by the [Router] to obtain the widget tree that represents the current state.
//   ///
//   /// The context is the [Router]'s build context.
//   @override
//   Widget build(BuildContext context) => child;
// }
