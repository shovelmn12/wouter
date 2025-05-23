import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// A callback function type used for custom parsing of [RouteInformation]
/// into a route path string.
///
/// It receives the current [BuildContext] and the [RouteInformation] object
/// provided by the platform (e.g., from the web browser's address bar or
/// an Android deep link).
///
/// It should return a [String] representing the parsed route path that your
/// Wouter routing logic will use. This allows for context-dependent parsing,
/// such as extracting information from services available via [BuildContext]
/// or applying locale-specific transformations.
///
/// Example:
/// ```dart
/// String myCustomParser(BuildContext context, RouteInformation routeInfo) {
///   // Potentially use context for locale or other services
///   // final locale = Localizations.localeOf(context);
///   if (routeInfo.uri.path.startsWith('/special/')) {
///     return '/transformed${routeInfo.uri.path}';
///   }
///   return routeInfo.uri.path;
/// }
/// ```
typedef WouterParseRouteInformationCallback = String Function(
  BuildContext,
  RouteInformation,
);

/// A [RouteInformationParser] for the Wouter routing package.
///
/// This class is responsible for the two-way conversion between the platform's
/// [RouteInformation] (typically representing a URL) and a `String`
/// configuration used internally by Wouter to represent the current route path.
///
/// It plays a crucial role in integrating Wouter with Flutter's declarative
/// navigation system (`Router` widget).
///
/// - When the platform reports a new route (e.g., user types a URL in the browser,
///   or an initial deep link is received), Flutter's `Router` calls
///   [parseRouteInformationWithDependencies] (or [parseRouteInformation])
///   to convert the platform's [RouteInformation] into a Wouter-understandable
///   `String` path.
/// - When Wouter navigates and needs to update the platform's representation
///   (e.g., update the browser's URL), [restoreRouteInformation] is called
///   with the Wouter path string to generate the corresponding [RouteInformation].
class WouterRouteInformationParser extends RouteInformationParser<String> {
  /// An optional callback for custom route parsing logic.
  ///
  /// If provided, this function will be invoked by
  /// [parseRouteInformationWithDependencies] to convert the incoming
  /// [RouteInformation] into a path string. This allows for advanced
  /// parsing scenarios that might require access to [BuildContext].
  final WouterParseRouteInformationCallback? parse;

  /// Creates an instance of [WouterRouteInformationParser].
  ///
  /// - [parse]: An optional [WouterParseRouteInformationCallback] to customize
  ///   how [RouteInformation] is converted to a path string. If `null`,
  ///   the default behavior is to use `routeInformation.uri.path`.
  const WouterRouteInformationParser({
    this.parse,
  }) : super();

  /// Parses the given [RouteInformation] from the platform into a route path string.
  ///
  /// By default, this method extracts the `path` component from the
  /// `routeInformation.uri`. For example, if `routeInformation.uri` is
  /// `Uri.parse("https://example.com/users/123?tab=profile#details")`,
  /// this method will return `"/users/123"`.
  ///
  /// This method is typically called by the Flutter framework if
  /// [parseRouteInformationWithDependencies] is not overridden or if
  /// the custom [parse] callback is not provided when using
  /// [parseRouteInformationWithDependencies].
  ///
  /// It returns a [SynchronousFuture] as the parsing is immediate.
  @override
  Future<String> parseRouteInformation(
    RouteInformation routeInformation,
  ) =>
      SynchronousFuture(routeInformation.uri.path);

  /// Converts a route path string (the `configuration`) back into [RouteInformation].
  ///
  /// This method is called by the Flutter framework when it needs to update
  /// the platform's route representation (e.g., updating the browser's URL bar)
  /// based on the internal Wouter path string.
  ///
  /// It constructs [RouteInformation] by parsing the `configuration` string
  /// as a [Uri]. For example, if `configuration` is `"/products/shoes"`,
  /// it creates `RouteInformation(uri: Uri.parse("/products/shoes"))`.
  @override
  RouteInformation restoreRouteInformation(String configuration) =>
      RouteInformation(
        uri: Uri.parse(configuration),
      );

  /// Parses [RouteInformation] into a route path string, with access to [BuildContext].
  ///
  /// This method is the preferred way for the Flutter framework to parse route
  /// information when context-dependent logic might be needed.
  ///
  /// If a custom [parse] callback was provided to the constructor, this method
  /// will invoke that callback, passing the `context` and `routeInformation`.
  /// This allows for sophisticated parsing strategies that might, for instance,
  /// depend on services, localization, or other data available from the `BuildContext`.
  ///
  /// If no custom [parse] callback is provided, this method falls back to the
  /// default behavior of [parseRouteInformation], which simply extracts the
  /// path from `routeInformation.uri`.
  ///
  /// It returns a [SynchronousFuture] as the parsing (whether custom or default)
  /// is expected to be immediate.
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
