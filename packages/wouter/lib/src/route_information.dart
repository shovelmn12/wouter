import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Converts [RouteInformation] to [Uri] and vice-versa.
class WouterRouteInformationParser extends RouteInformationParser<String> {
  const WouterRouteInformationParser() : super();

  @override
  SynchronousFuture<String> parseRouteInformation(
    RouteInformation routeInformation,
  ) =>
      SynchronousFuture("${routeInformation.uri}");

  @override
  RouteInformation restoreRouteInformation(String uri) => RouteInformation(
        uri: Uri.parse(uri),
      );
}

class WouterRouteInformationProvider extends RouteInformationProvider
    with ChangeNotifier {
  final ValueGetter<String> onGetRoute;

  WouterRouteInformationProvider({
    required this.onGetRoute,
  });

  @override
  RouteInformation get value => RouteInformation(
        uri: Uri.parse(onGetRoute()),
      );
}
