import 'package:wouter/wouter.dart';
// The following are assumed to be defined in `regexp.dart` or elsewhere in wouter:
// - regexpPathMatcher: The core function that performs matching using a RegexpBuilder.
// - pathToRegexp: A specific RegexpBuilder implementation.
// - cacheRegexpBuilder: A function that wraps a RegexpBuilder to add caching for compiled regexps.
// - cache: A higher-order function that caches the results of a PathMatcher function.

export 'regexp.dart'; // Exports symbols from regexp.dart, likely including the above.

/// A utility class providing factory methods for creating [PathMatcher] instances.
///
/// Path matchers are functions responsible for determining if a given URL path
/// matches a specified route pattern and extracting any parameters from the path.
///
/// This class offers pre-configured path matchers, typically based on regular
/// expressions, with options for caching to improve performance.
abstract class PathMatchers {
  /// Private constructor to prevent instantiation of this utility class.
  const PathMatchers._();

  /// Creates a [PathMatcher] that uses regular expressions for matching.
  ///
  /// Each time this matcher is called, it will compile the `pattern` into a
  /// regular expression using the [pathToRegexp] builder and then perform
  /// the match against the `path`.
  ///
  /// - [path]: The actual URL path string to be matched.
  /// - [pattern]: The route pattern (e.g., `/users/:id`) against which the
  ///   `path` is compared.
  /// - [prefix]: If `true` (default), the `pattern` should match only the
  ///   beginning of the `path`. If `false`, the `pattern` must match the
  ///   entire `path`.
  ///
  /// Returns a [MatchData] object if the path matches the pattern,
  /// otherwise `null`.
  static PathMatcher regexp() => (
        String path,
        String pattern, {
        bool prefix = true,
      }) =>
          regexpPathMatcher(
            path,
            pattern,
            regexpBuilder:
                pathToRegexp, // Uses the standard pathToRegexp builder
            prefix: prefix,
          );

  /// Creates a [PathMatcher] that uses regular expressions with caching mechanisms
  /// for improved performance.
  ///
  /// This matcher employs two levels of caching:
  /// 1.  **RegExp Caching**: The [RegexpBuilder] itself ([pathToRegexp]) is wrapped
  ///     by [cacheRegexpBuilder]. This means that once a route `pattern` is
  ///     compiled into a regular expression, that compiled `RegExp` is cached
  ///     and reused for subsequent matches against the same `pattern`. This avoids
  ///     the cost of recompiling the regex repeatedly.
  /// 2.  **Match Result Caching**: The entire path matching function (the lambda
  ///     returned here) is wrapped by `cache`. This means that the result
  ///     ([MatchData] or `null`) of matching a specific `path` against a
  ///     specific `pattern` (with a given `prefix` value) is cached. If the
  ///     same `path`, `pattern`, and `prefix` are encountered again, the cached
  ///     result is returned directly without re-evaluating the match.
  ///
  /// This is generally the recommended matcher for production use due to its
  /// performance benefits, especially in applications with many routes or
  /// frequent navigation.
  ///
  /// - [path]: The actual URL path string to be matched.
  /// - [pattern]: The route pattern.
  /// - [prefix]: If `true` (default), the `pattern` matches the prefix of `path`.
  ///
  /// Returns a [MatchData] object if the path matches, otherwise `null`.
  static PathMatcher cachedRegexp() {
    // Create a RegExp builder that caches compiled regular expressions.
    final regexpBuilder = cacheRegexpBuilder(pathToRegexp);

    // Return a PathMatcher that caches the results of (path, pattern, prefix) lookups.
    return cache((
      String path,
      String pattern, {
      bool prefix = true,
    }) =>
        regexpPathMatcher(
          path,
          pattern,
          regexpBuilder: regexpBuilder, // Uses the cached RegExp builder
          prefix: prefix,
        ));
  }
}
