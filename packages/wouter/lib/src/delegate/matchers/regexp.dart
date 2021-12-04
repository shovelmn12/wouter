import 'package:path_to_regexp/path_to_regexp.dart';

import '../../models/models.dart';

RegexpBuilder pathToRegexpCache(RegexpBuilder builder) {
  final Map<String, RegexpData?> cache = {};

  return (
    String pattern, {
    bool caseSensitive = false,
    bool prefix = false,
  }) =>
      cache['$pattern-$caseSensitive-$prefix'] ??= builder(
        pattern,
        caseSensitive: caseSensitive,
        prefix: prefix,
      );
}

RegexpData pathToRegexp(
  String pattern, {
  bool caseSensitive = false,
  bool prefix = false,
}) {
  final parameters = <String>[];
  final regexp = pathToRegExp(
    pattern,
    parameters: parameters,
    caseSensitive: caseSensitive,
    prefix: prefix,
  );

  return RegexpData(
    regexp: regexp,
    parameters: parameters,
  );
}

MatchData? regexpPathMatcher(
  String path,
  String pattern, {
  RegexpBuilder regexpBuilder = pathToRegexp,
  bool prefix = true,
}) {
  final endsWithSlash = pattern.endsWith("/") || pattern.endsWith("/:_(.*)");
  final data = regexpBuilder(
    pattern,
    caseSensitive: false,
    prefix: prefix,
  );
  final regexp = data.regexp;
  final parameters = data.parameters;
  final match = regexp.matchAsPrefix(
    endsWithSlash ? (path.endsWith("/") ? path : "$path/") : path,
  );

  if (match != null) {
    final arguments = extract(parameters, match);
    final toPath = pathToFunction(pattern);

    return MatchData(
      path: toPath(arguments),
      arguments: arguments,
    );
  }
}
