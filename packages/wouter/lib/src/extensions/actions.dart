import '../../wouter.dart';
import '../wouter.dart';

extension RoutingActionsExtensions on RoutingActions {
  void popUntil(PopPredicate<String> predicate) => router.popUntil(predicate);

  void popTo(String path) => router.popTo(path);

  Future<T> replace<T>(String path, [dynamic result]) =>
      router.replace(path, result);
}
