import 'package:path_to_regexp/path_to_regexp.dart';
import 'package:wouter/wouter.dart';

// Assuming RegexpData is a class like:
// class RegexpData {
//   final RegExp regexp;
//   final List<String> parameters;
//   RegexpData({required this.regexp, required this.parameters});
// }

/// Creates a cached version of a [RegexpBuilder].
///
/// This higher-order function takes a [RegexpBuilder] and returns a new
/// [RegexpBuilder] that caches the results of the original builder.
/// The cache key is generated from the `pattern`, `caseSensitive`, and `prefix`
/// arguments.
///
/// This is useful for avoiding the cost of recompiling the same route patterns
/// into regular expressions multiple times.
///
/// - [builder]: The original [RegexpBuilder] whose results are to be cached.
///
/// Returns a new [RegexpBuilder] that uses an internal cache.
RegexpBuilder cacheRegexpBuilder(RegexpBuilder builder) {
  // Internal cache storing RegexpData associated with a composite key.
  final Map<String, RegexpData?> cache = {};

  return (
    String pattern, {
    bool caseSensitive = false,
    bool prefix = false,
  }) {
    // Create a unique key for the cache based on pattern and options.
    final cacheKey = '$pattern-$caseSensitive-$prefix';
    // If the key exists in cache, return the cached RegexpData.
    // Otherwise, call the original builder, store its result in cache, and then return it.
    return cache[cacheKey] ??= builder(
      pattern,
      caseSensitive: caseSensitive,
      prefix: prefix,
    );
  };
}

/// Creates a cached version of a [PathMatcher].
///
/// This higher-order function takes a [PathMatcher] and returns a new
/// [PathMatcher] that caches the results ([MatchData] or `null`) of the
/// original matcher. The cache key is generated from the `path`, `pattern`,
/// and `prefix` arguments.
///
/// This helps to avoid re-evaluating path matches for the same inputs,
/// which can improve performance in applications with frequent route lookups.
///
/// - [builder]: The original [PathMatcher] whose results are to be cached.
///
/// Returns a new [PathMatcher] that uses an internal cache.
PathMatcher cache(PathMatcher builder) {
  // Internal cache storing MatchData associated with a composite key.
  final Map<String, MatchData?> cache = {};

  return (
    String path,
    String pattern, {
    bool prefix = false,
  }) {
    // Create a unique key for the cache.
    final cacheKey = '$pattern-$path-$prefix';
    // If the key exists in cache, return the cached MatchData.
    // Otherwise, call the original builder, store its result in cache, and then return it.
    return cache[cacheKey] ??= builder(
      path,
      pattern,
      prefix: prefix,
    );
  };
}

/// A [RegexpBuilder] that converts a route [pattern] string (like "/users/:id")
/// into [RegexpData], which includes the compiled [RegExp] and a list of
/// extracted parameter names.
///
/// This function uses the `path_to_regexp` package internally.
///
/// - [pattern]: The route pattern string.
/// - [caseSensitive]: Whether the resulting [RegExp] should be case-sensitive.
///   Defaults to `false`.
/// - [prefix]: Whether the [RegExp] should match from the beginning of the string
///   (i.e., as a prefix). Defaults to `false` in this direct call, but often
///   controlled by the consuming [PathMatcher].
///
/// Returns [RegexpData] containing the compiled [RegExp] and parameter names.
RegexpData pathToRegexp(
  String pattern, {
  bool caseSensitive = false,
  bool prefix = false,
}) {
  final parameters = <String>[];
  // Uses the pathToRegExp function from the imported 'package:path_to_regexp'.
  final regexp = pathToRegExp(
    pattern,
    parameters: parameters, // List to be populated with parameter names
    caseSensitive: caseSensitive,
    prefix: prefix,
    // Other options like `end`, `strict` can be configured if needed.
  );

  return RegexpData(
    regexp: regexp,
    parameters: parameters,
  );
}

/// A [PathMatcher] implementation that uses regular expressions to match a
/// [path] against a [pattern].
///
/// It utilizes a [RegexpBuilder] (defaults to [pathToRegexp]) to compile
/// the `pattern` into a regular expression and then attempts to match it
/// against the given `path`.
///
/// Special handling is included for patterns ending with a slash to ensure
/// consistent matching behavior whether or not the input `path` has a trailing slash.
///
/// If a match is successful, it extracts path parameters and reconstructs the
/// matched portion of the path using `pathToFunction` (from `path_to_regexp`)
/// to ensure the `MatchData.path` is canonical.
///
/// - [path]: The actual URL path to match.
/// - [pattern]: The route pattern string.
/// - [regexpBuilder]: The [RegexpBuilder] used to compile the `pattern`.
///   Defaults to [pathToRegexp].
/// - [prefix]: Whether the pattern should match as a prefix of the `path`.
///   Defaults to `true`.
///
/// Returns [MatchData] if a match is found, otherwise `null`.
MatchData? regexpPathMatcher(
  String path,
  String pattern, {
  RegexpBuilder regexpBuilder = pathToRegexp,
  bool prefix = true,
}) {
  // Check if the pattern indicates it expects a trailing slash.
  // This includes patterns like "/foo/" or "/foo/:_(.*)" (common for wildcard/spa fallbacks).
  final endsWithSlash = pattern.endsWith("/") || pattern.endsWith("/:_(.*)");

  // Compile the pattern into RegexpData using the provided or default builder.
  // Case sensitivity is hardcoded to false here for common web behavior.
  final data = regexpBuilder(
    pattern,
    caseSensitive: false, // Usually, route matching is case-insensitive.
    prefix: prefix,
  );
  final regexp = data.regexp;
  final parameters = data.parameters;

  // Adjust the path for matching if the pattern expects a trailing slash
  // but the path doesn't have one.
  final pathToMatch =
      endsWithSlash ? (path.endsWith("/") ? path : "$path/") : path;

  // Attempt to match the regexp as a prefix against the (potentially adjusted) path.
  final match = regexp.matchAsPrefix(pathToMatch);

  if (match != null) {
    // If a match is found, extract parameters using the list from RegexpData.
    final arguments = extract(parameters, match);
    // Reconstruct the matched path using the original pattern and extracted arguments.
    // This ensures the MatchData.path is normalized according to the pattern.
    final toPath = pathToFunction(pattern);

    return MatchData(
      path: toPath(arguments),
      arguments: arguments,
    );
  }

  // No match found.
  return null;
}
