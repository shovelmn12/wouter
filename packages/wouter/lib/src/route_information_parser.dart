import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Converts [RouteInformation] to [Uri] and vice-versa.
class WouterRouteInformationParser extends RouteInformationParser<Uri> {
  const WouterRouteInformationParser() : super();

  @override
  SynchronousFuture<Uri> parseRouteInformation(
    RouteInformation routeInformation,
  ) {
    print('parseRouteInformation ${routeInformation.location}');
    return SynchronousFuture(Uri.parse(routeInformation.location ?? '/'));
  }

  @override
  RouteInformation restoreRouteInformation(Uri configuration) {
    print('restoreRouteInformation $configuration');
    return RouteInformation(
      location: configuration.toString(),
    );
  }
}
