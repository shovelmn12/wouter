part of 'delegate.dart';

WouterAction _createActions(
  StackPolicy policy,
  ValueGetter<WouterState> getter,
  ValueSetter<WouterState> setter,
  ValueGetter<WouterActionsCallbacks> getCallbacks,
) {
  (WouterState, Future<R?>) push<R>(WouterState state, String path) {
    bool predicate(String path) => getCallbacks()
        .push
        .fold(true, (acc, callback) => acc && callback(path));

    if (!predicate(path)) {
      return (state, Future<R>.value());
    }

    return policy.push<R>(
      state,
      path,
    );
  }

  (WouterState, bool) pop(WouterState state, [dynamic result]) {
    predicate(path, [result]) => getCallbacks()
        .pop
        .fold(true, (acc, callback) => acc && callback(path, result));

    if (!predicate(state.path)) {
      return (state, true);
    }

    return policy.pop(
      state,
      result,
    );
  }

  return <R>(action) {
    final (next, result) = action(
      (
        push: push,
        pop: pop,
        pathBuilder: policy.pathBuilder,
      ),
      getter(),
    );

    setter(next);

    return result;
  };
}
