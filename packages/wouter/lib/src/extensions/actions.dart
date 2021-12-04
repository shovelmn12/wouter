import '../../wouter.dart';
import '../base.dart';

extension BaseWouterExtensions on BaseWouter {
  void popUntil(PopPredicate<String> predicate) => type.map(
        root: (wouter) => wouter.delegate.popUntil(predicate),
        child: (wouter) => wouter.parent.popUntil(predicate),
      );

  void popTo(String path) => type.map(
        root: (wouter) => wouter.delegate.popTo(
          wouter.policy.pushPath(base, path),
        ),
        child: (wouter) => wouter.parent.popTo(
          wouter.policy.buildPath(base, path),
        ),
      );

  Future<T> replace<T>(String path, [dynamic result]) => type.map(
        root: (wouter) => wouter.delegate.replace(
          wouter.policy.pushPath(
            wouter.route,
            wouter.policy.buildPath(base, path),
          ),
          result,
        ),
        child: (wouter) => wouter.parent.replace(
          wouter.policy.buildPath(base, path),
          result,
        ),
      );
}
