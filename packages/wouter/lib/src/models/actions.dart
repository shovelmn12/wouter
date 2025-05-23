import 'dart:async';

import 'package:wouter/wouter.dart';

/// Defines the signature for a "push" navigation action.
///
/// A push action typically navigates to a new route, adding it to the
/// navigation stack.
///
/// - Generic Type `<R>`: Represents the potential type of the result that might
///   be returned when the pushed route is eventually popped.
/// - Parameters:
///   - `WouterState`: The current state of the Wouter router before the push.
///   - `String`: The path or route name to navigate to.
/// - Returns: A record `(WouterState, Future<R?>)` containing:
///   - The new `WouterState` after the push operation has been processed.
///   - A `Future<R?>` that will complete with the result when the pushed
///     route is popped. If the route is popped without a result, or if the
///     navigation system doesn't support results for this push, it might
///     complete with `null`.
typedef PushAction = (WouterState, Future<R?>) Function<R>(WouterState, String);

/// Defines the signature for a "pop" navigation action.
///
/// A pop action typically removes the current route from the navigation stack,
/// returning to the previous route.
///
/// - Parameters:
///   - `WouterState`: The current state of the Wouter router before the pop.
///   - `[dynamic result]`: An optional result to pass back to the route
///     that is being revealed by this pop operation.
/// - Returns: A record `(WouterState, bool)` containing:
///   - The new `WouterState` after the pop operation has been processed.
///   - A `bool` indicating whether the pop operation was successful (e.g.,
///     `true` if a route was actually popped, `false` if there was nothing to pop).
typedef PopAction = (WouterState, bool) Function(WouterState, [dynamic]);

/// A record type that bundles core navigation actions and utilities.
///
/// This structure is likely passed to components or callbacks that need to
/// perform navigation, providing them with a consistent API for:
/// - Pushing new routes ([push]).
/// - Popping current routes ([pop]).
/// - Building paths ([pathBuilder]), presumably for constructing route strings
///   with parameters.
typedef ActionBuilder = ({
  PushAction push,
  PopAction pop,
  PathBuilder pathBuilder, // Assuming PathBuilder is defined elsewhere
});

/// Defines a higher-order function type for executing a Wouter navigation action.
///
/// This type represents a function that takes another function (a "handler")
/// as an argument. The handler is responsible for defining the actual
/// navigation logic using the provided [ActionBuilder] and current [WouterState].
///
/// - Generic Type `<R>`: Represents the result type of the navigation action
///   being performed by the handler.
/// - Parameter:
///   - `(WouterState, R) Function(ActionBuilder, WouterState) handler`:
///     A function that:
///       - Receives an [ActionBuilder] (to perform push/pop) and the
///         current `WouterState`.
///       - Performs some navigation logic.
///       - Returns a record `(WouterState, R)`: the updated `WouterState`
///         after the action, and the result `R` of the action.
/// - Returns: `R` - The result obtained from executing the `handler` function.
///
/// This pattern allows for abstracting the execution of navigation logic,
/// potentially managing state updates or side effects centrally.
///
/// Example (conceptual):
/// ```dart
/// // WouterAction dispatcher;
/// // String targetPath = "/user/123";
///
/// // Schedule a push action
/// Future<String?> navigationResult = dispatcher<Future<String?>>(
///   (actions, currentState) {
///     // Use actions.push, actions.pop, or actions.pathBuilder here
///     var (newState, pushFuture) = actions.push<String>(currentState, targetPath);
///     return (newState, pushFuture);
///   },
/// );
/// ```
typedef WouterAction = R Function<R>(
  (WouterState, R) Function(ActionBuilder, WouterState),
);

/// A record type for registering callbacks that can intercept or observe
/// Wouter navigation actions.
///
/// This allows for middleware-like behavior, where custom logic can be
/// executed before or after a push or pop action, potentially modifying
/// the action or preventing it.
///
/// - `push`: A list of callback functions invoked when a "push" action occurs.
///   - Each callback receives the `String` path being pushed to.
///   - It returns a `bool`. This boolean might indicate:
///     - `true`: if the callback handled the event and further processing
///               (including the actual push) should be skipped or modified.
///     - `false`: if the push should proceed as normal.
///     (The exact meaning of the boolean depends on the Wouter implementation).
///
/// - `pop`: A list of callback functions invoked when a "pop" action occurs.
///   - Each callback receives:
///     - `String`: The path of the route being popped from.
///     - `[dynamic result]`: The optional result being passed during the pop.
///   - It returns a `bool`. Similar to `push` callbacks, this might control
///     the pop behavior.
typedef WouterActionsCallbacks = ({
  List<bool Function(String)> push,
  List<bool Function(String, [dynamic])> pop,
});
