import '../delegate/delegate.dart';
import '../models/models.dart';

extension RoutingActionsExtensions<T extends WouterDelegateState>
    on RoutingActions<T> {
  void popUntil(PopPredicate<String> predicate) {
    if (hasParent) {
      return parent!.popUntil(predicate);
    }

    update((state) {
      final prevState = policy.onPop(state);

      if (predicate(prevState.fullPath)) {
        return prevState;
      }
    });
  }
}
