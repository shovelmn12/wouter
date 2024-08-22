import 'package:wouter/wouter.dart';

extension PopWouterActionExtension on WouterAction {
  bool pop([dynamic result]) => this((actions, state) {
        if (!state.canPop) {
          return (state, false);
        }

        return actions.pop(state);
      });
}
