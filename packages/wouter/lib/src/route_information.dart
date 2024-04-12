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
  RouteInformation restoreRouteInformation(String configuration) =>
      RouteInformation(
        uri: Uri.parse(configuration),
      );
}
