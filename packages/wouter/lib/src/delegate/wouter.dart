// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../base.dart';
// import '../models/models.dart';
// import 'delegate.dart';
//
// /// A delegate that is used by the [Router] widget to build and configure a navigating widget.
// abstract class WouterBaseRouterDelegate extends BaseRouterDelegate
//     with ValueStateChangeNotifier<List<RouteEntry>>, RootWouter {
//   final String tag;
//
//   @override
//   final RoutingPolicy<List<RouteEntry>> policy;
//
//   @override
//   final Widget child;
//
//   @override
//   final PathMatcher matcher;
//
//   @override
//   @protected
//   final List<RouteEntry> initialState;
//
//   final String base;
//
//   @override
//   List<String> get stack =>
//       List<String>.unmodifiable(state.map((entry) => entry.path));
//
//   //only parent update uri
//   @override
//   Uri? get currentConfiguration => Uri.parse(state.last.path);
//
//   @override
//   bool get canPop => state.length > 1;
//
//   @override
//   set state(List<RouteEntry> state) {
//     super.state = List<RouteEntry>.unmodifiable(state);
//   }
//
//   WouterBaseRouterDelegate({
//     required this.child,
//     this.policy = const URLRoutingPolicy(),
//     this.tag = "",
//     this.base = "",
//     this.initialState = const [],
//     PathMatcherBuilder matcher = PathMatchers.regexp,
//     String initial = "/",
//   })  : matcher = matcher(),
//         super() {
//     state = [
//       RouteEntry(
//         path: initial,
//       ),
//     ];
//   }
//
//   @override
//   bool shouldNotify(List<RouteEntry> prev, List<RouteEntry> next) {
//     if (prev.isNotEmpty && next.isNotEmpty) {
//       return prev.last.path != next.last.path;
//     }
//
//     return true;
//   }
//
//   @override
//   Widget build(BuildContext context) =>
//       ChangeNotifierProvider<BaseWouter>.value(
//         value: this,
//         child: super.build(context),
//       );
// }
