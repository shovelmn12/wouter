import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

class WouterConfig extends RouterConfig<String> {
  WouterConfig._({
    required super.routerDelegate,
    required super.backButtonDispatcher,
    required super.routeInformationParser,
    required super.routeInformationProvider,
  });

  factory WouterConfig({
    PathMatcherBuilder? matcher,
    RoutingPolicy policy = const URLRoutingPolicy(),
    String base = "",
    required WidgetBuilder builder,
  }) {
    final pathSubject = BehaviorSubject<String>();
    final popSubject = BehaviorSubject<bool Function()>();

    return WouterConfig._(
      routerDelegate: WouterRouterDelegate(
        matcher: matcher,
        policy: policy,
        base: base,
        onPathChanged: pathSubject.add,
        popSetter: popSubject.add,
        builder: (context) => _Dispose(
          onDispose: () {
            pathSubject.close();
            popSubject.close();
          },
          builder: builder,
        ),
      ),
      backButtonDispatcher: WouterBackButtonDispatcher(
        onPop: () => SynchronousFuture(popSubject.valueOrNull?.call() ?? false),
      ),
      routeInformationParser: const WouterRouteInformationParser(),
      routeInformationProvider: WouterRouteInformationProvider(
        pathSubject: pathSubject,
      ),
    );
  }
}

class _Dispose extends StatefulWidget {
  final VoidCallback onDispose;
  final WidgetBuilder builder;

  const _Dispose({
    required this.onDispose,
    required this.builder,
  });

  @override
  State<_Dispose> createState() => _DisposeState();
}

class _DisposeState extends State<_Dispose> {
  @override
  void dispose() {
    widget.onDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Builder(
        builder: widget.builder,
      );
}
