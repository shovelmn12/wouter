import 'package:wouter/wouter.dart';

export 'regexp.dart';

abstract class PathMatchers {
  const PathMatchers._();

  static PathMatcher regexp() => (
        String path,
        String pattern, {
        bool prefix = true,
      }) =>
          regexpPathMatcher(
            path,
            pattern,
            regexpBuilder: pathToRegexp,
            prefix: prefix,
          );

  static PathMatcher cachedRegexp() {
    final regexpBuilder = cached(pathToRegexp);

    return (
      String path,
      String pattern, {
      bool prefix = true,
    }) =>
        regexpPathMatcher(
          path,
          pattern,
          regexpBuilder: regexpBuilder,
          prefix: prefix,
        );
  }
}
