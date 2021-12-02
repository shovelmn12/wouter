import '../../wouter.dart';
import '../base.dart';

extension BaseWouterExtensions on BaseWouter {
  void popUntil(PopPredicate<String> predicate) {
    switch (runtimeType) {
      case ChildWouter:
        return (this as ChildWouter).parent.popUntil(predicate);

      case RootWouter:
        return (this as RootWouter).delegate.popUntil(predicate);

      default:
        throw UnsupportedError("Wouter can be only ChildWouter or RootWouter");
    }
  }

  void popTo(String path) {
    switch (runtimeType) {
      case ChildWouter:
        return (this as ChildWouter).parent.popTo(path);

      case RootWouter:
        return (this as RootWouter).delegate.popTo(path);

      default:
        throw UnsupportedError("Wouter can be only ChildWouter or RootWouter");
    }
  }

  Future<T> replace<T>(String path, [dynamic result]) {
    switch (runtimeType) {
      case ChildWouter:
        return (this as ChildWouter).parent.replace(path, result);

      case RootWouter:
        return (this as RootWouter).delegate.replace(path, result);

      default:
        return Future.error(
          UnsupportedError("Wouter can be only ChildWouter or RootWouter"),
        );
    }
  }
}
