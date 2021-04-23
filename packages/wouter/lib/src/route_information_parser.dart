import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Converts [RouteInformation] to [Uri] and vice-versa.
class WouterRouteInformationParser extends RouteInformationParser<Uri> {
  const WouterRouteInformationParser() : super();

  @override
  SynchronousFuture<Uri> parseRouteInformation(
    RouteInformation routeInformation,
  ) =>
      SynchronousFuture(Uri.parse(routeInformation.location ?? '/'));

  @override
  RouteInformation restoreRouteInformation(Uri uri) => RouteInformation(
        location: uri.toString(),
      );
}
