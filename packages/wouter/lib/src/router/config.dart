import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wouter/wouter.dart';

class WouterConfig extends RouterConfig<String> {
  WouterConfig({
    required BehaviorSubject<String> pathSubject,
    required BehaviorSubject<WouterActions> actionsSubject,
    required WidgetBuilder builder,
  }) : super(
          routerDelegate: WouterRouterDelegate(
            pathSubject: pathSubject,
            actionsSubject: actionsSubject,
            builder: builder,
          ),
          backButtonDispatcher: WouterBackButtonDispatcher(
            onPop: () => actionsSubject.valueOrNull?.pop() ?? false,
          ),
          routeInformationParser: const WouterRouteInformationParser(),
          routeInformationProvider: WouterRouteInformationProvider(
            onGetRoute: () => pathSubject.valueOrNull ?? "",
          ),
        );
}

class WouterConfigBuilder {
  final WidgetBuilder builder;

  WouterConfigBuilder({
    required this.builder,
  });

  RouterConfig<String> build() {
    final pathSubject = BehaviorSubject<String>();
    final actionsSubject = BehaviorSubject<WouterActions>();

    return WouterConfig(
      pathSubject: pathSubject,
      actionsSubject: actionsSubject,
      builder: (context) => _DisposeHandler(
        onDispose: () {
          pathSubject.close();
          actionsSubject.close();
        },
        child: builder(context),
      ),
    );
  }
}

class _DisposeHandler extends StatefulWidget {
  final VoidCallback onDispose;
  final Widget child;

  const _DisposeHandler({
    required this.onDispose,
    required this.child,
  });

  @override
  State<_DisposeHandler> createState() => _DisposeHandlerState();
}

class _DisposeHandlerState extends State<_DisposeHandler> {
  @override
  void dispose() {
    widget.onDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
