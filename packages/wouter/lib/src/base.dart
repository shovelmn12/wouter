import '../wouter.dart';
import 'delegate/delegate.dart';

abstract class BaseWouter {
  bool get canPop;

  Stream<List<String>> get stream;

  PathMatcher get matcher;

  String get base;

  const factory BaseWouter.root({
    required WouterBaseRouterDelegate delegate,
  }) = RootWouter;

  Future<R?> push<R>(String path);

  bool pop([dynamic result]);

  void reset([String path = "/"]);
}

class RootWouter implements BaseWouter {
  final WouterBaseRouterDelegate delegate;

  @override
  bool get canPop => delegate.canPop;

  @override
  Stream<List<String>> get stream => delegate.stream
      .map((stack) => stack.map((entry) => entry.path).toList())
      .distinct();

  @override
  PathMatcher get matcher => delegate.matcher;

  @override
  String get base => "";

  const RootWouter({
    required this.delegate,
  });

  Future<R?> push<R>(String path) => delegate.push(path);

  bool pop([dynamic result]) => delegate.pop(result);

  void reset([String path = "/"]) => delegate.reset(path);
}

mixin ChildWouter implements BaseWouter {
  BaseWouter get parent;

  @override
  bool get canPop => parent.canPop;

  @override
  PathMatcher get matcher;

  @override
  Stream<List<String>> get stream => parent.stream
      .map((stack) => stack
          .where((path) => path.startsWith(base))
          .map((path) => path.substring(base.length))
          .map((path) => path.isEmpty ? "/" : path)
          .toList())
      .distinct();

  Future<R?> push<R>(String path) => parent.push("$base$path");

  bool pop([dynamic result]) => parent.pop(result);

  void reset([String path = "/"]) => parent.reset("$base$path");
}
