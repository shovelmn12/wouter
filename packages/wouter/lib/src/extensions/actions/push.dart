import 'package:wouter/wouter.dart';

extension PushWouterActionExtension on WouterAction {
  Future<R?> push<R>(String path) => this((actions, state) => actions.push<R>(
        state,
        actions.pathBuilder(state.fullPath, path),
      ));
}
