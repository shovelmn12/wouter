part of 'model.dart';

extension WouterDelegateStateExtension on WouterDelegateState {
  bool get canPop => (stack.length > 1);

  RouteHistory get route => stack.last;

  String get fullPath => '$base$path';

  Uri get uri => Uri.parse(fullPath);
}
