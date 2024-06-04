import 'package:wouter/wouter.dart';

extension PopWouterActionExtension on WouterAction {
  bool pop([dynamic result]) => this((actions, state) => actions.pop(state));
}
