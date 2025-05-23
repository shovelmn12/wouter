part of 'delegate.dart';

/// Creates a [WouterAction] function, which serves as the central dispatcher
/// for all navigation actions within the Wouter system.
///
/// This factory function encapsulates the logic for processing push and pop
/// operations, including the invocation of registered interceptor callbacks
/// ([WouterActionsCallbacks]) and delegation to a [StackPolicy] for actual
/// state manipulation.
///
/// - [policy]: The [StackPolicy] instance that defines how the navigation
///   stack is modified (e.g., how paths are built, how entries are pushed/popped).
/// - [getter]: A [ValueGetter<WouterState>] that provides the current router state.
/// - [setter]: A [ValueSetter<WouterState>] used to update the router state
///   after an action is processed.
/// - [getCallbacks]: A [ValueGetter<WouterActionsCallbacks>] that provides the
///   currently registered push and pop interceptor callbacks.
///
/// Returns a [WouterAction] function. When this returned function is called,
/// it takes an action handler, provides it with an [ActionBuilder] (containing
/// the `push` and `pop` implementations below, and the `pathBuilder` from the policy),
/// executes the handler, updates the state via [setter], and returns the result
/// of the action.
WouterAction _createActions(
  StackPolicy policy,
  ValueGetter<WouterState> getter,
  ValueSetter<WouterState> setter,
  ValueGetter<WouterActionsCallbacks> getCallbacks,
) {
  /// Implements the push navigation logic.
  ///
  /// Before actually pushing a route, it iterates through all registered
  /// `push` callbacks from [getCallbacks]. If any callback returns `false`,
  /// the push operation is aborted, and the original [state] is returned
  /// with an empty future.
  /// Otherwise, it delegates the push operation to the provided [policy.push].
  ///
  /// - [state]: The current [WouterState] before the push.
  /// - [path]: The path to navigate to.
  /// - Generic [R]: The expected type of the result when the pushed route is popped.
  ///
  /// Returns a record `(WouterState, Future<R?>)` containing the new state
  /// after the push (or the original state if aborted) and a future for the result.
  (WouterState, Future<R?>) push<R>(WouterState state, String path) {
    // Defines a predicate that checks all registered push callbacks.
    // The push proceeds only if all callbacks return true.
    bool predicate(String path) => getCallbacks()
        .push
        .fold(true, (acc, callback) => acc && callback(path));

    if (!predicate(path)) {
      // If any predicate fails, return current state and a completed future with no value.
      return (state, Future<R>.value());
    }

    // Delegate to the stack policy for the actual push operation.
    return policy.push<R>(
      state,
      path,
    );
  }

  /// Implements the pop navigation logic.
  ///
  /// Before actually popping a route, it iterates through all registered
  /// `pop` callbacks from [getCallbacks]. If any callback returns `false`,
  /// the pop operation is aborted. In this specific implementation, if aborted,
  /// it returns the original [state] and `true` (indicating the pop attempt
  /// was "handled" by being blocked, though this might be counter-intuitive
  /// and depends on the desired behavior of pop predicates).
  /// Otherwise, it delegates the pop operation to the provided [policy.pop].
  ///
  /// - [state]: The current [WouterState] before the pop.
  /// - [result]: An optional dynamic result to pass to the previous route.
  ///
  /// Returns a record `(WouterState, bool)` containing the new state
  /// after the pop (or original state if aborted) and a boolean indicating
  /// success (or if the pop was "handled" by predicates).
  (WouterState, bool) pop(WouterState state, [dynamic result]) {
    // Defines a predicate that checks all registered pop callbacks.
    // The pop proceeds only if all callbacks return true.
    predicate(path, [result]) => getCallbacks()
        .pop
        .fold(true, (acc, callback) => acc && callback(path, result));

    if (!predicate(state.path)) {
      // If any predicate fails, return current state and true.
      // The 'true' here implies the pop was "handled" by being prevented.
      return (state, true);
    }

    // Delegate to the stack policy for the actual pop operation.
    return policy.pop(
      state,
      result,
    );
  }

  // This is the WouterAction function itself.
  // It takes a handler function `action` which defines what to do.
  return <R>(action) {
    // The handler `action` is provided with an ActionBuilder record.
    // This ActionBuilder contains the `push`, `pop` functions defined above,
    // and a `pathBuilder` from the stack policy.
    // The handler also receives the current WouterState via `getter()`.
    // The handler `action` is expected to perform some operations and return
    // a tuple: (the next WouterState, the result of the operation R).
    final (next, result) = action(
      (
        push: push, // The push implementation defined above
        pop: pop, // The pop implementation defined above
        pathBuilder:
            policy.pathBuilder, // Path building utility from the policy
      ),
      getter(), // Current WouterState
    );

    // Update the global WouterState with the `next` state returned by the handler.
    setter(next);

    // Return the `result` of the action.
    return result;
  };
}
