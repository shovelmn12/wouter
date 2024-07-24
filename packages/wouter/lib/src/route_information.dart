import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

typedef WouterParseRouteInformationCallback = String Function(
  BuildContext,
  RouteInformation,
);

/// Converts [RouteInformation] to [Uri] and vice-versa.
class WouterRouteInformationParser extends RouteInformationParser<String> {
  final WouterParseRouteInformationCallback? parse;

  const WouterRouteInformationParser({
    this.parse,
  }) : super();

  @override
  Future<String> parseRouteInformation(
    RouteInformation routeInformation,
  ) =>
      SynchronousFuture(routeInformation.uri.path);

  @override
  RouteInformation restoreRouteInformation(String configuration) =>
      RouteInformation(
        uri: Uri.parse(configuration),
      );

  @override
  Future<String> parseRouteInformationWithDependencies(
    RouteInformation routeInformation,
    BuildContext context,
  ) {
    if (parse != null) {
      return SynchronousFuture(parse!(context, routeInformation));
    }

    return parseRouteInformation(routeInformation);
  }
}
